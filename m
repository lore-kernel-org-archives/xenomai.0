Message-ID: <1135950474.43b53a8a070f6@domain.hid>
Date: Fri, 30 Dec 2005 14:47:54 +0100
From: vdkeybus <Jeroen.VandenKeybus@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] RTDM interrupt programming practice
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I've programmed an RTDM PCI driver using interrupts. However, I've a 
few questions regarding the programming practices (especially because 
I'm not getting the performance I want). 

1. The PCI system assigns an interrupt 177 which is totally outside the 
range 0..15 I'm used to. Is it ok to pass this value to rtdm_irq_request
() ?

2. Is it obligatory to use a rtdm_toseq_t in rtdm_event_timedwait() and 
friends. Or, in other words, can I do rtdm_event_timedwait(&evt, 10000, 
NULL); ?

3. Currently, I register my ISR in the open() function. I unregister it 
in close(), after I've disabled the card's interrupt line. 
Nevertheless, I get a kernel message right after shutting down:

irq 177: nobody cared (try booting with the "irqpoll" option)
 [<c013a18f>] __report_bad_irq+0x24/0x7f
 [<c013a26a>] note_interrupt+0x62/0xb8
 [<c0139c70>] __do_IRQ+0xb7/0xc7
 [<c010511b>] do_IRQ+0x53/0x8b
 =======================
 [<c011c045>] profile_tick+0x20/0x49
 [<c0114908>] __ipipe_sync_stage+0xf1/0x13a
 [<c011490d>] __ipipe_sync_stage+0xf6/0x13a
 [<c0115187>] __ipipe_handle_irq+0x233/0x24c
 [<c010104a>] default_idle+0x30/0x3b
 [<c010101a>] default_idle+0x0/0x3b
 [<c0103b30>] common_interrupt+0x18/0x30
 [<c010101a>] default_idle+0x0/0x3b
 [<c010104a>] default_idle+0x30/0x3b
 [<c01010c2>] cpu_idle+0x3a/0x52
 [<c0327785>] start_kernel+0x179/0x1df
 [<c0327330>] unknown_bootoption+0x0/0x1b6
handlers:
[<f88ae638>] (snd_intel8x0_interrupt+0x0/0x23c [snd_intel8x0])
Disabling IRQ #177

After this message, it is impossible to reuse the interrupt line (after 
e.g. rmmod and insmod of driver and xeno_... modules) and the computer 
becomes very slow. Also note that I have traces of snd_intel8x0 
appearing in this context.

4. How can I verify the status of running xenomai processes (and the 
driver). I would like to find out why I'm not meeting my interrupt 
deadlines.

Thanks for any help,


Jeroen.


Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm


