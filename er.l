(class +Poem +Entity)
   (rel title (+Sn +IdxFold +String))
   (rel poet (+Sn +IdxFold +String))
   (rel txt (+IdxFold +String))

(dm url> (Tab)
   (list "!show-poems" '*ID This) )
