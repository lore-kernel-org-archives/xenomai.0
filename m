Message-ID: <47EAE459.90307@domain.hid>
Date: Thu, 27 Mar 2008 01:03:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080326143644.GB11244@domain.hid>
In-Reply-To: <20080326143644.GB11244@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [SOLO] [PATCH] Obtain proper prefix for
 testsuite build
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jserv@domain.hid
Cc: xenomai@xenomai.org

jserv@domain.hid wrote:
> Hello list,
> 
>   Currently, Xenomai/SOLO comes with testsuite for VxWorks emulation.
> The path to Xenomai/SOLO installation is fixed.  The patch attempts to
> obtain the proper prefix during build process.
> 
> Regards,
> -jserv
> 
> diff --git a/vxworks/testsuite/Makefile b/vxworks/testsuite/Makefile
> index 62430ff..13ca9a0 100644
> --- a/vxworks/testsuite/Makefile
> +++ b/vxworks/testsuite/Makefile
> @@ -1,4 +1,4 @@
> -SOLO := /usr/local/solo
> +SOLO := $(shell sed -n '/^prefix/'p ../Makefile | cut -c 9-)
>  XENO_CONFIG=$(SOLO)/bin/xeno-config
>  prefix := $(shell $(XENO_CONFIG) --prefix)
>

This won't work if you build out of the source tree like autoconf/automake
recommend, since it won't find the instantiated Makefile in the upper directory.
We could use an autoconf template to patch the prefix into
testsuite/Makefile.in, but the testsuite/ directory is meant to be movable and
compilable anywhere the user sees fit. This is basically why the Makefile has
not been autoconfiscated in the first place.

I guess we will have to leave with the "set your Xenomai install directory for
scripts and binaries in your PATH variable" rule. I have removed the absolute
SOLO prefix from the Makefile though, it was a left over from my development
environment.

Thanks for spotting this.

-- 
Philippe.

