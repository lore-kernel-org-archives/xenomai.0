Message-ID: <4F852BBB.5050400@domain.hid>
Date: Wed, 11 Apr 2012 08:59:07 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid>
	<4F55C306.8020307@domain.hid>	<4F55D765.7040705@domain.hid>
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
	<4F842A4B.8040106@domain.hid>
In-Reply-To: <4F842A4B.8040106@domain.hid>
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

Hi Gilles,

i try your workaround but nothing is changed.
I make another test. I try to comment out all the content of 
mxc_mask_irq() but the result is the same.
(the mxc_mask_irq is used also for acking interrupts but is not correct 
why it doesn't write in the processor manual)
Do you know if there is a code over the mxc_mask_irq that disable the 
interrupts ?

About interrupt gpio it should be a link with this behaviour ? ( i don't 
want gpio as interrupts )



Il 10/04/2012 14:40, Gilles Chanteperdrix ha scritto:
> On 04/10/2012 02:33 PM, Roberto Bielli wrote:
>> Il 10/04/2012 13:49, Gilles Chanteperdrix ha scritto:
>>> On 04/10/2012 12:39 PM, Roberto Bielli wrote:
>>>> Hi Gilles,
>>>>
>>>> i tried your code but th behavior is the same.
>>>>
>>>> Then i tried a linux base app and works correctly.
>>> In the exact same conditions? With the crunching task running with
>>> SCHED_FIFO, priority 1, and the periodic task running with SCHED_FIFO,
>>> priority 99, and the linux real-time throttling disabled?
>>>
>> Yes, and i see that every LATCH ( about ~10ms ) period the task with
>> higher priority is wakeup.
>> So a task with lower priority is interrupted by timer interrupt and
>> reschedule the task with higher priority.
>>
> The only thing I can think is that the timer interrupt in fact stays
> masked. You can try the following patch:
>
> diff --git a/arch/arm/plat-mxc/irq.c b/arch/arm/plat-mxc/irq.c
> index 8aee763..7e4cc2e 100644
> --- a/arch/arm/plat-mxc/irq.c
> +++ b/arch/arm/plat-mxc/irq.c
> @@ -94,12 +94,14 @@ EXPORT_SYMBOL(mxc_set_irq_fiq);
>   static void mxc_mask_irq(unsigned int irq)
>   {
>          __raw_writel(irq, avic_base + AVIC_INTDISNUM);
> +       __raw_readl(avic_base + AVIC_INTDISNUM);
>   }
>
>   /* Enable interrupt number "irq" in the AVIC */
>   static void mxc_unmask_irq(unsigned int irq)
>   {
>          __raw_writel(irq, avic_base + AVIC_INTENNUM);
> +       __raw_readl(avic_base + AVIC_INTENNUM);
>   }
>
>   static struct irq_chip mxc_avic_chip = {
>
>
> If I had to debug this issue, I would look at all the timer and
> interrupt controller registers value, to see what is wrong.
>
> You can also try the plain linux example with CONFIG_IPIPE on, but
> without CONFIG_XENOMAI.
>
> Other than that, without access to the board, it is hard for me to
> debug further, so I am afraid you are on your own.
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


