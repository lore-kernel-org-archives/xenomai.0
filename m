From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17964.36864.695360.167360@domain.hid>
Date: Mon, 23 Apr 2007 12:52:48 +0200
In-Reply-To: <17964.35957.487976.245056@domain.hid>
References: <46265FC8.1070207@domain.hid> <1176926837.5010.90.camel@domain.hid>
	<46268879.30507@domain.hid> <462C7DF4.9060002@domain.hid>
	<1177324208.30217.98.camel@domain.hid>
	<17964.35957.487976.245056@domain.hid>
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
To: rpm@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
 > Philippe Gerum wrote:
 >  > On Mon, 2007-04-23 at 11:35 +0200, Jan Kiszka wrote:
 >  > > BTW, with latest SVN trunk and scalable sched, the oopses are gone but
 >  > > latency still doesn't start up:
 >  > > 
 >  > > root@domain.hid :/root# cat /proc/xenomai/sched 
 >  > > CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
 >  > >   0  0       -1      0          0          master    R          ROOT
 >  > >   0  930      0      0          0          master    R          display-928
 >  > >   0  931     99      0          0          master    R          sampling-928
 >  > > root@domain.hid :/root# cat /proc/xenomai/stat  
 >  > > CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
 >  > >   0  0      0          0          0     00500080  100.0  ROOT
 >  > >   0  930    0          0          0     00300188    0.0  display-928
 >  > >   0  931    0          0          0     00300188    0.0  sampling-928
 >  > 
 >  > Two threads in ready state with higher priority than the root one: this
 >  > means that a rescheduling opportunity has been missed, or more
 >  > precisely, someone may be lying to xnpod_schedule() wrt to priority
 >  > ordering when the scalable sched is enabled.
 > 
 > ffsmlq uses ffnz, and there are two implementations of ffnz, one in
 > asm/hal.h which is correct on x86_64, the other in nucleus/system.h
 > which uses ffs hence only operates on ints.

Never mind, nucleus/system.h is only included when using Xenomai headers
in user-space. Nevertheless, it should probably use ffsl instead of ffs.

-- 


					    Gilles Chanteperdrix.

