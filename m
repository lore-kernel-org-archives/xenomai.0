Message-ID: <48100D81.9090109@domain.hid>
Date: Thu, 24 Apr 2008 00:33:05 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Cannot end interrupt from user space: add
	rt_intr_end call ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Hi,

I think that when I handle interrupts from user space, I cannot 
correctly use I_NOAUTOENA. The thing is that this flag in fact means "do 
not call automatically xnarch_end_irq". The xnarch_end_irq call usually 
maps to unmasking the interrupt, but not always - depending on interrupt 
type (sometimes in eoi, sometimes is nop).

I was thinking that it would be nice if I could call something like 
"xnarch_end_irq" (i.e. rt_intr_end) from user space, so that I could 
correctly use I_NOAUTOENA to control the flow of interrupts.

Cheers,
Tomas



