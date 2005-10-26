Message-ID: <435FB6CB.9030307@domain.hid>
Date: Wed, 26 Oct 2005 19:03:07 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid> <435F2DDA.1030702@domain.hid>
In-Reply-To: <435F2DDA.1030702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan!

Jan Kiszka wrote:
[...]
> Actually, there is already some howto, but I guess also enough room for
> improvements: http://www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon/

Cool! Thanks!

> Nope, RTDM devices are not being mapped into the Linux file system. They
> use a separate namespace where you can find serial devices as plain
> "rtser[X]".

I compiled the rt_serial_uprog, but it can't open rtser0:

# ./rt_serial_uprog
rt_serial_uprog: timer started
rt_serial_uprog: can't open rtser0 (write)
rt_serial_uprog: stop timer

# lsmod
Module                  Size  Used by
xeno_16550A            12392  0
xeno_rtdm              23460  1 xeno_16550A
xeno_native           114384  0
xeno_nucleus           82696  3 xeno_16550A,xeno_rtdm,xeno_native
xeno_hal               23616  4 xeno_16550A,xeno_rtdm,xeno_native,xeno_nucleus
[...]

rtser[X] should be available as soon as xeno_16550A is loaded, right ?

> Any frequent problems falling asleep? ;)

Usually not - we have national holiday today, so I was doing my stuff as long
as I wanted :-)

Thanks and best regards,
Hannes.

