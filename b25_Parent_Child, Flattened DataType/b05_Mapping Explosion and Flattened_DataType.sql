

  # 26
  + Problem

    - Index with large no of fields leads to performance degradation or worst case
      crash of the system (Aka Mapping explosion)

  + Solution

    - Use Flattened Data type
      . If a field contain inner fields, the flat data type maps the
        parent fields as single type named flattened...and the inner
        fields do not appear in the mappings (which reduces the total no of mapping in the index)


  + Demerits of Flattened data type

    - Fields of the flattened nested fields will be treated as 'keywords' (so cannot be used for analyzer)
                                                               (So limited search capability)
    - Searching outer fields also searches the inner fields
    - ElasticSearches result highlighting feature will not be enabled for those fields
      (Usually helps show the users where the query matches are)