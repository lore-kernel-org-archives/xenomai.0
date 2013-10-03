Message-ID: <524D2C77.6050706@axelsw.it>
Date: Thu, 03 Oct 2013 10:36:07 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <524ABEED.4090609@axelsw.it>
	<114ba7d302c4a7b01d85caf23c52fa10.squirrel@127.0.0.1>
	<524AC518.2040901@axelsw.it> <524B1E12.2010909@xenomai.org>
In-Reply-To: <524B1E12.2010909@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

i reduced drastically the latency disabling the cpu frequency scaling -> 
CONFIG_CPU_FREQ ( max 25us ).

Il 01/10/2013 21:10, Gilles Chanteperdrix ha scritto:
> On 10/01/2013 02:50 PM, Roberto Bielli wrote:
>> Hi,
>>
>> excuse me for the previous question i have not seen your email.
>> i have tried the kernel with the ipipe patch 3.0.43 on xenomai 2.6.x
>> branch without smp and has very high worst latency:
>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat
>> best|--lat worst
>> RTD|      5.999|     11.333|     25.333|       0|     0| 5.666|    328.999
>> RTD|     10.999|     11.333|     19.666|       0|     0| 5.666|    328.999
>> RTD|      5.999|     10.999|     17.999|       0|     0| 5.666|    328.999
>> RTD|     10.999|     11.333|     17.999|       0|     0| 5.666|    328.999
>> RTD|      5.999|     11.333|     26.999|       0|     0| 5.666|    328.999
>>
>> This behaviour isn't in smp version with 2 processors.
> It may be here in SMP but you do not see it. You should run the latency
> test under load to try and trigger the worst case latency.
>
>> So i read your email and if i understand correctly could be the L2 cache
>> spinlock that create large latencies (?328.999).
> The L2 cache spinlock section are alreay reduced, the maximum was rather
> around 40us anyway.
>
>> I'm not using framebuffer directly.
>> You told me that there is a patch that can fix this behaviour in the
>> last ipipe patch.
>> is there a commit for fixing only this behaviour that i can move on my
>> kernel with patch 3.0.43 ?
> Please try disabling the framebuffer driver completely, and see if it
> changes anything. If it does not change anything, you have to use the
> I-pipe tracer.
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


