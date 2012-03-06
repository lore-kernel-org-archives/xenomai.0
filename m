Message-ID: <4F5629D2.50304@domain.hid>
Date: Tue, 06 Mar 2012 16:14:26 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid> <4F560A6C.2080306@domain.hid>
	<4F560B76.5080606@domain.hid>
In-Reply-To: <4F560B76.5080606@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------040009040509000308020605"
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040009040509000308020605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gilles,

i changed the min value of the '__ipipe_mach_set_dec' but the situation 
is the same.
I see with the scope that the task with less priority is not interrupted.

It's difficult to see with the ipipe trace the problem so i put the 
xenomai trace in the application with 
|xntrace_user_start|/|xntrace_user_stop|.
Is the log of xenomai in the same place (/proc/ipipe/trace/max ) of ipipe ?

Thanks a lot



Il 06/03/2012 14:04, Gilles Chanteperdrix ha scritto:
> On 03/06/2012 02:00 PM, Roberto Bielli wrote:
>> Hi Gilles,
>>
>> here is the new trace.
> There is nothing to see on that trace. Please increase the number of
> trace points, and trigger a trace when you detect a problem., the number
> of trace points should be sufficient to get the timer programmation
> which happens before the problem.
>
> Also, did you try T_WANRSW ?
>
> Please disable the configuration of you mail server which asks me to
> send a receipt to each every mail you send me.
>


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


--------------040009040509000308020605
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Gilles,<br>
    <br>
    i changed the min value of the '__ipipe_mach_set_dec' but the
    situation is the same.<br>
    I see with the scope that the task with less priority is not
    interrupted.<br>
    <br>
    It's difficult to see with the ipipe trace the problem so i put the
    xenomai trace in the application with <code>xntrace_user_start</code>/<code>xntrace_user_stop</code>.<br>
    Is the log of xenomai in the same place (/proc/ipipe/trace/max ) of
    ipipe ?<br>
    <br>
    Thanks a lot<br>
    <br>
    <br>
    <br>
    Il 06/03/2012 14:04, Gilles Chanteperdrix ha scritto:
    <blockquote cite="mid:4F560B76.5080606@domain.hid" type="cite">
      <pre wrap="">On 03/06/2012 02:00 PM, Roberto Bielli wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hi Gilles,

here is the new trace.
</pre>
      </blockquote>
      <pre wrap="">
There is nothing to see on that trace. Please increase the number of
trace points, and trigger a trace when you detect a problem., the number
of trace points should be sufficient to get the timer programmation
which happens before the problem.

Also, did you try T_WANRSW ?

Please disable the configuration of you mail server which asks me to
send a receipt to each every mail you send me.

</pre>
    </blockquote>
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

--------------040009040509000308020605--

