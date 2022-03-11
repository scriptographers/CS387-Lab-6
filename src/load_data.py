import os
import csv

TABLES = ["contains", "follows", "hashtags", "mentions", "sent", "tweets", "users"]

NODES = {
    "User" : {"csv" : "users", "attr" : "name"}, 
    "Tweet" : {"csv" : "tweets", "attr" : "text"}, 
    "Hashtag":  {"csv" : "hashtags", "attr" : "tag"}, 
}

RELS = {
    "MENTIONS" : {"csv" : "mentions", "between" : ("Tweet", "User")}, 
    "SENT" : {"csv" : "sent", "between" : ("User", "Tweet")}, 
    "CONTAINS" : {"csv" : "contains", "between" : ("Tweet", "Hashtag")}, 
    "FOLLOWS" : {"csv" : "follows", "between" : ("User", "User")}
}

ID2VAL = {
    "User" : {},
    "Tweet" : {},
    "Hashtag" : {}
}

def createNodes(f, path_base):
    
    for node in sorted(NODES.keys()):

        table = NODES[node]["csv"]
        attr = NODES[node]["attr"]
        fpath = os.path.join(path_base, table + ".csv")

        with open(fpath, "r") as c:
            
            reader = csv.reader(c)
            next(reader)

            values = []
            for row in reader:
                idx = int(row[0])
                val = row[1]
                ID2VAL[node][idx] = val
                stmt = f"CREATE ({node.lower()}_{idx}:{node} {{ {attr} : \"{val}\" }});"    
                f.write(stmt)
                f.write("\n")
            f.write("\n")
        f.write("\n")
        

def createRelations(f, path_base):

    for rel in sorted(RELS.keys()):

        between = RELS[rel]["between"]
        table = RELS[rel]["csv"]
        fpath = os.path.join(path_base, table + ".csv")

        with open(fpath, "r") as c:
            
            reader = csv.reader(c)
            next(reader)

            values = []
            for i, row in enumerate(reader):

                node1 = between[0]
                node2 = between[1]
                
                node1_id = int(row[0])
                node2_id = int(row[1])

                node1_val = ID2VAL[node1][node1_id]
                node2_val = ID2VAL[node2][node2_id]

                node1_attr = NODES[node1]["attr"]
                node2_attr = NODES[node2]["attr"]

                stmt = f"MATCH (a:{node1}), (b:{node2}) WHERE a.{node1_attr} = \"{node1_val}\" AND b.{node2_attr} = \"{node2_val}\" CREATE (a)-[{rel.lower()}_{i}:{rel}]->(b);\n"    
                f.write(stmt)
            
            f.write("\n")
        f.write("\n")

if __name__ == "__main__":

    path_data = "."
    path_create_queries = "create_queries.txt"

    with open(path_create_queries, "w+") as f:

        # Delete all nodes/relationships present
        f.write("MATCH (n) DETACH DELETE n;\n\n")

        createNodes(f, path_data)
        createRelations(f, path_data)
