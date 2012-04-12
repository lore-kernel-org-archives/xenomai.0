Message-ID: <4F87099F.2020707@domain.hid>
Date: Thu, 12 Apr 2012 18:58:07 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid>
	<4F55E390.8090706@domain.hid>	<4F55FE81.6000904@domain.hid>
	<4F560A6C.2080306@domain.hid>	<4F560B76.5080606@domain.hid>
	<4F5629D2.50304@domain.hid>	<4F562B53.7070400@domain.hid>
	<4F562EC2.6040604@domain.hid>	<4F56387B.40702@domain.hid>
	<4F575BA3.7060404@domain.hid>	<4F576622.1030509@domain.hid>
	<4F57A567.7030008@domain.hid>	<4F7C127D.2010400@domain.hid>
	<4F7C1484.5090406@domain.hid>	<4F7C183F.5040009@domain.hid>
	<4F7F0D4E.8080906@domain.hid>	<4F7F0E8A.70702@domain.hid>
	<4F7F20F0.9070007@domain.hid>	<4F80BD10.2060200@domain.hid>
	<4F83F2C3.50704@domain.hid>	<4F83F321.2030300@domain.hid>
	<4F83F645.7040402@domain.hid> <4F83F828.4000508@domain.hid>
	<4F83F929.5000300@domain.hid> <4F83FBAB.7040301@domain.hid>
	<4F83FF49.90608@domain.hid> <4F840DD8.2030407@domain.hid>
	<4F841E32.50101@domain.hid> <4F8428AA.1040404@domain.hid>
	<4F842A4B.8040106@domain.hid> <4F852BBB.5050400@domain.hid>
	<4F85749C.808@domain.hid> <4F86AA98.6010805@domain.hid>
In-Reply-To: <4F86AA98.6010805@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------030700020806020203030802"
Subject: [Xenomai-core] porting xenomai on imx25
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030700020806020203030802
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gilles,

you tell me that you are working on imx.
Do you know if there is a working xenomai on imx (any kernel or imx 
version) ?

Thanks a lot


Il 12/04/2012 12:12, Roberto Bielli ha scritto:
> Hi Gilles,
>
> i found in my trace the function 'xnthread_timeout_handler' that is 
> called in the code where there is the problem.
> In xenomai there is a topic about that function. ( [Xenomai-core] 
> [BUG?] stalled xeno domain 
> <http://www.opensubscriber.com/messages/xenomai@xenomai.org> )
>
> Do you think that can be a similar problem ?
>
>
>
> Il 11/04/2012 14:10, Gilles Chanteperdrix ha scritto:
>> On 04/11/2012 08:59 AM, Roberto Bielli wrote:
>>> Hi Gilles,
>>>
>>> i try your workaround but nothing is changed.
>>> I make another test. I try to comment out all the content of
>>> mxc_mask_irq() but the result is the same.
>>> (the mxc_mask_irq is used also for acking interrupts but is not correct
>>> why it doesn't write in the processor manual)
>>> Do you know if there is a code over the mxc_mask_irq that disable the
>>> interrupts ?
>>>
>>> About interrupt gpio it should be a link with this behaviour ? ( i don't
>>> want gpio as interrupts )
>> No,  I do not think it is possible. You do not get to decide whether you
>> want gpio as interrupts or not, the design of the board you use does.
>>
>
>
> -- 
> +------------------------------------------------------------------------------------------------+
> 							
> Roberto Bielli
> Sviluppo Software					
> Axel S.r.l.					
> 							
> Via Del Cannino, 3 				
> 21020 Crosio Della Valle			
> Varese - Italy					
> 							
> Telefono: +39 0332 949600			
> Fax:      +39 0332 969315			
> 							
> E-mail:roberto.bielli@domain.hid	
> Web Site:www.axelsw.it
>
> +------------------------------------------------------------------------------------------------+
>
> Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
> Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
> dandocene gentilmente comunicazione. Grazie.
> Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
> I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
> per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
> Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati:info@domain.hid
>
> This e-mail and any attachments is confidential and may contain privileged information
> intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
> else is unauthorised. If you are not the intended recipient,
> please delete this message and any attachments and advise the sender
> by return e-mail.Thank you.  			
> 							
> +------------------------------------------------------------------------------------------------+
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>
> Nessun virus nel messaggio.
> Controllato da AVG - www.avg.com <http://www.avg.com>
> Versione: 2012.0.1913 / Database dei virus: 2411/4929 - Data di 
> rilascio: 11/04/2012
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


--------------030700020806020203030802
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Gilles,<br>
    <br>
    you tell me that you are working on imx. <br>
    Do you know if there is a working xenomai on imx (any kernel or imx
    version) ?<br>
    <br>
    Thanks a lot <br>
    <br>
    <br>
    Il 12/04/2012 12:12, Roberto Bielli ha scritto:
    <blockquote cite="mid:4F86AA98.6010805@domain.hid" type="cite">
      <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
      Hi Gilles,<br>
      <br>
      i found in my trace the function 'xnthread_timeout_handler' that
      is called in the code where there is the problem.<br>
      In xenomai there is a topic about that function. ( <span
        class="big_text"><a moz-do-not-send="true"
href="http://www.opensubscriber.com/messages/xenomai@xenomai.org">[Xenomai-core]

          [BUG?] stalled xeno domain</a></span> )<br>
      <br>
      Do you think that can be a similar problem ?<br>
      <br>
      <br>
      <br>
      Il 11/04/2012 14:10, Gilles Chanteperdrix ha scritto:
      <blockquote cite="mid:4F85749C.808@domain.hid" type="cite">
        <pre wrap="">On 04/11/2012 08:59 AM, Roberto Bielli wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Hi Gilles,

i try your workaround but nothing is changed.
I make another test. I try to comment out all the content of 
mxc_mask_irq() but the result is the same.
(the mxc_mask_irq is used also for acking interrupts but is not correct 
why it doesn't write in the processor manual)
Do you know if there is a code over the mxc_mask_irq that disable the 
interrupts ?

About interrupt gpio it should be a link with this behaviour ? ( i don't 
want gpio as interrupts )
</pre>
        </blockquote>
        <pre wrap="">No,  I do not think it is possible. You do not get to decide whether you
want gpio as interrupts or not, the design of the board you use does.

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
							
E-mail:   <a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:roberto.bielli@domain.hid">roberto.bielli@domain.hid</a>	
Web Site: <a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="http://www.axelsw.it">www.axelsw.it</a>

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario. 
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi, 
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003). 
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento, 
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi. 
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: <a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:info@domain.hid">info@domain.hid</a>

This e-mail and any attachments is confidential and may contain privileged information 
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody 
else is unauthorised. If you are not the intended recipient, 
please delete this message and any attachments and advise the sender 
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Xenomai-core mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a>
<a class="moz-txt-link-freetext" href="https://mail.gna.org/listinfo/xenomai-core">https://mail.gna.org/listinfo/xenomai-core</a>
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <p class="" avgcert""="" color="#000000" align="left">Nessun virus
        nel messaggio.<br>
        Controllato da AVG - <a moz-do-not-send="true"
          href="http://www.avg.com">www.avg.com</a><br>
        Versione: 2012.0.1913 / Database dei virus: 2411/4929 - Data di
        rilascio: 11/04/2012</p>
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

--------------030700020806020203030802--

