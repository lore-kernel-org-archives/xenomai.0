MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18051.37616.432109.725998@domain.hid>
Date: Thu, 28 Jun 2007 12:52:32 +0200
In-Reply-To: <46838C9C.7030303@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
	<4680DA9B.5020501@domain.hid> <46838C9C.7030303@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Group-based RT caps
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
 > Jan Kiszka wrote:
 > > Fillod Stephane wrote:
 > >> ...
 > >> I think Johan was not asking to disable the mlockall, but to allow some.
 > >> non-root user to be able to do it. He found his solution anyway, which
 > >> is worth an entry in the FAQ.
 > >>
 > >> Since it is going to be a FAQ for those people in embedded business,
 > >> some
 > >> tricks to allow non-root operation of mlockall, SCHED_FIFO, etc., would
 > >> be 
 > >> useful. For example, you may hack the commoncap in linux/security/, 
 > >> or a better solution would be to rely on realtime-lsm[1][2], thanks to 
 > >> the audio folks.
 > >>
 > >> [1] http://sourceforge.net/projects/realtime-lsm/
 > >> [2] http://lwn.net/Articles/110346/
 > >>
 > > 
 > > I think we could and should incorporate such a feature into the nucleus.
 > > 
 > > There is already code in xnshadow_map playing with cap_effective, but
 > > that happens too late. Instead, we should establish a group-based access
 > > control just like rt-lsm (the other knobs of that module are either
 > > irrelevant for Xenomai (mlock=0) or broken security-wise (any=1)) and
 > > raise the required caps for a process that belongs to the specified
 > > group, likely when an Xenomai interface gets attached by that process.
 > > 
 > > Comments? Volunteer coders...?
 > 
 > I couldn't resist, the approach looked too simple and appealing:
 > 
 > http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/rt-caps-group.patch
 > 
 > Actually, it's even more advanced than realtime-lsm in so far as it also
 > checks for secondary group membership. You can use the nucleus module
 > parameter "xenomai_gid" to control the Xenomai group, also during
 > runtime using /sys.
 > 
 > Works nicely for me. I'm able to run testsuite programs under my user
 > account that now additionally belongs to the "xenomai" group. :)
 > 
 > One issue popped up and costed some nerves: linuxthreads-based
 > pthread_create() (non-NPTL glibc, uClibc) with SCHED_FIFO/RR attribute
 > fails already in userland because that library overeagerly checks for
 > root permissions. This is now worked around, but maybe not in the
 > cleanest way as it changes the initial thread scheduling order (more
 > problematic for the POSIX skin than for Native).

no problem with the posix skin: the scheduling order is enforced by the
use of a semaphore.

-- 


					    Gilles Chanteperdrix.

