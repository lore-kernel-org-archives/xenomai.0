From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E1Gxi6o-00065F-Ef@domain.hid>
References: <E1Gxi6o-00065F-Ef@domain.hid>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 12:25:23 +0100
Message-Id: <1166786723.4960.182.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: adeos-ipipe-2.6.15-arm-1.5-03.patch
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-12-22 at 11:58 +0100, Sebastian Smolorz wrote:
> Hi Philippe and Gilles,
> 
> the updated I-pipe patch for ARM which was checked-in yesterday is not 
> complete. Some files are missing e.g. entry-header.S or 
> mach-integrator/core.c. The attached patch should be the correct replacement.
> 

Fixed, thanks. Btw, two 1.5-03 patches went upstream actually, one for
2.6.14, and the other - now fixed - one for 2.6.15. Does the former also
need fixing?

> Moreover, my patch for ksrc/arch/arm/hal.c didn't find its way to Xenomai svn. 
> The patch is required for the I-pipe patch to work.
> 

Gilles has it in his commit queue, it's ok.

> --
> Sebastian
-- 
Philippe.



