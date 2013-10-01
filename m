Message-ID: <524AC518.2040901@axelsw.it>
Date: Tue, 01 Oct 2013 14:50:32 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <524ABEED.4090609@axelsw.it>
	<114ba7d302c4a7b01d85caf23c52fa10.squirrel@127.0.0.1>
In-Reply-To: <114ba7d302c4a7b01d85caf23c52fa10.squirrel@127.0.0.1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] high latency with imx6q without smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

excuse me for the previous question i have not seen your email.
i have tried the kernel with the ipipe patch 3.0.43 on xenomai 2.6.x 
branch without smp and has very high worst latency:
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|      5.999|     11.333|     25.333|       0|     0| 5.666|    328.999
RTD|     10.999|     11.333|     19.666|       0|     0| 5.666|    328.999
RTD|      5.999|     10.999|     17.999|       0|     0| 5.666|    328.999
RTD|     10.999|     11.333|     17.999|       0|     0| 5.666|    328.999
RTD|      5.999|     11.333|     26.999|       0|     0| 5.666|    328.999

This behaviour isn't in smp version with 2 processors.

So i read your email and if i understand correctly could be the L2 cache 
spinlock that create large latencies (?328.999).
I'm not using framebuffer directly.
You told me that there is a patch that can fix this behaviour in the 
last ipipe patch.
is there a commit for fixing only this behaviour that i can move on my 
kernel with patch 3.0.43 ?





Il 01/10/2013 14:26, Gilles Chanteperdrix ha scritto:
> Roberto Bielli wrote:
>> Hi,
>>
>> i try to disable smp in the kernel for working with a single cpu on a
>> imx6q but i saw a very high max latency with the test (
>> /usr/xenomai/bin/latency ), about ~350us.
>> Any ideas to reduce the latency?
> See my previous detailed answer about this question. You seem to have a
> habit of disregarding the answers you receive and ask the same question
> again. You should understand it does not motivate people to continue
> answering you.
>
>> Is the patch 3.0.43 for imx6q available without smp ?
> Always the same answer, can you not test before asking, and only ask if
> you have an issue?
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


