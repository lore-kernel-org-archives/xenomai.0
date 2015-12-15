From: Steven Seeger <steven.seeger@nasa.gov>
Date: Mon, 14 Dec 2015 20:19:14 -0500
Message-ID: <11512456.mgiilWixD3@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Xenomai] userspace absolute timer value
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Since my last post I seem to have solved the issues with my ppc44x board hard 
locking up. I've relayed this info to Philippe and hopefully he will confirm 
that I'm correct and that I should make a patch. However in the process, I've 
stopped seeing the latency -t1 and latency -t2 work correctly.

One thing I do notice now with latency -t0 is that the timerfd_handler in 
/proc/xenomai/timer/coreclk shows a tremendous number of seconds (1bil+) and 
you can keep printing the output and watching it count down a second at a 
time. This means there may be some kind of discrepancy between the 
CLOCK_MONOTONIC and the timer that's used to program shots.

I did look at the ticks for the coreclock and it appears to be 400 ticks per 
microsecond which is what the cobalt core is reporting via 
xnclock_ns_to_ticks() (I pass it 1000 ns and get 400 as a result)

Can anyone point me in the direction of where to look for this issue?

Thanks,
Steven


