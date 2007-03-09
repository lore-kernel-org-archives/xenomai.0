Message-ID: <bc4264770703090946h174cfd26o26f69e33e2fdde2b@domain.hid>
Date: Fri, 9 Mar 2007 17:46:38 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <cbe23c50703090836s21cee1fawcb46587af3230176@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPfGn-0003K5-RF@mailer.emlix.com>
	<bc4264770703090717u2a64c148g6000d0d64a488058@domain.hid>
	<200703091538.54236.paul_c@domain.hid>
	<bc4264770703090812u2fc582a6g3fbf1c382203da14@domain.hid>
	<cbe23c50703090836s21cee1fawcb46587af3230176@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Hi

> > Strangely
> > I have used CAN like this in a vxWorks environment where I was never
> > aware of CAN disrupting RT behavior this badly.
>
> I am only "listening" the conversation for learning a bit about
> xenomai usage and I am no CAN expert, but
>
> I think your implicit comparison is not fair.
> You seem to compare CAN usage under VxWorks on hardware
> which may be far away from your laptop + parallel port CAN I/F
> with Xenomai don't you ?
Am I ? It was running on a PC 486 but indeed with a PCI based CAN
adaptor. And I am not saying it was any better, only that I was not
aware of any latency problems. Who knows, maybe this problem is
inherent to CAN via sja chip on PC's?


>
> By the way I understand that your conclusion may be that
> using Parport CAN I/F on Xenomai Laptop does not fit your need.

Are you telling me this? Or asking? I have not drawn any conclusions
yet. Don't know enough about the driver to be able to tell. This
"bottom half" thread matter sounds rather interesting. ;-)

Roland.


>
>
> --
> Erk
>

