(de nav ()
   (<div> "header pink-bg"
      (<style> 'logo
         (<href> "Bad Poetry" "!work") )
      (<div> 'nav-collapse
         (<ul> NIL
            (<li> NIL (<href> "Share a Poem" "!create-poems"))
            (<li> NIL (<href> "Search for Poems" "!search-poems")) ) ) ) )

(de nav-js ()
   (javascript NIL
            "var nav = responsiveNav('.nav-collapse', {
               animate: true,
               transition: 284,
               label: 'bad poetry',
               insert: 'before'
            });" ) )

(de fixed-nav-scripts ()
   (javascript "js/fixed-responsive-nav.js")
   (javascript "js/fastclick.js") )

(de work ()
   (app)
   (action
      (html 0 "Bad Poetry" *Css "landing-page yellow-bg"
         (nav)
         (<div> 'center-in-viewport
            (<h1> 'pink "bad")
            (<h1> 'white "poetry") )
         (<div> 'mask NIL)
         (fixed-nav-scripts)
         (nav-js) ) ) )



(de create-poems ()
   (action
      (html 0 "Create Poetry" *Css NIL  
         (nav)
         (<h1> 'nav-padding "Poem Creation Station")
         (form 'center-in-viewport 
            (capture-poems)
            (publish-button) )
         (fixed-nav-scripts) 
         (nav-js) ) ) )


(de capture-poems ()
   (<div> 'row # for CSS, later
      (gui '(+Style +Var +Cue +TextField)
         'col
         'title*
         "Catchy title"
         30 )
      (gui '(+Style +Var +Cue +TextField)
         'col
         'poet*
         "Tag your work"
         30 ) )
   (gui '(+Var +Cue +TextField)
      'txt*
      "Bad poetry here"
      60 10 ) )


(de publish-button ()
   (<div> 'row
   (gui '(+Style +Button) 
      "col btn btn-b btn-sm smooth" 
      "Publish bad poetry"
      '(prog
         (new! '(+Poem) 
            'title title*
            'poet  poet*
            'txt   txt*
            'date  (date) )
         (off title* poet* txt*)
         (setq *Url "!published") ) ) ) )


(de published ()
   (action
      (html 0 "Bad Poetry" "@lib.css" NIL
         (nav)
         (<h1> NIL "Congratulations!")
         (<p> NIL "Your poetry has been published!")
         (nav-js) ) ) )


(de search-poems (Dst)
   (action
      (html 0 "Search Poetry" *Css NIL
         (nav)
         (form 'nav-padding
            (diaform '(Dst)
               (gui 'title '(+Var +DbHint +Cue +TextField) 
                  'poem-title* 
                  '(title +Poem) 
                  "Title"
                  30 )
               (gui 'poet '(+Var +DbHint +Cue +TextField) 
                  'poem-poet* 
                  '(poet +Poem) 
                  "Poet"
                  30 )
               (gui 'txt '(+Var +Cue +TextField) 
                  'poem-txt* 
                  "Text" 30) 
               (<div> 'row
                  (<style> "col btn btn-classless btn-sm smooth"
                     (searchButton '(init> (: home query))) )
                  (<style> "col btn btn-classless btn-sm smooth"
                     (resetButton '(title poet txt query)) ) )
               (gui 'query '(+QueryChart) 8 
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
               (<table> 'table "Relevant Poems"
                  (quote
                     (NIL "Title")
                     (NIL "Poet") )
                  (do 8 
                     (<row> NIL
                        (gui 1 '(+ObjView +TextField) '(: title))
                        (gui 2 '(+TextField)) ) ) )
               (<spread> 
                  (scroll 8) ) ) )
         (nav-js) ) ) )

(de show-poems ()
   (action
      (html 0 "Bad Poetry" *Css NIL
         (nav)
         (idForm "Poem" '(search-poems) 'title '+Poem NIL NIL '((: title))
            (<grid> 2
               "Title" (gui '(+E/R +TextField) '(title : home obj)  30)
               "Poet" (gui '(+E/R +TextField) '(poet : home obj) 30)
               "Poem" (gui '(+E/R +TextField) '(txt : home obj) 30 6) ) ) ) ) )


(de show-poems2 ()
   (action
      (html 0 "View Poetry" *Css NIL
         (nav)
         (form 'center-in-viewport
            (<h1> NIL (<id> (: title)))
            (<h3> NIL (<id> (: poet)))
            (<p> NIL (<id> (: txt))) 
            (<p> NIL (<id> (: date)))
            (stepBtn 'title '+Poem) )
         (nav-js) ) ) )
