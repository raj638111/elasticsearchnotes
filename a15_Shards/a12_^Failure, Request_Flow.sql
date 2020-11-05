

-- What happens on failure?

  + A replica shard would be made Primary

-- Request Flow (Write Request)

  # 10

  + S1: ES receives the request
    - Would be a good idea to send the requests Robin Robin to avoid
      overloading a specific Node

  + S2: Routing to specific Primary
    - Request routed to the specific Primary Shard based on the Hash(??)
    - Document written in that Node ?? Is this right? #10
    - Index written to the Primary Shard
    - Index gets replicated

-- Good practice

  + More replicas increase the read capacity of the cluster

