MIME-Version: 1.0
Date: Wed, 1 Aug 2012 10:58:42 +0430
Message-ID: <CAKKWdtcVT9s9FfTf5fHd=z=Cg9iBS4NCbd+aqD-53iXbHUjqOA@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] question: scheduling2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

If I have only one logical CPU and there is a real time Xenomai task
(SCHED_RR or SCHED_FIFO) and the task is infinite , never leaves the
Xenomai domain and never blocks. Does it mean that Linux, its
scheduler and the Linux interrupt handling routines will never be
executed?

