(class +Poem +Entity)
   (rel title (+Sn +IdxFold +String))
   (rel poet (+Sn +IdxFold +String))
   (rel txt (+IdxFold +String))
   (rel date (+Ref +Date))

(dm url> (Tab)
   (list "!show-poems2" '*ID This) )
