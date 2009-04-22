Message-ID: <49EF726D.70000@domain.hid>
Date: Wed, 22 Apr 2009 21:39:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1240428903.3403.8.camel@domain.hid>
In-Reply-To: <1240428903.3403.8.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] powerpc and fastsync
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jpl@domain.hid
Cc: xenomai@xenomai.org

Joshua Lamorie wrote:
> Gidday there,
> 
> I am using Xenomai-trunk on a Virtex-II Pro (PowerPC 405) using a
> patched version of DENX-2.6.28.5 (using
> adeos-ipipe-2.6.28.5...2.4-04.patch as a base).
> 
> This was working fine up until the beginning of April when it appears
> that the configure.in and configure scripts were changed for powerpc.
> The SVN revision(commit) 4681 removed CONFIG_XENO_FASTSYNCH=y.  However,
> in ksrc/arch/powerpc/Kconfig, XENO_FASTSYNCH is still set to 'y'.
> 
> Is this normal?

No this is not normal and has been fixed in xenomai 2.5-rc1. The svn
repository is no longer used, we use git now. See http://www.xenomai.org
for details on how to fetch the code in git repositories.

-- 
					    Gilles.

