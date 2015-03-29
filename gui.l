(de nav ()
   (<div> "header pink-bg"
      (<style> 'logo
         (<href> "Bad Poetry" "!work") )
      (<div> 'nav-collapse
         (<ul> NIL
            (<li> NIL (<href> "write poetry" "!create-poems"))
            (<li> NIL (<href> "find poetry" "!search-poems")) ) ) ) )

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



[de create-poems ()
   (action
      (html 0 "Write Poetry" *Css NIL  
         (nav) 
         (<div> "container nav-padding"
            (<h1> "ta-c"
               "Write Poetry" )
            (form NIL
               (capture-poems)
               (publish-button) ) )
         (fixed-nav-scripts) 
         (nav-js) ]


[de capture-poems ()
   (gui '(+Style +Var +Cue +TextField)
      "row u-full-width"
      'title*
      "Catchy title"
      30 ) 
   (gui '(+Style +Var +Cue +TextField)
      "row u-full-width"
      'poet*
      "Tag your work"
      30 )
   (gui '(+Style +Var +Cue +TextField)
      "row u-full-width"
      'txt*
      "Bad poetry here"
      60 10 ) ]


[de publish-button ()
   (gui '(+Style +Button) 
      "button-primary row u-full-width"
      "Publish bad poetry"
      '(prog
         (new! '(+Poem) 
            'title title*
            'poet  poet*
            'txt   txt*
            'date  (date) )
         (off title* poet* txt*)
         (setq *Url "!published") ]


(de published ()
   (action
      (html 0 "Bad Poetry" *Css NIL
         (nav)
         (<h1> NIL "Congratulations!")
         (<p> NIL "Your poetry has been published!")
         (fixed-nav-scripts)
         (nav-js) ) ) )


(de search-poems (Dst)
   (action
      (html 0 "Search Poetry" *Css NIL
         (nav)
         (form "container pt-xxl" 
            (<h1> "ta-c"
               "Read Poetry" )
            (diaform '(Dst)
               [<div> "row pt-l"
                  (gui 'title '(+Style +Var +DbHint +Cue +TextField) 
                     "four columns"
                     'poem-title* 
                     '(title +Poem) 
                     "Title"
                     30 )
                  (gui 'poet '(+Style +Var +DbHint +Cue +TextField) 
                     "four columns"
                     'poem-poet* 
                     '(poet +Poem) 
                     "Poet"
                     30 )
                  (gui 'txt '(+Style +Var +Cue +TextField) 
                     "four columns"
                     'poem-txt* 
                     "Text" 30) ]
               [<div> "row pb-l"
                  (<style> "button-primary six columns"
                     (searchButton '(init> (: home query))) )
                  (<style> "button-primary six columns"
                     (resetButton '(title poet txt query)) ) ]
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
               (<table> "table u-full-width" NIL
                  (quote
                     (NIL "Title")
                     (NIL "Poet") )
                  (do 8 
                     (<row> NIL
                        (gui 1 '(+ObjView +TextField) '(: title))
                        (gui 2 '(+TextField)) ) ) )
               (<div> "row"
                  (<style> "three columns" 
                     (scroll 8) ) ) ) )
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


[de show-poems2 ()
   (action
      (html 0 "View Poetry" *Css NIL
         (nav)
         [form "container pt-xxl"
            (<h1> "ta-c" 
               (<id> (: title)) )
            (<h6> "ta-c"
               "a bad poem by" )
            (<h3> "ta-c pb" 
               (<id> (: poet)) )
            (<p> "ta-c"
               (<id> (: txt)) )
            (<style> "button"
               (stepBtn 'title '+Poem) ]
         (nav-js) ]
