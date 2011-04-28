Date: Thu, 28 Apr 2011 18:11:52 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110428161151.GA2921@domain.hid>
References: <BANLkTi=UuSsFMmin_vGQFp3-vn=7JVT8Cg@domain.hid>
	<1303941212.1932.38.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303941212.1932.38.camel@domain.hid>
Subject: Re: [Xenomai-core] [PowerPC]Badness at mmu_context_nohash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Apr 27, 2011 at 11:53:32PM +0200, Philippe Gerum wrote:
> Yes, but that can't be easily summarized here. In short, we have a
> serious problem with the sharing of the MMU context between the Linux
> and Xenomai schedulers in the SMP case on powerpc.

BTW, I have been running xenomai 2.5 on ipipe 2.6.36 on p2020ds and
p2020rdb for several weeks now. Mostly, it seems stable. At least it
runs better than in that report. There are a few rough edges, but I
have not had the time to work on them or report them yet.

In any case, I suggest trying 2.6.36.

HTH,

Richard

(Here is the exact version I have been using...)

commit 0f88f18483390d8c4c9ccf7615120e83193fd3c8
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Tue Mar 8 06:52:33 2011 +0100

    ipipe-2.6.36-powerpc-2.12-03

commit ec97ca753f417eb56973111573d367395b676333
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Tue Mar 8 06:51:10 2011 +0100

    powerpc/ipipe: sanitize IRQ cascading with uic

commit edb402799e8d65639fddcd03c2b7b78615fd4ef3
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Mon Mar 7 17:46:31 2011 +0100

    powerpc/ipipe: fix IRQ cascading with fsl_msi chips

