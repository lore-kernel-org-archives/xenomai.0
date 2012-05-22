Message-ID: <4FBBBA25.5010308@mind.be>
Date: Tue, 22 May 2012 18:09:09 +0200
From: Arnout Vandecappelle <arnout@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] CPU occupation without context switches?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

  Hoi,

  After a few minutes of running my application, I see this:

# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   1  828    22         65         0     00300182    9.8  bench_RTnet_scope_thread_loop
   1  839    2          46627538   0     00300186   53.8  bench_RTnet
...

  i.e. the bench_RTnet_scope_thread_loop takes 10% CPU but no
context switches.  How is this possible?  I've looked at the
source code and can't find an explanation: when the exectime
accounting is updated, the csw is incremented as well (in
__xnpod_schedule()).

  I'm asking because I can't find a reason why this thread should
occupy 10% of the CPU, so I'm wondering if there's something wrong
with the accounting instead.

  BTW this is on Xenomai 2.5.6, on an SMP x86 with affinity=0x01.

  Regards,
  Arnout

-- 
Arnout Vandecappelle                               arnout at mind be
Senior Embedded Software Architect                 +32-16-286540
Essensium/Mind                                     http://www.mind.be
G.Geenslaan 9, 3001 Leuven, Belgium                BE 872 984 063 RPR Leuven
LinkedIn profile: http://www.linkedin.com/in/arnoutvandecappelle
GPG fingerprint:  7CB5 E4CC 6C2E EFD4 6E3D A754 F963 ECAB 2450 2F1F


