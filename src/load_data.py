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
                idx = row[0]
                val = row[1]
                stmt = f"CREATE ({node.lower()}_{idx}:{node} {{ {attr} : \"{val}\", id : {idx} }});"    
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

                node1 = f"{between[0].lower()}_{row[0]}"
                node2 = f"{between[1].lower()}_{row[1]}"

                node1_type = between[0]
                node2_type = between[1]
                node1_id = row[0]
                node2_id = row[1]

                stmt = f"MATCH (a:{node1_type}), (b:{node2_type}) WHERE a.id = {node1_id} AND b.id = {node2_id} CREATE (a)-[{rel.lower()}_{i}:{rel}]->(b);"    
                f.write(stmt)
                f.write("\n")
            f.write("\n")
        f.write("\n")

if __name__ == "__main__":

    path_data = "data"
    path_create_queries = "create_queries.txt"

    with open(path_create_queries, "w+") as f:
        createNodes(f, path_data)
        createRelations(f, path_data)
