Date: Fri, 23 Dec 2011 16:55:47 -0500
Message-ID: <20111223215547.GP27742@domain.hid>
References: <20111223173309.GM27742@domain.hid>
	<4EF4C5A5.6000105@domain.hid>
	<20111223183246.GN27742@domain.hid>
	<4EF4DFAB.9040406@domain.hid>
	<20111223202530.GO27742@domain.hid>
	<4EF4F72D.5010007@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EF4F72D.5010007@domain.hid>
From: lsorense@domain.hid (Lennart Sorensen)
Subject: Re: [Xenomai-core] CONFIG_XENO_HW_UNLOCKED_SWITCH=y causes random
 process corruption in xenomai 2.6.0 on powerpc.
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

On Fri, Dec 23, 2011 at 10:48:29PM +0100, Philippe Gerum wrote:
> Is it reproducible with the basic latency or cyclic tests if waiting
> for long enough? Running ltp in parallel would trigger a decent
> load, but sometimes two shell loops forking commands in the
> background are enough to trigger a variety of issues when something
> fragile exists in the mmu layer as modified by the I-Pipe.

Well we can try after I come back from vacation in a couple of weeks.

-- 
Len Sorensen

