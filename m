Message-ID: <trinity-4550a539-a311-4cb6-853e-f6f5fb983201-1448975385774@3capp-webde-bap47>
From: JK.Behnke@web.de
Date: Tue, 1 Dec 2015 14:09:45 +0100
In-Reply-To: <20151128064325.GC10399@hermes.click-hack.org>
References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>,
 <20151128064325.GC10399@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

   Hello Gilles,

   > in the meanwhile I added rt_timer_tsc as a second alternative to
   measure
   > elapsed time. rt_timer_tsc returns values that are a somewhat greater
   > than expected (around 39 ms instead of expected 20 ms), but still
   > reasonable.
   >
   > > On Thu, Nov 26, 2015 at 11:32:57AM +0100, JK.Behnke@web.de wrote:
   > >> Hello,
   > >>
   > >> in my xenomai 2.6.3 application I sporadically experience very
   long execution times of
   > >> a task that switches back and forth between secondary and primary
   mode.
   > >>
   > >> I added the following code to measure elapsed and cpu time
   > >> //------------- start code snippet ---------------
   > >> struct rusage rsgT1;
   > >> struct rusage rsgT2;
   > >> struct timeval tvT1;
   > >> struct timeval tvT2;
   > >> gettimeofday(&tvT1, NULL);
   > >
   > > Do you observe the same problem with Xenomai 2.6 git head, if you
   > > use clock_gettime(CLOCK_HOST_REALTIME) instead of gettimeofday, at
   > > least for threads running in primary mode ?
   I am now running xenomai 2.6.4 git head.
   The application now uses the posix wrappers as described in the
   documentation "Porting a Linux application to Xenomai dual kernel"
   I replaced the gettimeofday() calls by
   clock_gettime(CLOCK_HOST_REALTIME).
   The getrusage() calls have been removed.

   Both clock_gettime and rt_timer_tsc return reasonable values.
   However, once I observed a loop execution time of 14000 ms instead of
   typical 30 ms.
   This means that the task was blocked for about 14 seconds.
   As I still experience "RT throttling" messages of the Linux kernel,
   I guess that some lengthy operation (file access, memory
   allocation,...)
   of some other task in my application produces the "RT throttling".
   As a side effect the task gets blocked by the Linux scheduler while
   in secondary mode. As mentioned earlier, the task in question switches
   back and forth between secondary and primary mode.

   Is it dangerous to use memory allocation and file access functions
   inside a Linux task running under policy SCHED_FIFO, even though
   they are not really time critical?
   Could some other Linux process block these kind of tasks for such
   a long time (14 sec) or even longer?
   TIA for your comments on this
   Regards
   Jochen
