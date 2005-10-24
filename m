Date: Mon, 24 Oct 2005 15:56:49 -0200
From: Aristeu Sergio Rozanski Filho <aris@domain.hid>
Subject: Re: [Xenomai-core] problem and solution with
	adeos-ipipe-2.6.13-ppc-1.0-03.patch
Message-ID: <20051024175649.GR15211@domain.hid>
References: <1CFEB358338412458B21FAA0D78FE86D4F0E3F@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E3F@rennsmail02.eu.thmulti.com>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

> Hi,
> 
> The adeos-ipipe-2.6.13-ppc-1.0-03.patch file in Xenomai-2.0 dist appears
> to be broken. The unified diff format is wrong on
> include/asm-ppc/ipipe.h,
> which breaks include/asm-ppc/mmu_context.h. I've found the problem while
> 
> applying the patch on a Linux 2.6.13 kernel.
> Line 1664 (no pun :), instead of @@ -0,1 +1,178 @@, the following solves
> the problem here: @@ -0,0 +1,177 @@
> 
> Does somebody else encountered the problem?
I did.
maybe it's a good reason for 2.01?

-- 
Aristeu


