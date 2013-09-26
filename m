From: "Daniel Merrill" <daniel.merrill@psware.com>
Date: Thu, 26 Sep 2013 08:33:47 -0700 (MST)
Message-ID: <c0f20d88.0000172c.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Language: en-us
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] psos+ tm_wkafter never resumes task when using gdb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

We are attempting to port to xenomai some legacy code written for the
pSOS+ operating system. Up to this point everything in the xenomai pSOS+
skin has been working perfectly, but now we've uncovered a strange
problem. The legacy code has around 50 tasks. A handful of them are only
expected to run at slow periodic rates (one is run every 5 seconds,
another every 60 seconds, etc.) To achieve this, the task sits in an
infinite loop in which is performs the necessary work then puts itself to
sleep for the wait time. The code for putting the task to sleep calls the
pSOS+ API method tm_wkafter(), passing the appropriate number of ticks.

 

When running the executable outside of the debugger everything works fine.
Using the command "watch -n 1 cat /proc/xenomai/sched" we can see the
tasks suspended while their timeout counts down to 0 then the task is
resumed. This repeats as expected and the task in effect is run at the
desired periodic rate.

 

When running in the debugger (gdb), however, things get strange. The slow
running period tasks are never resumed. Watching /proc/xenomai/sched shows
that these slow running periodic tasks are counting down only about 1
second, then the timeout resets to the original timeout value. For
example, the 5 second periodic task shows a timeout of 5000 initially
(we're running at a 1 tick/ms rate) which counts down to around 4000, then
resets back to 5000 and starts counting down again. This repeats
indefinitely, and since the count never reaches 0 the periodic task never
runs again.

 

If we detach the debugger, the timeouts count down to zero again and the
tasks run at their expected rates. Reattach the debugger and the problem
comes back.

 

Any ideas on why this occurs only when running with the debugger?

 

