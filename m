Message-ID: <476FC124.7050601@domain.hid>
Date: Mon, 24 Dec 2007 15:24:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200712231747.35449.niklaus.giger@domain.hid>
	<200712241354.43936.paul_c@domain.hid>
In-Reply-To: <200712241354.43936.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Buildbot is back (and reporting errors)
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
> Hi Niklaus
> 
> On Sunday 23 December 2007 16:47, Niklaus Giger wrote:
>>> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c: In
>>> function 'lbmStartIO':
>>> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2165:
>>> error: too many arguments to function 'lbmIODone'
> <snip>
>>> /var/buildbot/slave/ppc_f/linux-2.6-xenomai/drivers/net/via-rhine.c:44:1:
>>> error: unterminated #ifndef make[3]: *** [drivers/net/via-rhine.o] Error
> 
> Attached patch resolves the two above errors - I too fell foul of them with an 
> unpatched build (along with a couple in the USB code).
> 
>>> /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:341:
>>> error: implicit declaration of function 'get_paca'
> 
> This one is from the Xenomai patch - get_paca is found in asm-powerpc/paca.h 
> which is conditionally included when CONFIG_PPC64 is defined. I suspect line 
> 340 should read:
> 
> #if defined(CONFIG_IPIPE) && defined(CONFIG_PPC64)
> 

This one is a left-over from the 2.6.23/powerpc/ to ppc/ backport. We
should have no hunk at this location, since we do not support SMP with
this backport anyway, only embedded uniprocessor 32bit platforms still
lagging behind the powerpc/ merge.

> It bit me at line 549 in arch/powerpc/kernel/smp.c...

Ok, fixed in the upcoming 2.0-06.

-- 
Philippe.

