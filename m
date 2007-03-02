Message-ID: <45E7E646.7010006@domain.hid>
Date: Fri, 02 Mar 2007 09:54:30 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
	<45E7E31B.1090102@domain.hid>
In-Reply-To: <45E7E31B.1090102@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> roland Tollenaar wrote:
>> Hi,
>>
>> My dongle has arrived and seems to be OK under windows.
>>
>> I am now trying to install it under linux but things not looking good so
>> far.
>>
>> from
>>
>> /lib/modules/2.6.16-xen-3/kernel/drivers/xenomai/can/sja1000
>>
>> I ran
>>
>> $>depmod xeno_can_peak_dng.ko
>> $>modprobe xeno_can_peak_dng type=epp io=0x378 irq=7
>>
>> but the result is:
>>
>> FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No such
>> device
>>
>> The little led is glowing. And the dongle is even plugged in to the
>> only parallel port my machine has :)
>> Nothing is connected to the output of the dongle at this stage.
>>
>> Am I missing something fundamental here?
>>
> 
> Maybe a conflict with parport_pc.

Yes, because it already grabs/registers the interrupt:

   $ grep par /proc/interrupts
     7:          3          XT-PIC  parport0

> Wolfgang, do we always have to remove that module, or is there a chance
> to cooperate with it without loosing real-time? When removing the Linux
> parport layer, there is the risk that the port is powered off (see
> irqbench), and xeno_can_peak_dng does not account for this yet.

That's the tricky part, indeed. On my Laptop I need to disabled the 
parport support completely for proper operation. On my PC that does not 
work for some strange reasons. I need parport loaded and parport_pc 
removed. We still need the PNP fix to avoid the problem you described 
with power off.

Wolfgang.

