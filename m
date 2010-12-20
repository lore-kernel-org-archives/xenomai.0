From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTin39FEqnDAKQMVbf1GO9g_awXFiAp9oz4ShBuxX@mail.gmail.com>
References: <AANLkTin39FEqnDAKQMVbf1GO9g_awXFiAp9oz4ShBuxX@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Dec 2010 17:25:28 +0100
Message-ID: <1292862328.2007.41.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Ipipe support for 'longterm' kernel versions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-12-07 at 15:47 +0100, Henri Roosen wrote:
> Hi all,
> 
> I was pleased to read on the Linux Kernel Mailing List Greg's message
> about Linux stable kernel release procedure changes, that the longterm
> supported stable kernels will be made more explicit by getting the
> 'longterm' name.
> 
> https://lkml.org/lkml/2010/12/2/388
> 
> We are embedding Linux in products and therefore those longterm
> kernels are very valuable for us. We chose 2.6.32 kernel because of
> that a while ago.
> 
> However, unfortunately there is no Ipipe patch that applies cleanly on
> the latest 2.6.32.26 stable, nor is there an ARM version.
> 
> It would be great if Xenomai would also recognize this need and would
> do some kind of 'long term' support for the Ipipe for the longterm
> kernels.
>  I understand maintaining the Ipipe is a lot of work.
> Personally I think it would be an option to only support the longterm
> kernels...
> 
> What do the Xenomai/Ipipe developers think?

Only supporting the latest stable release would likely mean stalling the
support for new boards merged over time in regular releases, until a new
stable kernel is picked up -- our arm support would have a real problem
with that, and powerpc as well. Since Xenomai is primarily about
embedded configurations, this would not be acceptable.

Besides, what is deemed stable for the mainline kernel may not always be
the best option when considered from any given architecture. E.g,
picking 2.6.32 for running ARM mpcore is planning for headaches, albeit
it may be fine for others.

We understand the need for stability, and as a matter of fact, we
already have a stable branch for Xenomai releases exactly for this
purpose. But the task of tracking stable kernels over a long period of
time should really be tackled downstream. We could help for sure, but
this is not something we would consider as being on our plate.

> 
> Thanks,
> Henri.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



