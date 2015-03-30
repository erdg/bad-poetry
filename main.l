(allowed ("css/" "js/" "icons/")
   "!work"
   "!search-poems"
   "!create-poems"
   "!show-poems"
   "!show-poems2"
   "!published" 
   "@lib.css" )


(push1 '*JS
   (allow "js/responsive-nav.js") )


(setq *Css 
   (list 
      "css/normalize.css" 
      "css/skeleton.css" 
      "css/utils.css"
      "css/fixed-responsive-nav.css"
      "css/bad-poetry.css"
      "http://fonts.googleapis.com/css?family=Domine:700" ) )

(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(load "er.l" "gui.l")


### utilities ###
(class +Cue)

(dm T (Str . @)
   (=: cue (pack Str))  # remove carrots from cue text 
   (pass extra) )

(patch <area> "\" wrap=\"off\"" "\" wrap=\"hard\"")  # wrap=hard for textarea
###

(de main ()
   (pool "poem.db") )

(de go ()
   (task (port 4040)
      (let? Sock (accept @)
         (unless (fork)
            (in Sock
               (while (rd)
                  (sync)
                  (tell)
                  (out Sock
                     (pr (eval @)) ) ) )
            (bye) )
         (close Sock) ) )
   (forked)
   (rollback)
   (server 8080 "!work") )
