Message-ID: <4CFE75F6.9030908@domain.hid>
Date: Tue, 07 Dec 2010 18:59:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTin39FEqnDAKQMVbf1GO9g_awXFiAp9oz4ShBuxX@mail.gmail.com>
In-Reply-To: <AANLkTin39FEqnDAKQMVbf1GO9g_awXFiAp9oz4ShBuxX@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Am 07.12.2010 15:47, Henri Roosen wrote:
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
> kernels. I understand maintaining the Ipipe is a lot of work.
> Personally I think it would be an option to only support the longterm
> kernels...
> 
> What do the Xenomai/Ipipe developers think?

Of course, supporting kernel releases over a longer period is a good
thing. However, it takes resources to do this job, to backport fixes or
even features from latest I-pipe versions and to resolve patch conflicts
over older kernels. If you are willing to support our community, you are
always welcome!

How this new (actually it is not that new) longterm strategy of the
Linux kernel will influence I-pipe tip development is not yet well
predictable. Right now I would say the need for certain features only
available in newer kernels will continue to drive updates of I-pipe, not
that some kernel is declared longterm stable. But this also depends on
when the longterm tags will be announced, ahead of releases or much later.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

