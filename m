Message-ID: <4F4FB9F3.8030806@domain.hid>
Date: Thu, 01 Mar 2012 19:03:31 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F3146AA.5070902@domain.hid> <4F41144E.1020004@domain.hid>
In-Reply-To: <4F41144E.1020004@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020700040400070604080806"
Subject: [Xenomai-core] high duration of __ipipe_handle_irq
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020700040400070604080806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

i have this problem with xenomai ( 2.5.6 - arm freescale imx25 ):

I have a xenomai application that uses more rt_tasks, and i have a 
strange behaviour.
When i run my application the period of *__ipipe_handle_irq* is very 
long ( ~3ms in some cases ) in the moment
that come the *__ipipe_mach_timerint *interrupt and so the other 
interrupts are very late.

Do you know something about this ?

Thanks for all


-- 
+------------------------------------------------------------------------------------------------+
							
Roberto Bielli
Sviluppo Software					
Axel S.r.l.					
							
Via Del Cannino, 3 				
21020 Crosio Della Valle			
Varese - Italy					
							
Telefono: +39 0332 949600			
Fax:      +39 0332 969315			
							
E-mail:   roberto.bielli@domain.hid	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@domain.hid

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


--------------020700040400070604080806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,<br>
    <br>
    i have this problem with xenomai ( 2.5.6 - arm freescale imx25 ):<br>
    <br>
    I have a xenomai application that uses more rt_tasks, and i have a
    strange behaviour.<br>
    When i run my application the period of&nbsp;<b> __ipipe_handle_irq</b>
    is very long ( ~3ms in some cases ) in the moment <br>
    that come the <b>__ipipe_mach_timerint </b>interrupt and so the
    other interrupts are very late. <br>
    <br>
    Do you know something about this ?<br>
    <br>
    Thanks for all<br>
    <br>
    <br>
    <pre class="moz-signature" cols="72">-- 
+------------------------------------------------------------------------------------------------+
							
Roberto Bielli
Sviluppo Software					
Axel S.r.l.					
							
Via Del Cannino, 3 				
21020 Crosio Della Valle			
Varese - Italy					
							
Telefono: +39 0332 949600			
Fax:      +39 0332 969315			
							
E-mail:   <a class="moz-txt-link-abbreviated" href="mailto:roberto.bielli@domain.hid">roberto.bielli@domain.hid</a>	
Web Site: <a class="moz-txt-link-abbreviated" href="http://www.axelsw.it">www.axelsw.it</a>

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario. 
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi, 
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003). 
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento, 
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi. 
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: <a class="moz-txt-link-abbreviated" href="mailto:info@domain.hid">info@domain.hid</a>

This e-mail and any attachments is confidential and may contain privileged information 
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody 
else is unauthorised. If you are not the intended recipient, 
please delete this message and any attachments and advise the sender 
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+</pre>
  </body>
</html>

--------------020700040400070604080806--

