(de nav ()
   (<div> 'nav-collapse
      (<ul> NIL
         (<li> NIL (<href> "Share a Poem" "!create-poems"))
         (<li> NIL (<href> "Search for Poems" "!search-poems")) ) ) )

(de work ()
   (app)
   (action
      (html 0 "Bad Poetry" *Css NIL
         (nav)
         (----)
         (<h1> NIL "Bad Poetry")
         (<h3> NIL "Because the World Needs It")
         (javascript NIL
            "var nav = responsiveNav('.nav-collapse');" ) ) ) )



(de create-poems ()
   (action
      (html 0 "Bad Poetry" *Css NIL  
         (nav)
         (----)
         (<h1> NIL "Poem Creation Station")
         (form NIL 
            (capture-poems)
            (publish-button) )
         (javascript NIL
            "var nav = responsiveNav('.nav-collapse', {
               animate: true,
               transition: 284,
               label: 'Bad Poetry',
               insert: 'before'
            });" ) ) ) )

(de capture-poems ()
   (<div> NIL # for CSS, later
      (<grid> 2
         "Title"
            (gui '(+Var +Cue +TextField)
               'title*
               "Catchy title"
               30 )
         "Alias"
            (gui '(+Var +Cue +TextField)
               'poet*
               "Tag your work"
               30 )
         "Poetry"
            (gui '(+Var +Cue +TextField)
               'txt*
               "Bad poetry here"
               60 10 ) ) ) )

(de publish-button ()
   (gui '(+Button) "Publish bad poetry"
      '(prog
         (new! '(+Poem) 
            'title title*
            'poet  poet*
            'txt   txt*
            'date  (date) )
         (off title* poet* txt*)
         (setq *Url "!published") ) ) )

(de published ()
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (<h1> NIL "Congratulations!")
         (<p> NIL "Your poetry has been published!") ) ) )





(de search-poems (Dst)
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
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (idForm "Poem" '(search-poems) 'title '+Poem NIL NIL '((: title))
            (<grid> 2
               "Title" (gui '(+E/R +TextField) '(title : home obj)  30)
               "Poet" (gui '(+E/R +TextField) '(poet : home obj) 30)
               "Poem" (gui '(+E/R +TextField) '(txt : home obj) 30 6) ) ) ) ) )


(de show-poems2 ()
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (form NIL
            (<h1> NIL (<id> (: title)))
            (<h3> NIL (<id> (: poet)))
            (<p> NIL (<id> (: txt))) 
            (<p> NIL (<id> (: date)))
            (stepBtn 'title '+Poem) ) ) ) )
