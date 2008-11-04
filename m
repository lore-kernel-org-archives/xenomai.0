Message-ID: <843a47610811040527v582d1aa0oce35d4278b6c6af9@domain.hid>
Date: Tue, 4 Nov 2008 08:27:57 -0500
From: "Matthew Fornero" <mfornero.lists@domain.hid>
Sender: mfornero@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_85635_29369108.1225805277773"
Subject: [Xenomai-help] Masking / Disabling the local timer interrupt
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

------=_Part_85635_29369108.1225805277773
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have an application on x86 that uses an external event (either an
interrupt or a DMA write to a specific memory location) to trigger code
execution, and I believe the local timer interrupt is contributing a
significant amount of jitter. This is a bit of a unique case where the only
code that should be executing on that core is triggered by the event, so
there is no need for anything timer based.

I'm using a dual core processor with a quiet system, and have placed all of
the "moveable" interrupts on CPU 0 (0-NR_IRQs using ipipe_set_irq_affinity).
Looking at /proc/xenomai/irq and /proc/interrupts shows only the local timer
interrupt increment on CPU 1. When using the DMA write to trigger execution,
placing "sti"/"cli" around the polling routine improves the jitter
substantially.

Based on the above, is there some way to do one of the following:

1). Make a user space task higher priority than the timer interrupt

or

2). A proper way to disable the local timer (vs. disabling all interrupts)
on specific cores, as these cores would only need to run event based
routines.

Best Regards,

Matthew Fornero

------=_Part_85635_29369108.1225805277773
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I have an application on x86 that uses an external event (either an interrupt or a DMA write to a specific memory location) to trigger code execution, and I believe the local timer interrupt is contributing a significant amount of jitter. This is a bit of a unique case where the only code that should be executing on that core is triggered by the event, so there is no need for anything timer based.<br>
<br>I&#39;m using a dual core processor with a quiet system, and have placed all of the &quot;moveable&quot; interrupts on CPU 0 (0-NR_IRQs using ipipe_set_irq_affinity). Looking at /proc/xenomai/irq and /proc/interrupts shows only the local timer interrupt increment on CPU 1. When using the DMA write to trigger execution, placing &quot;sti&quot;/&quot;cli&quot; around the polling routine improves the jitter substantially. <br>
<br>Based on the above, is there some way to do one of the following:<br><br>1). Make a user space task higher priority than the timer interrupt<br><br>or<br><br>2). A proper way to disable the local timer (vs. disabling all interrupts) on specific cores, as these cores would only need to run event based routines.<br>
<br>Best Regards,<br><br>Matthew Fornero<br>

------=_Part_85635_29369108.1225805277773--

