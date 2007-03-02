Message-ID: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
Date: Fri, 2 Mar 2007 08:23:26 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] problems installing peak CAN dongle
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

Hi,

My dongle has arrived and seems to be OK under windows.

I am now trying to install it under linux but things not looking good so far.

from

/lib/modules/2.6.16-xen-3/kernel/drivers/xenomai/can/sja1000

I ran

$>depmod xeno_can_peak_dng.ko
$>modprobe xeno_can_peak_dng type=epp io=0x378 irq=7

but the result is:

FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No such device

The little led is glowing. And the dongle is even plugged in to the
only parallel port my machine has :)
Nothing is connected to the output of the dongle at this stage.

Am I missing something fundamental here?

Thanks for your time.

Regards,

Roland

