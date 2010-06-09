Content-Type: text/plain; charset="utf-8"
Date: Wed, 09 Jun 2010 10:48:23 +0200
From: "Nils Armbruster" <nils-a@domain.hid>
Message-ID: <20100609084823.99850@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] xeno_can_mem driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smolorz@domain.hid
Cc: xenomai@xenomai.org

Thank you for your reply !

>>  I'm currently trying to get the can-interfaces of an Samsung S3C2440
>>   based board working (NetDCU10). The used Linux kernel version is 
>> 2.6.19,
>>   because this was deliverd in the BSP. I patched this kernel with 
>> Xenomai
>>   2.4.0., as this was the newest Version I managed the Kernel to compile
>>   with.
>>
>>  The standard driver delivered with the board (lincan 0.3.3) mappes the
>>   can devices to 10000000-10000007 : onboard-can
>>  10000008-1000000f :
>>  onboard-can
> 
> Hmm, the SJA1000 has 32 registers, not just 8.
> 

This is strange, cause the original driver just maps these 8 registers.

>>  So I tried to use the driver xeno_can_mem.
>>
>>  I use
>>  modprobe xen_can_mem mem=0x10000000 irq=17 clock=48000000
> 
> Are you sure you give the right clock frequency? Seems to be too high.
> 

I used this clock frequency because I noticed, that the frequency is divided by 2. So I just tried it.
The frequency I found in the original driver is 24MHz.
But even with clock=24000000 it appears "No such device".

>>  to install the module but it complains that there is no such device...
>>
>>  As far as I know, this board uses the an sja1000p chip for can. Do you
>>   know if there are any differences to the sja1000 chip? Are there any
>>   changes necessary in the driver sources?
>>
>>  I figured out, that the installation of the driver stops in the function
>>   int rtcan_sja1000_register(struct rtcan_device *dev) And there in that
>>   part:
>>
>>      printk("chip->read_reg(dev, SJA_SR) = %d \n",chip->read_reg(dev,
>>   SJA_SR)); if ((chip->read_reg(dev, SJA_SR)&
>>      (SJA_SR_RBS | SJA_SR_DOS | SJA_SR_TBS)) != SJA_SR_TBS) {
>>      printk("ERROR! No SJA1000 device found!\n");
>>      return -ENODEV;
>>      }
>>
>>  When I comment this out the installation works and in /proc/iomem
>>   sja1000-mem is visible. But I'm not able to send Can-messages with
>>   rtcansen.
>>  The program seems to work, but no messages are send as I checked it with
>>   a scope.
> 
> There is no point in commenting out the driver's check for the existence of
> the SJA1000 and complain that it does not work. This check is there for a
> good reason.
> 

It was just a try to find out where the problem comes from.

>>
>>  Does anybody have an hint for me, how to get the can driver working?
> 
> First find out where the 32 registers of the SJA1000 are mapped and also
> check the clock frequency.
>

Sorry for my stupid question, but how can I find out where the registers are mapped?
In the original driver the base address is defined as 0x10000000.
Port size ist defined as 4 and when the memory region is requested twice of the port size is requested:
request_mem_region(mem_addr, nx_can->if_portsize * 2, "onboard-can")

Do you have any suggestions how I should proceed?

Thank you!
 
Best regards,

Nils 

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01

