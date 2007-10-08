Message-ID: <bc4264770710081116n5d49911ah6aa0831ebd9023ae@domain.hid>
Date: Mon, 8 Oct 2007 18:16:48 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
In-Reply-To: <470A6B28.7020009@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>
	<470A6B28.7020009@domain.hid>
Subject: Re: [Xenomai-help] adeos patch for 2.6.21
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
Cc: xenomai-help <xenomai@xenomai.org>

Hi,

> > which adeos patch must I use?
>
> There is none for this kernel on i386 (assuming this is your arch). The
> easiest thing is to move forward to 2.6.22 - or you would have to
> back-port that patch... ;)
Ouch. How is that for bad luck.

> Xenomai 2.4 is required for kernels beyond 2.6.20 anyway.
Great.

> But note that we are still sweeping out remaining bugs around this
> kernel, see "Fix __ipipe_pin_range_globally" and "IO-APIC stall due to
> broken fasteoi handling" on Xenomai-core / Adeos-main. Moreover, today's
> SVN breaks at least my test box. So you may want to wait a few days at
> least, until the dust (hopefully) settled down again.
Not so great. But then, this at least gives me some time to upgrade to 2.6.22


I'll give a holler before I try patching.


Thanks.

Roland.

>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

