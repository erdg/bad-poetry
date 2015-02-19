(allowed ()
   "!work"
   "!search-poems"
   "!create-poems"
   "!show-poems"
   "!show-poems2"
   "!thanks"
   "@lib.css" )

(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(load "er.l" "gui.l")

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
