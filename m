Message-ID: <4F84250F.60401@domain.hid>
Date: Tue, 10 Apr 2012 14:18:23 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55D765.7040705@domain.hid>
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
	<4F8418C4.400@domain.hid> <4F8421F7.50807@domain.hid>
	<4F84222D.7080808@domain.hid> <4F842369.2020504@domain.hid>
	<4F842395.4060108@domain.hid>
In-Reply-To: <4F842395.4060108@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

here is some logs.

status=on:setup=616:clock=509343446344:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=509413956366:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=509461811116:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=509493738137:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=509642692217:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=509889401336:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=509959233537:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=510033716418:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=510083589650:timerdev=mxc_timer1:clockdev=mxc_timer1
root@domain.hid# cat /proc/xenomai/timer
status=on:setup=616:clock=510145433674:timerdev=mxc_timer1:clockdev=mxc_timer1

Il 10/04/2012 14:12, Gilles Chanteperdrix ha scritto:
> On 04/10/2012 02:11 PM, Roberto Bielli wrote:
>> Il 10/04/2012 14:06, Gilles Chanteperdrix ha scritto:
>>> On 04/10/2012 02:05 PM, Roberto Bielli wrote:
>>>> Hi Gilles,
>>>>
>>>> i added this in configure of xenomai so i pass --enable-arm-mach=imx25
>>>>
>>>> imx25)        arch=5
>>>>                tsc_type=__XN_TSC_TYPE_FREERUNNING;;
>>>>
>>>> Furthermore in plat-mxc/include/mach/mxc.h explain which are cpumx2 and
>>>> imx25 is NOT mx2
>>>> #define cpu_is_mx2()    (cpu_is_mx21() || cpu_is_mx27())
>>>>
>>>> i don't understand a things.
>>>> Does the tsc necessary to calculate correct timer period, or can i
>>>> disable tsc and xenomai continue work correctly ?
>>> Xenomai needs the tsc in kernel-space. Obviously, if you do not use the
>>> tsc in user-space, you will not see that it is wrong. Correct physical
>>> address is only needed for user-space.
>>>
>>>> However i cannot use tsc in my simple application. I resend the simple C
>>>> application that doesn't work.
>>> What do you mean you can not use the tsc in your application? What
>>> happens if you use it?
>>>
>> If i use tsc i have no error and i read a correct value.
>>
> So, it works. Good news. To know if it works as expected, you can try
> the "latency" test.
>
> Something I have not asked, could you type:
> cat /proc/xenomai/timer
>
> on the mx25 board?
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


