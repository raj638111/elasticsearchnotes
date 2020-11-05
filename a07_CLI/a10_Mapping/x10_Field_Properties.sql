

-- mappings._source.enabled
  (true false)

  + _source field contains the original JSON document body that was passed
    at index time

  + The _source field itself is not indexed (and thus is not searchable),
    but it is stored so that it can be returned when executing fetch requests,
    like get or search


  https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-source-field.html
        

-- mappings.properties.x.store
  (true / false)

  + By default, field values are indexed to make them searchable,
    but they are not stored. This means that the field can be queried,
    but the original field value cannot be retrieved

    - Usually this doesn’t matter. The field value is already part of
      the _source field,which is stored by default


  https://www.elastic.co/guide/en/elasticsearch/reference/5.1/mapping-store.html#mapping-store
