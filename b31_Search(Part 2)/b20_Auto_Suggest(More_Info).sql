

  # Edge ngrams
    - Is a variant of the n-grams in the snapshot, which only has starting prefix in n-gram
      #41

  # Process to create n-grams
    1. Create a custom analyzer #41
      - In the example, we have an analyzer called 'autocomplete'
    2. Use the custom analyzer during index time
    3. Use the Standard analyzer during query time
