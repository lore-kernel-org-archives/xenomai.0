Message-ID: <bc4264770703090812u2fc582a6g3fbf1c382203da14@domain.hid>
Date: Fri, 9 Mar 2007 16:12:14 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <200703091538.54236.paul_c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
	<200703091538.54236.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Hi Paul,

> I think it was Sebastian that said there are 14 reads and one write per
> interrupt - If this is the case, then looking at the Peak parport dongle
> driver, I see eight IO instructions per read and six per write. A total of
> 118 inb(). outb() calls - Not a particulaly large amount, however, a standard
> parallel port takes one to two microseconds to service each call, so 200uSec
> for the interrupt handler would quite reasonable..

There is no way I can comment on that. But I am happy to believe it.
What baffles me a bit  then is that the behavior cannot be classified
as very "Real-Time" can it? I cannot imagine that the developers of
rt-can overlooked this. I doubt that it will be possible to run a
discrete state-space controller successfully on a platform that
juggles around its period-times as badly as I am experiencing. And I
still need to read discrete IO and write DIO and AIO to another CAN
node which is not yet even connected.

>
>  One way to reduce the time spent servicing IO instructions would be to switch
> to a PCI based parport card (not sure if it would be compatable with the
> driver & dongle).. Or alternatively use a PCI CANbus card.
Developing from a laptop using PCI cards is a bit uncomfortable. Hence
the choice for the parport. Also what improvement could I expect?
Latencies of 100 micro seconds are still not that fantastic. Strangely
I have used CAN like this in a vxWorks environment where I was never
aware of CAN disrupting RT behavior this badly.



Regards,

Roland.




>
>
> Regards, Paul.
>
>

