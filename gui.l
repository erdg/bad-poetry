(de nav ()
   (<div> 'nav
      (<ul> NIL
         (<li> NIL (<href> "Share a Poem" "!create-poems"))
         (<li> NIL (<href> "Search for Poems" "!search-poems")) ) ) )

(de work ()
   (app)
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (<h1> NIL "Bad Poetry")
         (<h3> NIL "Because the World Needs It") ) ) )

(de create-poems ()
   (app)
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (<h1> NIL "Poem Creation Station")
         (form NIL 
            (<grid> 2
               "Title" (gui '(+Var +TextField) 'poem-title* 30 )
               "Pen Name" (gui '(+Var +Cue +TextField) 'poem-poet* "Tag your poem with an alias" 30 )
               "Poem" (gui '(+Var +Cue +TextField) 'poem-txt* "Bad poetry goes here" 30 6 ) )
            (gui '(+Button) "Publish your bad poem"
               '(new! '(+Poem) 'title poem-title* 'poet poem-poet* 'txt poem-txt*) ) ) ) ) )

(de search-poems (Dst)
   (app)
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (form NIL
   (diaform '(Dst)
      (<grid> 3
         "Title" (gui 'title '(+Var +DbHint +TextField) 'poem-title* '(title +Poem) 30)
         (searchButton '(init> (: home query)))
         "Poet" (gui 'poet '(+Var +DbHint +TextField) 'poem-poet* '(poet +Poem) 30)
         (resetButton '(title poet txt query))
         "Prose" (gui 'txt '(+Var +TextField) 'poem-txt* 30) )
      (gui 'query '(+QueryChart) (cho)
         '(goal 
            (quote
               @Title poem-title*
               @Poet  poem-poet*
               @Txt   poem-txt*
               (select (@@)
                  ((title +Poem @Title) (poet +Poem @Poet) (txt +Poem @Txt))
                  (tolr @Title @@ title)
                  (tolr @Poet @@ poet)
                  (part @Txt @@ txt) ) ) )
         2
         '((This) (list This (: poet))) )
      (<table> NIL "Relevant Poems"
         (quote
            (NIL "Title")
            (NIL "Poet") )
         (do (cho)
            (<row> NIL
               (gui 1 '(+ObjView +TextField) '(: title))
               (gui 2 '(+TextField)) ) ) )
      (<spread> 
         (scroll (cho)) ) ) ) ) ) )

(de show-poems ()
   (app)
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (idForm "Poem" '(search-poems) 'title '+Poem NIL NIL '((: title))
            (<grid> 2
               "Title" (gui '(+E/R +TextField) '(title : home obj)  30)
               "Poet" (gui '(+E/R +TextField) '(poet : home obj) 30)
               "Poem" (gui '(+E/R +TextField) '(txt : home obj) 30 6) ) ) ) ) )

