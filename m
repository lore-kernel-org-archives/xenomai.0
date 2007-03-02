Message-ID: <45E7E49C.2000005@domain.hid>
Date: Fri, 02 Mar 2007 09:47:24 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
In-Reply-To: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi,
> 
> My dongle has arrived and seems to be OK under windows.
> 
> I am now trying to install it under linux but things not looking good so 
> far.
> 
> from
> 
> /lib/modules/2.6.16-xen-3/kernel/drivers/xenomai/can/sja1000
> 
> I ran
> 
> $>depmod xeno_can_peak_dng.ko
> $>modprobe xeno_can_peak_dng type=epp io=0x378 irq=7

Are these the options you used for Windoze as well?

> but the result is:
> 
> FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No such 
> device

Is there som additional kernel output visible via "dmesg"?

> The little led is glowing. And the dongle is even plugged in to the
> only parallel port my machine has :)
> Nothing is connected to the output of the dongle at this stage.
> 
> Am I missing something fundamental here?

How do you have configured the parport in the kernel? Are there modules 
loaded (check /proc/modules)? Retry after removing lp and parport_pc:

   $ rmmod lp
   $ rmmod parport_pc

Wolfgang.

