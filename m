Date: Fri, 4 Mar 2022 12:35:05 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1971847999.108624.1646393705887.JavaMail.zimbra@nod.at>
Subject: Questiion on commit: demo/cyclictest: fix time delta calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello,

I'm investigating into a cyclictest issue where it reports negative values just like this commit states:
https://source.denx.de/Xenomai/xenomai/-/commit/3069a7bbc48559f4d2a6184d6159b771f193a4e9

Since I'm on Xenomai 3.1.2 the said commit is already included.
But I have a hard time to understand what problem the commit actually fixes.
Why is the old calculation wrong?

PREEMPT_RT's rt-test does it the same way:
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/include/rt-utils.h#n60

Except that it casts tv_secs/tv_nsecs to int first, which shouldn't make a difference.

Thanks,
//richard

