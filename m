Date: Fri, 28 Mar 2008 20:10:32 +0800
From: jserv@domain.hid
Message-ID: <20080328121032.GB31103@domain.hid>
References: <20080326143644.GB11244@domain.hid>
	<47EAE459.90307@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <47EAE459.90307@domain.hid>
Subject: Re: [Xenomai-core] [SOLO] [PATCH] Obtain proper prefix
	for	testsuite build
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Mar 27, 2008 at 01:03:37AM +0100, Philippe Gerum wrote:
> This won't work if you build out of the source tree like autoconf/automake
> recommend, since it won't find the instantiated Makefile in the upper directory.
> We could use an autoconf template to patch the prefix into
> testsuite/Makefile.in, but the testsuite/ directory is meant to be movable and
> compilable anywhere the user sees fit. This is basically why the Makefile has
> not been autoconfiscated in the first place.

hi Philippe,

Indeed.  It was just my dirty hack.  Thanks for pointing out the
details.

> I guess we will have to leave with the "set your Xenomai install directory for
> scripts and binaries in your PATH variable" rule. I have removed the absolute
> SOLO prefix from the Makefile though, it was a left over from my development
> environment.

Good instructions. :-)

Regards,
-jserv

