From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 14 Sep 2018 18:14:38 +0200
Message-Id: <20180914161442.2406-2-henning.schild@siemens.com>
In-Reply-To: <20180914161442.2406-1-henning.schild@siemens.com>
References: <20180914161442.2406-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] [PATCH] gitignore: add build output for in-tree builds
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This adds all build output to .gitignore. Not everybody works out of
tree, or knows that this option exists. So let us add all build output
to .gitignore. While this names all our binaries and has the risk of
getting out of sync, it at least makes "git status" human readable again.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 .gitignore | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/.gitignore b/.gitignore
index b1d682032..a054a65af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,3 +15,70 @@ config/missing
 configure
 aclocal.m4
 autom4te.cache
+Makefile
+.deps
+config.log
+config.status
+include/stamp-h1
+include/xeno_config.h
+libtool
+scripts/xeno
+scripts/xeno-config
+utils/net/rtnet
+utils/net/rtnet.conf
+*.a
+*.o
+*.la
+*.lo
+.libs
+.dirstamp
+demo/alchemy/altency
+demo/alchemy/cobalt/cross-link
+demo/posix/cobalt/bufp-label
+demo/posix/cobalt/bufp-readwrite
+demo/posix/cobalt/can_rtt
+demo/posix/cobalt/eth_p_all
+demo/posix/cobalt/gpiopwm
+demo/posix/cobalt/iddp-label
+demo/posix/cobalt/iddp-sendrecv
+demo/posix/cobalt/xddp-echo
+demo/posix/cobalt/xddp-label
+demo/posix/cobalt/xddp-stream
+demo/posix/cyclictest/cyclictest
+lib/boilerplate/config-dump.h
+lib/boilerplate/git-stamp.h
+lib/boilerplate/version
+testsuite/clocktest/clocktest
+testsuite/gpiotest/gpiotest
+testsuite/latency/latency
+testsuite/smokey/net_common/smokey_net_server
+testsuite/smokey/smokey
+testsuite/spitest/spitest
+testsuite/switchtest/switchtest
+testsuite/xeno-test/xeno-test
+testsuite/xeno-test/xeno-test-run
+utils/analogy/analogy_calibrate
+utils/analogy/analogy_config
+utils/analogy/cmd_bits
+utils/analogy/cmd_read
+utils/analogy/cmd_write
+utils/analogy/insn_bits
+utils/analogy/insn_read
+utils/analogy/insn_write
+utils/analogy/wf_generate
+utils/autotune/autotune
+utils/can/rtcanconfig
+utils/can/rtcanrecv
+utils/can/rtcansend
+utils/corectl/corectl
+utils/hdb/hdb
+utils/net/nomaccfg
+utils/net/rtcfg
+utils/net/rtifconfig
+utils/net/rtiwconfig
+utils/net/rtping
+utils/net/rtroute
+utils/net/tdmacfg
+utils/ps/rtps
+utils/slackspot/slackspot
+testsuite/smokey/dlopen/dlopentest
-- 
2.19.0


