MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18222.15424.494628.332671@domain.hid>
Date: Sun, 4 Nov 2007 22:40:16 +0100
In-Reply-To: <472E3758.3060304@domain.hid>
References: <E1Ioj7Q-0004EI-JX@subversion.gna.org>
	<472E3758.3060304@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Xenomai-commits] r3147 - __xn_access_ok changes
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > [Let's discuss this without bothering users :)]
 > 
 > Philippe Gerum wrote:
 > > Author: rpm
 > > Date: Sun Nov  4 18:18:39 2007
 > > New Revision: 3147
 > > 
 > > URL: http://svn.gna.org/viewcvs/xenomai?rev=3147&view=rev
 > > Log:
 > > Make __xn_access_ok() return false for addresses lower than the natural page size.
 > > 
 > > Modified:
 > >     trunk/ChangeLog
 > >     trunk/include/asm-x86/syscall_32.h
 > >     trunk/include/asm-x86/syscall_64.h
 > 
 > Could it be that you meant "PAGE_SIZE" instead of "PAGE_OFFSET"? Because
 > the current version is "slightly" broken, tagging any address in user
 > land as invalid.
 > 
 > And if this test was meant to catch NULL page accesses early, is the
 > intention to cope with all those current i-pipe patches that do not yet
 > include the discussed domain switch on non-root faults? If yes, this
 > test would be a workaround for legacy code and should not become default
 > (pure overhead for later versions).

We can reduce the overhead of the two tests by testing 
(unsigned long) (addr - PAGE_SIZE) < (PAGE_OFFSET - PAGE_SIZE)

 > 
 > Last question: We need this for the other archs as well, don't we?
 > 
 > Jan
 > 
 > _______________________________________________
 > Xenomai-core mailing list
 > Xenomai-core@domain.hid
 > https://mail.gna.org/listinfo/xenomai-core


-- 


					    Gilles Chanteperdrix.

