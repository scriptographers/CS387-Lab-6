// Names of 5 least followed users and the followers count in ascending order

call{
    match (su1:User)-[:FOLLOWS]->(su2:User)
    with su2, count(su1) as cnt
    order by cnt asc, su2.name asc
    return su2.name as users, cnt
    union all
    with [(su1:User)-[:FOLLOWS]->(su2:User) | su2.name] as hf
    unwind(hf) as uhf
    with collect(distinct uhf) as dhf
    match (u:User) where not u.name in dhf
    return u.name as users, 0 as cnt
}
return users, cnt order by cnt limit 5;