From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] dovetail: enabling Valgrind for applications
Date: Tue,  7 Sep 2021 19:55:02 +0200
Message-Id: <20210907175503.289178-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

As discussed a few weeks ago on a community meeting, enabling Valgrind
for dual kernel applications is a desirable feature, despite the
obvious slowdown. In some (desperate) cases, speed and/or latency is
not the issue at hand, rampant memory corruption is.

For this, the way syscalls are issued to the real-time core needs to
be revisited.  The following trivial patch just does that (see details
from the log).

There are two parts to address the issue:

- make Dovetail recognize a new call form which does not cause a stock
  Valgrind engine to choke, passing it to the real-time core.

- make the the real-time core recognize the new call form and deal
  with the request as expected.

This has been done and lightly tested on the EVL/x86 core at the
moment, so far so good. I believe this feature should make it in EVL
master fairly soon now.

Bonus, the older call form is still supported (i.e. @nr |
__OOB_SYSCALL_BIT directly in the syscall register), the prcrl() form
is a mere addition.

NOTE: the single patch which enables the feature in Dovetail should
have no impact whatsoever on the current Cobalt implementation. The
latter would receive all prctl() calls - which are seldomly used
syscalls - before telling Dovetail to propagate them to the in-band
kernel as usual.

The main issue to address in order to enable this feature in Cobalt
would be to shrink the argument list of existing XENOMAI_SYSCALL5()
requests to XENOMAI_SYSCALL4() or lower, since the new call form is
limited to @nr + 4 args. This is only about 13 distinct syscalls to
convert.

If you have suggestions to lift this limitation using a different
request vector which would have the same properties than prctl() wrt
Valgrind and still non-confusing, please chime in.

[1] https://source.denx.de/Xenomai/xenomai4/libevl/-/commits/wip/prctl/


