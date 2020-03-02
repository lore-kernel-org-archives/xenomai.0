From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] docs: Remove outdated note on biarch on x86
Date: Mon,  2 Mar 2020 21:36:59 +0100
Message-Id: <20200302203659.9359-1-richard@nod.at>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: lsorense@csclub.uwaterloo.ca, Richard Weinberger <richard@nod.at>

Since fab9bf585638 ("cobalt: x86: Use ipipe_root_nr_syscalls") it is
possible to run x86_32 Xenomai userspace on x86_64 kernels.

Reported-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 doc/asciidoc/README.INSTALL.adoc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index cbd2adcd54ed..c83fda8ada70 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -186,9 +186,7 @@ Building a _Cobalt/x86_ kernel (32/64bit)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Building _Xenomai/cobalt_ for x86 is almost the same for 32bit and 64bit
-platforms. You should note, however, that it is not possible to run
-Xenomai libraries compiled for x86_32 on a kernel compiled for x86_64,
-and conversely.
+platforms.
 
 Assuming that you want to build natively for a x86_64 system (x86_32
 cross-build options from x86_64 appear between brackets), you would
-- 
2.16.4


