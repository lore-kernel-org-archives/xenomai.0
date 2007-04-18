MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17958.36330.124456.342196@domain.hid>
Date: Wed, 18 Apr 2007 23:30:18 +0200
In-Reply-To: <4626888F.4010300@domain.hid>
References: <46265FC8.1070207@domain.hid> <1176926837.5010.90.camel@domain.hid>
	<17958.32569.506331.124185@domain.hid>
	<4626888F.4010300@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > - the posix registry
 > > 
 > > Is it enough to replace 1 << (fd % BITS_PER_LONG) 
 > > with 1L << (fd % BITS_PER_LONG) ?
 > > 
 > 
 > Yes, of course!

But ffs on x86_64 takes an int as argument, not a long. So, my best
option is to replace BITS_PER_LONG with 32 and work with ints instead of
longs.

-- 


					    Gilles Chanteperdrix.

