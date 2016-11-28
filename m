Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <baed9085e48cc80764b7.1480335483@devws148.be.alcatel-lucent.com>
Date: Mon, 28 Nov 2016 13:18:03 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] Add support for mips/mips64 in configure.ac
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch adds support for mips/mips64 in configure.ac.
It has been tested on Mercury only.

diff --git a/configure.ac b/configure.ac
--- a/configure.ac
+++ b/configure.ac
@@ -135,6 +135,10 @@ case "$build_for" in
 	XENO_TARGET_ARCH=blackfin
 	CONFIG_XENO_DEFAULT_PERIOD=100000
 	;;
+ mips-*|mips64-*)
+	XENO_TARGET_ARCH=mips
+	CONFIG_XENO_DEFAULT_PERIOD=100000
+	;;
  arm*-*)
 	XENO_TARGET_ARCH=arm
 	CONFIG_XENO_DEFAULT_PERIOD=1000000

