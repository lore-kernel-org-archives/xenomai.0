Message-ID: <45670C26.3060408@domain.hid>
Date: Fri, 24 Nov 2006 16:13:42 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4566F619.9060403@domain.hid> <4567033F.1090206@domain.hid>
In-Reply-To: <4567033F.1090206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] RT-Socket-CAN update, please read
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Wolfgang,
> 
> some more comments after looking at code and running a compiler:
> 
> ...
>> 	* ksrc/drivers/can/rtcan_raw.c,
>> 	ksrc/drivers/can/sja1000/rtcan_sja1000.c,
>> 	ksrc/drivers/can/mscan/rtcan_mscan.c: timestamps are now read and
>> 	copied in rtcan_recv() and rtcan_tx_loopbcak().
> 
> ...thus multiple times in the same IRQ context if there are multiple
> packets pending. Do we gain enough from the new design that helps to
> compensate the drawback (considering slow rtdm_clock_read()

I think you agree, that it's unlikely, that an RX interrupt is handled 
together with an TX done or an error interrupt. And we save reading the 
timestamp when there is just a TX done interrupt (without TX loopback, 
of course). It makes the driver dependent code simpler and cleaner.

> implementations)? Moreover, we may see a feature one day that the RTDM
> layer will provide you timestamps for an IRQ event (e.g. when the
> handler will be running at higher latency as a thread).

Then we need to modify the interface to the driver anyhow.

> ...
>> 	* ksrc/drivers/can/mscan/Kconfig, ksrc/drivers/can/sja1000/Kconfig,
>> 	ksrc/drivers/can/Kconfig: add more help for kernel parameters.
> 
> Suggestion: N x "depends on XYZ" => 1 x "if XZY != n ... endif"

OK, no priority though.

> ...
>> 	* ksrc/drivers/can/sja1000/rtcan_sja1000.c,
>> 	ksrc/drivers/can/sja1000/rtcan_isa.c,
>> 	ksrc/drivers/can/sja1000/rtcan_mem.c,
>> 	ksrc/drivers/can/sja1000/rtcan_peak_pci.c,
>> 	ksrc/drivers/can/sja1000/rtcan_peak_dng.c: Remove rtcan_dev_free()
>> 	from rtcan_sja1000_unregister() to allow proper cleanup after the
>> 	device has been unregistered.
> 
> [2.4.33 build for x86]
> rtcan_peak_dng.c: In function `rtcan_peak_dng_exit_one':
> rtcan_peak_dng.c:315: warning: implicit declaration of function
> `rtcan_free_dev'

Yes, I realized already this bug.

> [Not related to this change]
> In order to use the parport dongle also with recent PnP ports (e.g. in
> notebooks), you may want to have a look at the code I added to irqbench
> for this purpose:
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/testing/irqbench.c?v=SVN-trunk#496
> 
> The background is that once you unload the parport module, the port will
> be powered off.

Are there still laptops with parallel ports? Anyhow, I'm going to check 
that.

> ...
>> 	* src/drivers/Makefile, ksrc/drivers/can/*, scripts/Modules.frag,
>> 	src/utils/can/README: Replace "rtcan" with "can" in macro definitions
>> 	CONFIG_XENO_DRIVERS_RTCAN_* and module names xeno_rtcan_* to comply to
>> 	the common naming scheme.
> 
> Hmm, wouldn't shortening some file names also make sense then?

Well, we could remove "rtcan_", but I have not time to do it now.

> Jan
> 
> 
> PS: 2.4 help patching and updating work nicely for me - except for
> choices which is obviously a 2.4 bug. I saw that the kernel then
> sometimes stuffs all information into the first item. Maybe scriptable
> for Xenomai... :->

Yes, I observed the same behavior.

Wolfgang.



