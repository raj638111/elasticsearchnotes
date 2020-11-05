
-- Field Type & Analyzer

  + 'text' type field
    - Analyzer is applied only on text type field

  + 'keyword' type field
    - Analyzer is NOT applied on 'keyword' type
    - These types of field can have exact, case-sensitive match


-- Analyzer can do,


  # Stemming
    + Normalizes set of words into one
      (Example: If we want boxes, boxing, box to all match for the search box)

  # synonyms
    + If we want the search for 'big' turns up also documents with word 'large'


  # stop word
    + If we want to save space by avoiding indexing words like 'the', 'and', 'in' etc...
    + Recommended not use; if we are doing phrase search
      - Example: 'to be or not to be'


