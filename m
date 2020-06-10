From: alex_luca@163.com
Subject: [consult]locking/spinlock/:why *nklock* used in many places? hello,
Date: Wed, 10 Jun 2020 22:02:45 +0800
Message-Id: <20200610140245.38252-1-alex_luca@163.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jamienstar@163.com, Carver lio <carver@tom.com>

From: Carver lio <carver@tom.com>

We have some doubts on xenomai master.

We use ipipe-core-4.19.82-cip14-x86_64 + xenomai-3.1 on my machine
with 16 processors; everything is fine until we run the *latency -t0*
testcase on cpu1-cpu15 for our schedule benchmark.

What we found that the results of the testcase became very poor,
worse than testing on one processor. Then we config *IPIPE_TRACE=y*
and *XENO_OPT_DEBUG_LOCKING=y*, and run the same testcases, we found
the delays of the testcase caused by the Global *nklock*.

We are wondering why the same lock *nklock* is used in many places
in the xenomai source code. Is this necessary? Or do you have
optimizations for this situation in the future?

Thanks.
-- 
2.17.1



