MIME-Version: 1.0
Date: Tue, 7 Dec 2010 15:47:43 +0100
Message-ID: <AANLkTin39FEqnDAKQMVbf1GO9g_awXFiAp9oz4ShBuxX@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Ipipe support for 'longterm' kernel versions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I was pleased to read on the Linux Kernel Mailing List Greg's message
about Linux stable kernel release procedure changes, that the longterm
supported stable kernels will be made more explicit by getting the
'longterm' name.

https://lkml.org/lkml/2010/12/2/388

We are embedding Linux in products and therefore those longterm
kernels are very valuable for us. We chose 2.6.32 kernel because of
that a while ago.

However, unfortunately there is no Ipipe patch that applies cleanly on
the latest 2.6.32.26 stable, nor is there an ARM version.

It would be great if Xenomai would also recognize this need and would
do some kind of 'long term' support for the Ipipe for the longterm
kernels. I understand maintaining the Ipipe is a lot of work.
Personally I think it would be an option to only support the longterm
kernels...

What do the Xenomai/Ipipe developers think?

Thanks,
Henri.

