Message-ID: <460B21C0.7090200@domain.hid>
Date: Thu, 29 Mar 2007 04:17:36 +0200
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Latencies due to RT-Socket-CAN register
	accesses
References: <45F68258.5040603@domain.hid> <45F6A44A.2030000@domain.hid>	
	<45F6A73C.8030301@domain.hid> <45F6AA11.40707@domain.hid>
	<bc4264770703281005v17fc4802v53728cda11cb6b17@domain.hid>
	<460AB8FF.5060904@domain.hid>
In-Reply-To: <460AB8FF.5060904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Hi Wolfgang,

I think that this kind of latency should be fine for controller 
intervals of 1ms.

Another question:
The PC has a 3Ghz processor and an 800Mhz FSB. That should not class as 
"slow" in the conventional sense. What hardware is responsible for the 
latency i.e. makes the PC "slow" from the RT perspective? In other words 
what must one look at when purchasing a machine that should give minimal 
latency?

Regards,

Roland.


Wolfgang Grandegger wrote:
> roland Tollenaar wrote:
>> Hi Wolfgang,
>>
>> Just to answer an open question still
>>
>>> > BTW, what are the latencies you measure on your system under load
>>> > (without RT-Socket-CAN).
>>
>> lat min 20.952
>> lat ave 31.009
>> lat max 60.504
>> lat best 19.276
>>
>> this was with the loading as you described in this thread and running
>> for 12 hours.
>>
>> Anything special about the above figures? Not very good I presume but
>> I am not running with tsc enabled.
> 
> The latencies depend a lot on the hardware. The minimal latency of 20 us 
> indicates, that you have a rather slow system. Then a maximum of 60 us 
> is reasonable. Note that worst case latencies of better than 20us are 
> difficult to achieve, even with high end PCs.
> 
> Wolfgang.
> 
>> Kind regards,
>>
>> Roland
>>
>>
>>
>>>
>>> Roland
>>>
>>>
>>> >
>>> > Wolfgang.
>>> >
>>> >> Thanks,
>>> >>
>>> >> Roland
>>> >>
>>> >>
>>> >>
>>> >> Wolfgang Grandegger wrote:
>>> >>> Hallo,
>>> >>>
>>> >>> in the meantime I have measured the latencies introduced through
>>> >>> messages sent and received by RT-Socket-CAN. The SJA1000 register
>>> >>> access times on my rather old PC with an Athlon 1100 Mhz are:
>>> >>>
>>> >>> PEAK-Dongle: read  access: 11807 ns
>>> >>> PEAK-Dongle: write access: 11677 ns
>>> >>>
>>> >>> IXXAT-PCI  : read  access:   729 ns
>>> >>> IXXAT-PCI  : write access:   305 ns
>>> >>>
>>> >>> I measured an increase of the latency of approx. 170us with the
>>> >>> PEAK-Dongle and approx 13us with the IXXAT-PCI card for the 
>>> reception
>>> >>> of a full CAN message (with 8 bytes payload). Sending messages is a
>>> >>> bit less disturbing. I have attached a small patch to measure the
>>> >>> SJA1000 register access times when the driver is initialized. You 
>>> are
>>> >>> welcome to apply it on your setup and report the results. I'm
>>> >>> especially interested in numbers for the ISA bus (or PC-104).
>>> >>>
>>> >>> Wolfgang.
>>> >>>
>>> >>>
>>> >>>
>>> >>> 
>>> ------------------------------------------------------------------------
>>> >>>
>>> >>> + diff -u xenomai/ksrc/drivers/can/rtcan_dev.c.IOTEST
>>> >>> xenomai/ksrc/drivers/can/rtcan_dev.c
>>> >>> + diff -u xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c.IOTEST
>>> >>> xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c
>>> >>> --- xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c.IOTEST
>>> >>> 2007-02-26 09:17:27.000000000 +0100
>>> >>> +++ xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c    2007-03-13
>>> >>> 10:01:47.000000000 +0100
>>> >>> @@ -728,6 +728,30 @@
>>> >>>      if (chip == NULL)
>>> >>>      return -EINVAL;
>>> >>>
>>> >>> +#if 1
>>> >>> +    {
>>> >>> +    nanosecs_abs_t begin, diff;
>>> >>> +    volatile u8 reg;
>>> >>> +    int i, count = 100000;
>>> >>> +    begin = rtdm_clock_read();
>>> >>> +    for (i = 0; i < count; i++) {
>>> >>> +        reg = chip->read_reg(dev, 0);
>>> >>> +    }
>>> >>> +    diff = rtdm_clock_read() - begin;
>>> >>> +    printk("%s: register read time for %d accessed: %ld (%ld per
>>> >>> access)\n",
>>> >>> +           dev->board_name, count,
>>> >>> +           (unsigned long)diff, (unsigned long)diff / count);
>>> >>> +    begin = rtdm_clock_read();
>>> >>> +    for (i = 0; i < count; i++) {
>>> >>> +        chip->write_reg(dev, 0, reg);
>>> >>> +    }
>>> >>> +    diff = rtdm_clock_read() - begin;
>>> >>> +    printk("%s: register write time for %d accessed: %ld (%ld per
>>> >>> access)\n",
>>> >>> +           dev->board_name, count,
>>> >>> +           (unsigned long)diff, (unsigned long)diff / count);
>>> >>> +    }
>>> >>> +#endif
>>> >>> +
>>> >>>      /* Set dummy state for following call */
>>> >>>      dev->state = CAN_STATE_ACTIVE;
>>> >>>      /* Enter reset mode */
>>> >>
>>> >>
>>> >
>>> >
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>
>>
> 
> 

