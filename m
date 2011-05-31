Message-ID: <4DE5205C.1050706@domain.hid>
Date: Tue, 31 May 2011 19:07:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DE51CE7.3040001@domain.hid>
In-Reply-To: <4DE51CE7.3040001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trouble running PEAK CAN board on Atom N270 with
	Xenomai 2.5.5.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrew Tannenbaum <trb@domain.hid>
Cc: xenomai@xenomai.org

On 2011-05-31 18:52, Andrew Tannenbaum wrote:
> I am having trouble getting my PEAK CAN board running under
> Linux/Xenomai.  It crashes when it loads xeno_can_peak_pci.ko.
> 
> I tried mailing to PEAK Linux support, but they said they had no one
> providing Linux RT support at this time.
> 
> I have an Advantech PCM-9361 PCI104 Atom N270 motherboard with a PEAK
> PCI104 CAN 2-channel board.
> 
> I plugged the CAN board into the Atom board, and I plugged a Copley
> Accelnet servo into the first port of the CAN board.
> 
> I installed a copy of Ubuntu 10.04.2 LTS on the Atom, that distro kernel
> runs ok.
> 
> I downloaded a copy of Linux 2.6.35.7 from kernel.org, and compiled it
> (mostly with the Ubuntu distro config), that runs ok.
> 
> I downloaded a copy of Xenomai 2.5.5.2 from xenomai.org, and patched the
> 2.6.35.7 to provide basic Xenomai functionality, including POSIX and
> RTDM interfaces, and I was able to run the Xenomai testsuite/latency
> test with decent latency.
> 
> Note that in my current kernel, I turned CONFIG_XENO_HW_SMI_WORKAROUND
> off, because I had been getting the "SMI workaround failed" message:
> 
> May 24 17:02:00 atom1 kernel: [    1.252782] I-pipe: Domain Xenomai
> registered.
> May 24 17:02:00 atom1 kernel: [    1.252900] Xenomai: hal/i386 started.
> May 24 17:02:00 atom1 kernel: [    1.252960] Xenomai: scheduling class
> idle registered.
> May 24 17:02:00 atom1 kernel: [    1.252970] Xenomai: scheduling class
> rt registered.
> May 24 17:02:00 atom1 kernel: [    1.256862] Xenomai: real-time nucleus
> v2.5.5.2 (Ghosts) loaded.
> May 24 17:02:00 atom1 kernel: [    1.257212] Xenomai: SMI-enabled
> chipset found
> May 24 17:02:00 atom1 kernel: [    1.257238] Xenomai: SMI workaround
> failed!
> May 24 17:02:00 atom1 kernel: [    1.257328] Xenomai: starting native
> API services.
> May 24 17:02:00 atom1 kernel: [    1.257340] Xenomai: starting POSIX
> services.
> May 24 17:02:00 atom1 kernel: [    1.257430] Xenomai: starting RTDM
> services.
> 
> I understand that 2.5.6 is current Xenomai, but I started this a few
> months ago, so I'm running 2.5.5.2.
> 
> At this point, I was ready to try to talk with the PEAK CAN board, so I
> turned on
> 
> CONFIG_XENO_DRIVERS_CAN_SJA1000=m
> CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI=m
> 
> Without driver support for the board, lspci sees the CAN board.  I want
> to talk to the board using the Xenomai interface, but I am not sure of
> the best way to make that work.
> 
> I downloaded and compiled peak-linux-driver-7.2 (I'm not sure that is
> necessary, so I won't discuss that yet.)
> 
> Here is the PEAK board stanza from lspci -v:
> 
> 01:04.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
> controller (rev 02)
>     Subsystem: PEAK-System Technik GmbH Device 0004
>     Flags: medium devsel, IRQ 10
>     Memory at fdcd0000 (32-bit, non-prefetchable) [size=64K]
>     Memory at fdce0000 (32-bit, non-prefetchable) [size=64K]
>     Kernel modules: xeno_can_peak_pci
> 
> I have not been able to run a kernel that with the Xenomai/Linux CAN/PCI
> driver.  It fails during the boot process when loading the PEAK driver.
> 
> If I move the CAN/PEAK drivers out of the way, the kernel runs correctly
> (as a Linux kernel - not talking with the CAN board).  I moved these
> drivers aside, adding ".no" to the names:
> 
> ./kernel/drivers/xenomai/can/sja1000/xeno_can_sja1000.ko.no
> ./kernel/drivers/xenomai/can/sja1000/xeno_can_peak_pci.ko.no
> 
> I can insmod these by hand, the SJA1000 driver loads ok, the PEAK driver
> causes the system to freeze.  tail /var/log/syslog looks like this:
> 
> May 31 12:14:25 atom1 kernel: [410578.847836] RTCAN SJA1000 driver
> initialized
> May 31 12:15:19 atom1 kernel: [410632.808061] PEAK-PCI-CAN: initializing
> device 001c:0001
> May 31 12:15:19 atom1 kernel: [410632.808106] PEAK-PCI-CAN 0000:01:04.0:
> PCI INT A -> GSI 16 (level, low) -> IRQ 16

Important are the IRQs reported while loading. The PCI config space data
lspci is listing is more informational. If other devices share the same
IRQ, you lose unless
 - you can move those other devices elsewhere (change slot, disable
   device)
 - you can move the CAN adapter to a different slot, thus - maybe - to
   a different IRQ

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

