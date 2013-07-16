MIME-Version: 1.0
Date: Tue, 16 Jul 2013 15:06:03 +0200
Message-ID: <CAMDpcBFBhM6yevqd002zqkmmYM1ER-roFLmjZNfOOu1=DETjmQ@mail.gmail.com>
From: kunming yang <yangkunming99@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] CLOCK_HOST_REALTIME
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I failed to read host time by using do_clock_host_realtime, so I tried
clock_gettime(CLOCK_HOST_REALTIME) by executing "clocktest -C 2", but I got:

== Tested clock: 2 (<unknown>)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.0            0.000          0            0.0
clock_gettime failed for clock id 2

Anyone knows what's the problem?

Thanks for help!

regards,

Chris
