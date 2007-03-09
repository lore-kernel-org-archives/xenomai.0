Message-ID: <cbe23c50703090836s21cee1fawcb46587af3230176@domain.hid>
Date: Fri, 9 Mar 2007 17:36:07 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <bc4264770703090812u2fc582a6g3fbf1c382203da14@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
	<200703091538.54236.paul_c@domain.hid>
	<bc4264770703090812u2fc582a6g3fbf1c382203da14@domain.hid>
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
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

2007/3/9, roland Tollenaar <rolandtollenaar@domain.hid>:
>
> >
> >  One way to reduce the time spent servicing IO instructions would be to switch
> > to a PCI based parport card (not sure if it would be compatable with the
> > driver & dongle).. Or alternatively use a PCI CANbus card.
> Developing from a laptop using PCI cards is a bit uncomfortable. Hence
> the choice for the parport. Also what improvement could I expect?
> Latencies of 100 micro seconds are still not that fantastic.

> Strangely
> I have used CAN like this in a vxWorks environment where I was never
> aware of CAN disrupting RT behavior this badly.

I am only "listening" the conversation for learning a bit about
xenomai usage and I am no CAN expert, but

I think your implicit comparison is not fair.
You seem to compare CAN usage under VxWorks on hardware
which may be far away from your laptop + parallel port CAN I/F
with Xenomai don't you ?

By the way I understand that your conclusion may be that
using Parport CAN I/F on Xenomai Laptop does not fit your need.


-- 
Erk

