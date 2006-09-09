Message-ID: <45029903.7030108@domain.hid>
Date: Sat, 09 Sep 2006 12:35:47 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <450290AC.6000009@domain.hid>
In-Reply-To: <450290AC.6000009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: CAN updates & questions
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
> as one result of a hacking session on a PPC405 with SJA1000 on board I
> applied two minor fixes to rtcan_isa.c to SVN, see end of mail for
> reference. The first one gave an "interesting" effect on big-endian
> because irq is an integer, the second one reveals that we should do some
> multiport test with the ISA driver soon.

OK, I see. Unfortunately I do not have a ISA CAN device for testing.

> Questions arose regarding the meaning of rtcan_device.can_sys_clock
> (BTW, comment in rtcan_dev.h is wrong). What clock rate does it
> describe? For the SJA1000 drivers its obviously clock/2. I'm asking
> because of a) the output in rtcan_calc_bit_time() and b) the module
> parameter of rtcan_isa and its description. We first hacked 16 MHz into
> the latter yesterday as I didn't recall quickly enough that our Phytec
> board also runs at 16 MHZ, thus the default value of 8 MHZ was already
> correct. Confused? At least we were...

You have to define the real CAN system clock, which is 16/2 = 8 Mhz for 
most SJA 1000 hardware even if the oscillator is running at 16 MHz. I 
will add some reasonable note to rtcan_dev.h

> And another suggestion: In order make module names shorter, what about
> the renaming xeno_rtcan* -> xeno_can*?

Fine for me.

> Then we will soon have to discuss how to deal with a rtcan_isa
> derivative that uses ioremapped memory instead of ports (naming,
> separation or integration).

We could add a generic device similar to ISA (or extend ISA accordingly).

> 
> Jan
> 

Wolfgang.

> --
> 
> Index: ksrc/drivers/can/sja1000/rtcan_isa.c
> ===================================================================
> --- ksrc/drivers/can/sja1000/rtcan_isa.c	(Revision 1564)
> +++ ksrc/drivers/can/sja1000/rtcan_isa.c	(Arbeitskopie)
> @@ -56,7 +56,7 @@ static u8 ocr[RTCAN_ISA_MAX_DEV];
>  static u8 cdr[RTCAN_ISA_MAX_DEV];
> 
>  compat_module_short_param_array(isa, RTCAN_ISA_MAX_DEV);
> -compat_module_byte_param_array(irq, RTCAN_ISA_MAX_DEV);
> +compat_module_int_param_array(irq, RTCAN_ISA_MAX_DEV);
>  compat_module_int_param_array(clock, RTCAN_ISA_MAX_DEV);
>  compat_module_byte_param_array(ocr, RTCAN_ISA_MAX_DEV);
>  compat_module_byte_param_array(cdr, RTCAN_ISA_MAX_DEV);
> @@ -187,9 +187,10 @@ static void __exit rtcan_isa_exit(void)
>      int i;
>      struct rtcan_device *dev;
> 
> -    for (i = 0, dev = rtcan_isa_devs[i];
> -	 i < RTCAN_ISA_MAX_DEV && dev != NULL;
> -	 i++) {
> +    for (i = 0; i < RTCAN_ISA_MAX_DEV; i++) {
> +	dev = rtcan_isa_devs[i];
> +	if (!dev)
> +	    continue;
>  	rtcan_sja1000_unregister(dev);
>      }
>  }
> 


