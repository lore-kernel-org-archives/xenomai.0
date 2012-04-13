Message-ID: <4F87E781.8020801@domain.hid>
Date: Fri, 13 Apr 2012 10:44:49 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid>
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
	<4F87099F.2020707@domain.hid> <4F87139E.6050805@domain.hid>
In-Reply-To: <4F87139E.6050805@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] porting xenomai on imx25
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

Hi Gilles,

you don't feel like to repeat.
I'm trying all the things that you told me and i will do all the missing 
test that you told me.

And now this is the result of latency that i ran. It seems correct.
root@domain.hid# ./latency
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     67.263|     77.203|     85.458|       0|     0|     67.263|     
85.458
RTD|     67.293|     77.203|    100.240|       0|     0|     67.263|    
100.240
RTD|     67.413|     77.203|     88.360|       0|     0|     67.263|    
100.240
RTD|     67.323|     77.233|     86.661|       0|     0|     67.263|    
100.240
RTD|     66.676|     77.187|     85.849|       0|     0|     66.676|    
100.240
RTD|     67.353|     77.233|     87.172|       0|     0|     66.676|    
100.240
RTD|     67.203|     77.368|    217.323|       0|     0|     66.676|    
217.323
RTD|     67.609|     77.172|     87.022|       0|     0|     66.676|    
217.323
RTD|     66.796|     77.218|     86.030|       0|     0|     66.676|    
217.323
RTD|     67.714|     77.172|     85.368|       0|     0|     66.676|    
217.323
RTD|     67.263|     77.233|     87.263|       0|     0|     66.676|    
217.323
RTD|     67.022|     77.172|     85.684|       0|     0|     66.676|    
217.323
RTD|     67.669|     77.248|     83.894|       0|     0|     66.676|    
217.323
RTD|     67.969|     77.172|     86.736|       0|     0|     66.676|    
217.323
RTD|     66.827|     77.187|     87.383|       0|     0|     66.676|    
217.323
RTD|     67.097|     77.263|    119.909|       0|     0|     66.676|    
217.323
RTD|     67.022|     77.308|    183.548|       0|     0|     66.676|    
217.323
RTD|     66.616|     77.187|     84.902|       0|     0|     66.616|    
217.323
RTD|     67.353|     77.187|     91.338|       0|     0|     66.616|    
217.323
RTD|     67.022|     77.233|     83.278|       0|     0|     66.616|    
217.323
RTD|     67.037|     77.248|     87.022|       0|     0|     66.616|    
217.323
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     67.037|     77.157|     86.796|       0|     0|     66.616|    
217.323
RTD|     66.902|     77.263|    125.383|       0|     0|     66.616|    
217.323
RTD|     67.548|     77.187|     87.894|       0|     0|     66.616|    
217.323
RTD|     67.338|     77.248|     86.255|       0|     0|     66.616|    
217.323
RTD|     67.157|     77.218|     87.157|       0|     0|     66.616|    
217.323
RTD|     67.308|     77.233|     84.180|       0|     0|     66.616|    
217.323
RTD|     67.684|     77.203|     86.631|       0|     0|     66.616|    
217.323
RTD|     67.578|     77.187|     89.368|       0|     0|     66.616|    
217.323
RTD|     66.917|     77.203|     86.691|       0|     0|     66.616|    
217.323
RTD|     66.992|     77.218|     86.616|       0|     0|     66.616|    
217.323
RTD|     67.142|     77.218|     87.097|       0|     0|     66.616|    
217.323
RTD|     67.248|     77.187|     90.180|       0|     0|     66.616|    
217.323
RTD|     67.368|     77.233|     87.939|       0|     0|     66.616|    
217.323
RTD|     67.413|     77.187|     89.503|       0|     0|     66.616|    
217.323
RTD|     67.684|     77.233|     87.368|       0|     0|     66.616|    
217.323
RTD|     67.428|     77.157|     87.203|       0|     0|     66.616|    
217.323
RTD|     67.248|     77.157|     91.368|       0|     0|     66.616|    
217.323
RTD|     67.233|     77.368|    215.879|       0|     0|     66.616|    
217.323
RTD|     67.428|     77.323|    178.857|       0|     0|     66.616|    
217.323
RTD|     66.917|     77.187|     92.075|       0|     0|     66.616|    
217.323
---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     66.616|     77.218|    217.323|       0|     0|    
00:00:41/00:00:41

Il 12/04/2012 19:40, Gilles Chanteperdrix ha scritto:
> On 04/12/2012 06:58 PM, Roberto Bielli wrote:
>> Hi Gilles,
>>
>> you tell me that you are working on imx.
>> Do you know if there is a working xenomai on imx (any kernel or imx
>> version) ?
> I have tested Xenomai  on imx31, imx51, imx53, imx6q. It works on these
> platforms. Now, what you are doing is in fact porting xenomai on imx25,
> nobody did that before you, and you are faced with a peculiarity of the
> timer on this platform. What you should do is:
> - try to reproduce the problem with an unpatched linux with
> CONFIG_HIGH_RES_TIMERS
> - or try and look at the timers registers value at the time when the bug
> happens to see what is going wrong.
>
> Also, the first thing to do when running xenomai on a new platform is to
> run the "latency" test. Have you run this test?
>
> I feel like I am starting to repeat myself, I do not know if I should
> continue trying and answering you.
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


