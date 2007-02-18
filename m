From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17880.57781.152126.164326@domain.hid>
Date: Mon, 19 Feb 2007 00:31:01 +0100
Subject: Re: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
In-Reply-To: <45D8DF58.2090804@domain.hid>
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>
	<45D46704.9050109@domain.hid> <1171560346.24117.77.camel@domain.hid>
	<45D5746C.1090003@domain.hid> <45D8DF58.2090804@domain.hid>
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
 > Hi Philippe,
 > 
 > I just verfied that the mlockall issue persists. But it doesn't appear
 > to be a regression anymore. This little posix demo exposes it now on
 > both 2.6.20-1.7-02 and 2.6.19-1.6-06 against latest trunk:
 > 
 > #include <stdio.h>
 > #include <sys/mman.h>
 > #include <pthread.h>
 > 
 > int main(int argc, char *argv[])
 > {
 > 	struct sched_param param = { .sched_priority = 10 };
 > 
 > //	mlockall(MCL_CURRENT|MCL_FUTURE);
 > 
 > 	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
 > 
 > 	printf("shouldn't be printed...\n");
 > 	pause();
 > }
 > 
 > 
 > In contrast, the same done via the native skin (rt_task_shadow) triggers
 > warning and program termination as expected.
 > 
 > It looks to me like the temporary mlockall during libpthread_rt init is
 > not really reverted (but munlockall is actually called) or not
 > propagated to the mm state that is later checked on xnshadow_map.

The problem is that the root thread is already shadowed in this program
when pthread_setschedparam is called. So, xnshadow_map is not called and
the flag is not checked.

-- 


					    Gilles Chanteperdrix.

