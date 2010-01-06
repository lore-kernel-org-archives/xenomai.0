Message-ID: <4B450668.70107@domain.hid>
Date: Wed, 06 Jan 2010 22:53:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai on arm926ejs based SOCs.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>


Hi

Short explanation: please all users of SOCs based on the arm926ejs core,
boot your xenomai-patched kernel with the "nohlt" parameter.

Long explanation: Bosko, I have finally found the reason for the strange
problem you had when an interrupt handler could take a long time to
execute when preempting the idle task, which you solved by booting the
kernel with the nohlt parameter.

The I-pipe patch modifies the ARM idle loop to run the hardware-specific
idle callback (arch_idle) with hardware interrupts enabled. But the
arm926ejs idle callback disables the I-cache, then calls the
"wait-for-interrupt" instruction, then re-enables the I-cache. So, when
CONFIG_IPIPE is active, if an interrupt happens when the idle loop is
stopped in the "wait-for-interrupt" instruction (which happens all the
time, really, on an unloaded system), the interrupt preempts the idle
loop immediately, that is before the I-cache is re-enabled, and the
whole interrupt handling, including switching-to and running some
xenomai task, happens with I-cache off. A disaster.

So, Bosko, your interrupt handler was running with I-cache off.

Obviously, next releases of the I-pipe patch will no longer call
arch_idle with hardware irqs on. But in the mean-time, you have to boot
your kernel with the nohlt parameter.

Sorry for the inconvenience.

Regards.

-- 
					    Gilles.

