From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Problem with cyclictest
Message-ID: <a7ca11a1-2210-8098-fb7d-07a55f4b0fcf@samsung.com>
Date: Wed, 30 Oct 2019 10:32:00 +0900
MIME-Version: 1.0
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
References: <CGME20191030012837epcas1p46e9ef2156d4d609aa4b913d13374a4f6@epcas1p4.samsung.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I have a problem from cyclictest. The cyclictest is killed with below messages
and i cannot see result of cyclictest when it is terminated, after the commit
5750102b4725 ("demo/cyclictest: turn on FIFO mode by default, detecting
spurious relaxes") is applied.

invoked syscall, aborting.
(enabling CONFIG_XENO_OPT_DEBUG_TRACE_RELAX may help)
CPU time limit exceeded (core dumped)

When the cyclictest is terminated by ctrl-c or -D option, below codes in
timerthread() are executed,

        /* switch to normal */
        schedp.sched_priority = 0;
        sched_setscheduler(0, SCHED_OTHER, &schedp);

and next, cyclictest is killed by sigdebug().

Because the sched_setscheduler() is linux system call, the signal reason is
printed "invoked syscall" in sigdebug(). I think this is normal case, so i
wonder why this is spurious relaxes and cyclictest should be killed abnormally.

I tested it on x64 target using the kernel 4.14.111 that ipipe is patched with
xenomai stable/v3.0.x latest branch.

Thanks.

