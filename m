MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <634c78ce0912040535l753f267cycb3ea7057bfc432c@domain.hid>
References: <634c78ce0912040535l753f267cycb3ea7057bfc432c@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Fri, 4 Dec 2009 14:41:34 +0100
Message-ID: <634c78ce0912040541u6484e100i8296ce4e73c470dc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] undefined symbols in xeno_nucleus
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

On Fri, Dec 4, 2009 at 14:35, Peter Soetens <peter@domain.hid> wrot=
e:
> When compiling xenomai-head (master) from today with vanilla Linux
> 2.6.31.1 for amd64/smp, most of xenomai compiled as modules, I get at
> the end of the build process this:
>
> =A0Building modules, stage 2.
> =A0MODPOST 2169 modules
> ERROR: "per_cpu__cpu_tlbstate"
> [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!
> ERROR: "per_cpu__irq_stack_union"
> [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!
> WARNING: modpost: Found 12 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
> make[2]: *** [__modpost] Error 1

This goes away when compiling xeno_nucleus into the kernel.

Peter

