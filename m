Message-ID: <51E562FD.90802@axelsw.it>
Date: Tue, 16 Jul 2013 17:13:01 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <51E4F63A.7080203@163.com> <51E55AB0.8070600@siemens.com>
In-Reply-To: <51E55AB0.8070600@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] imx28 high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

i put xenomai 2.6.2.1 with patch 'ipipe-core-3.4.6-arm-4.patch' on a 
vanilla kernel 3.4.6 for a karo tx28 board (tx28 has imx28 processor 
that uses standard clock management to access the timer).
I run the latency test but seems to have very high latency.
(I saw always that every 5 records the 'lat avg' is higher than previous.
Also when i run after some seconds the command 'ls -lR /' from a telnet 
console for increaseing interrupts the 'lat min' is raised to  54.200~ us )
i read correcly the data below or i misunderstanding the behaviour ?
Are there some kernel features to disable ?

Thanks for all


root@triton1:/# /usr/xenomai/bin/latency
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     -0.375|     16.208|     70.624|       0|     0| -0.375|     70.624
RTD|      0.000|      1.749|     74.624|       0|     0| -0.375|     74.624
RTD|      0.083|      1.624|     72.458|       0|     0| -0.375|     74.624
RTD|      0.000|      1.666|     70.916|       0|     0| -0.375|     74.624
RTD|      0.000|      1.541|     72.499|       0|     0| -0.375|     74.624
RTD|     -0.042|     16.083|     71.416|       0|     0| -0.375|     74.624
RTD|      0.124|      1.666|     75.499|       0|     0| -0.375|     75.499
RTD|      0.083|      1.624|     71.791|       0|     0| -0.375|     75.499
RTD|     -0.084|      1.583|     73.374|       0|     0| -0.375|     75.499
RTD|     -0.042|      1.541|     70.249|       0|     0| -0.375|     75.499
RTD|      0.041|     15.708|     71.124|       0|     0| -0.375|     75.499
RTD|      0.041|      1.583|     75.541|       0|     0| -0.375|     75.541
RTD|      0.124|      1.583|     70.124|       0|     0| -0.375|     75.541
RTD|      0.041|      1.624|     70.749|       0|     0| -0.375|     75.541
RTD|     -0.042|      1.499|     72.041|       0|     0| -0.375|     75.541
RTD|      0.041|     15.333|     74.749|       0|     0| -0.375|     75.541
RTD|     54.208|     68.833|     72.999|       0|     0| -0.375|     75.541
RTD|     52.083|     68.833|     73.249|       0|     0| -0.375|     75.541
RTD|     54.874|     68.874|     80.208|       0|     0| -0.375|     80.208
RTD|     53.416|     68.833|     71.041|       0|     0| -0.375|     80.208
RTD|     52.374|     68.833|     80.541|       0|     0| -0.375|     80.541
RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     53.749|     68.874|     73.624|       0|     0| -0.375|     80.541
RTD|     54.624|     68.833|     70.999|       0|     0| -0.375|     80.541
RTD|     54.124|     68.833|     72.374|       0|     0| -0.375|     80.541
RTD|     53.374|     68.874|     74.333|       0|     0| -0.375|     80.541
RTD|     54.083|     68.833|     73.791|       0|     0| -0.375|     80.541
RTD|     53.958|     69.166|     92.958|       0|     0| -0.375|     92.958
RTD|     53.583|     68.916|     77.041|       0|     0| -0.375|     92.958
RTD|     54.374|     68.833|     76.041|       0|     0| -0.375|     92.958
RTD|     53.833|     68.874|     74.958|       0|     0| -0.375|     92.958
RTD|     50.124|     68.833|     74.833|       0|     0| -0.375|     92.958
RTD|     53.874|     68.833|     74.291|       0|     0| -0.375|     92.958
RTD|     57.083|     70.749|     93.916|       0|     0| -0.375|     93.916
RTD|     57.291|     73.041|     87.208|       0|     0| -0.375|     93.916
RTD|     55.999|     71.583|     87.791|       0|     0| -0.375|     93.916
RTD|     55.041|     73.958|     85.083|       0|     0| -0.375|     93.916
RTD|     65.374|     74.708|     85.999|       0|     0| -0.375|     93.916
RTD|     60.916|     74.708|     85.458|       0|     0| -0.375|     93.916
RTD|     58.749|     74.708|     86.041|       0|     0| -0.375|     93.916
RTD|     60.166|     74.541|     85.458|       0|     0| -0.375|     93.916
RTD|     60.208|     74.583|     85.416|       0|     0| -0.375|     93.916
RTD|     62.874|     74.583|     91.083|       0|     0| -0.375|     93.916
RTT|  00:00:43  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     57.083|     71.958|     88.166|       0|     0| -0.375|     93.916
RTD|     63.291|     74.124|     92.249|       0|     0| -0.375|     93.916
RTD|     66.958|     74.458|     86.333|       0|     0| -0.375|     93.916
RTD|     63.541|     74.499|     83.624|       0|     0| -0.375|     93.916
RTD|     62.874|     74.541|     86.708|       0|     0| -0.375|     93.916
RTD|     62.458|     74.541|     87.666|       0|     0| -0.375|     93.916
RTD|     64.916|     74.749|     84.166|       0|     0| -0.375|     93.916
RTD|     64.041|     74.541|     86.208|       0|     0| -0.375|     93.916
RTD|     64.749|     74.583|     88.583|       0|     0| -0.375|     93.916
RTD|     55.833|     73.791|     89.041|       0|     0| -0.375|     93.916
RTD|     55.124|     71.249|     88.499|       0|     0| -0.375|     93.916
RTD|     55.583|     71.208|     95.041|       0|     0| -0.375|     95.041
RTD|     51.916|     72.041|     89.458|       0|     0| -0.375|     95.041
RTD|     57.833|     71.083|     86.833|       0|     0| -0.375|     95.041
RTD|     52.541|     68.874|     75.124|       0|     0| -0.375|     95.041
RTD|     54.541|     68.874|     80.249|       0|     0| -0.375|     95.041
RTD|     52.708|     68.833|     74.416|       0|     0| -0.375|     95.041
RTD|     55.166|     68.833|     74.416|       0|     0| -0.375|     95.041
RTD|     53.874|     68.833|     73.291|       0|     0| -0.375|     95.041
RTD|     53.791|     68.874|     78.083|       0|     0| -0.375|     95.041
RTD|     52.416|     68.791|     74.041|       0|     0| -0.375|     95.041
RTT|  00:01:04  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     52.208|     68.874|     73.749|       0|     0| -0.375|     95.041
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     -0.375|     54.666|     95.041|       0|     0| 00:01:04/00:01:04


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


