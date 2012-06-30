MIME-Version: 1.0
Date: Sat, 30 Jun 2012 15:09:25 +0430
Message-ID: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] question: XENO_OPT_TIMING_SCHEDLAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Does this kernel config variable,  CONFIG_XENO_OPT_TIMING_SCHEDLAT,
indicate the scheduling latency? If i specify 1 nano second, so all
the real time tasks will be scheduled below 1 nano second?

It seems impossible!

If it is the time when a timer interrupt comes and preempts a real
time task till that real time task is scheduled again ( is this the
definition of the scheduling latency?). Again this definitions seems
not OK because it can not be 1 nano second!! It is too fast to do any
thing.

This configuration variable does not seem to have any range....

