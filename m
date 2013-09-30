Message-ID: <52492AE5.7060501@axelsw.it>
Date: Mon, 30 Sep 2013 09:40:21 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C466402463ADE@MAIL-SINTERS-01.sinters-int.fr>,
	<51DBF250.9070804@xenomai.org>	<A46EF8CF1BBB8E4B8A27B73E177C466402464B37@MAIL-SINTERS-01.sinters-int.fr>,
	<51DC560F.90805@xenomai.org>	<A46EF8CF1BBB8E4B8A27B73E177C4664033EC616@MAIL-SINTERS-01.sinters-int.fr>,
	<51DDB5C3.7010307@xenomai.org>	<A46EF8CF1BBB8E4B8A27B73E177C4664033F268F@MAIL-SINTERS-01.sinters-int.fr>,
	<51DEF6FB.6080403@xenomai.org>	<A46EF8CF1BBB8E4B8A27B73E177C4664033F3724@MAIL-SINTERS-01.sinters-int.fr>	<51E43CE5.5020103@xenomai.org>
	<52457550.2050501@axelsw.it>	<979a2ecdb54e79afe900ef6a07f21ce9.squirrel@127.0.0.1>	<52457ED1.8050509@axelsw.it>
	<5245DB72.9060603@xenomai.org> <52491EF8.80908@axelsw.it>
In-Reply-To: <52491EF8.80908@axelsw.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : RE : RE : RE : No boot kernel with xenomai on
 i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

can i use 2.6.x xenomai branch or is it unstable ?



Il 30/09/2013 08:49, Roberto Bielli ha scritto:
> Il 27/09/2013 21:24, Gilles Chanteperdrix ha scritto:
>> On 09/27/2013 02:49 PM, Roberto Bielli wrote:
>>> Hi,
>>>
>>> my kernel working before applying 
>>> adeos-ipipe-3.0.36-arm-1.18-11.patch +
>>> adeos-ipipe-3.0.36-arm-1.18-11-post.patch,
>>> So is not a problem before installing ipipe.
>> I missed that part, 3.0.36 is not the latest version, please try 3.0.43
>> from xenomai git. Also, you have 3 patches to apply, not 2.
>>
>> Finally, it is important to test the patched kernel without CONFIG_IPIPE
>> and CONFIG_XENOMAI.
>>
> I'll try the 3.0.43. The kernel patched without CONFIG_IPIPE and 
> CONFIG_XENOMAI works.
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
							
E-mail:   roberto.bielli@axelsw.it	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@axelsw.it

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


