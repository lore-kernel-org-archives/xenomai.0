From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 3/3] cobalt/intr: pipeline: IRQ management code is
 pipeline-specific
Date: Wed, 16 Dec 2020 17:44:55 +0100
Message-Id: <20201216164455.158920-4-rpm@xenomai.org>
In-Reply-To: <20201216164455.158920-1-rpm@xenomai.org>
References: <20201216164455.158920-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

The way we request and manage interrupts depends on the underlying
pipeline interface.

As a matter of fact, Dovetail already deals with most of the logic
implemented by the xnintr layer, such as edge/level shared IRQs, fully
reusing the regular genirq interface for management. IRQ handlers with
Dovetail have regular signatures as well.

For the time being, let's move the entire xnintr layer to the I-pipe
specific section created earlier. We should be able to design the
abstract interface to IRQ management after this layer for the most
part, which we would connect to Dovetail eventually.

No functional change is introduced.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/Makefile           | 1 -
 kernel/cobalt/ipipe/Makefile     | 2 +-
 kernel/cobalt/{ => ipipe}/intr.c | 0
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename kernel/cobalt/{ => ipipe}/intr.c (100%)

diff --git a/kernel/cobalt/Makefile b/kernel/cobalt/Makefile
index 7dfcae084..de3ae1bfc 100644
--- a/kernel/cobalt/Makefile
+++ b/kernel/cobalt/Makefile
@@ -6,7 +6,6 @@ xenomai-y :=	apc.o		\
 		clock.o		\
 		heap.o		\
 		init.o		\
-		intr.o		\
 		lock.o		\
 		registry.o	\
 		sched-idle.o	\
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
index a395923a1..6021008fb 100644
--- a/kernel/cobalt/ipipe/Makefile
+++ b/kernel/cobalt/ipipe/Makefile
@@ -1,3 +1,3 @@
 obj-y +=	pipeline.o
 
-pipeline-y :=	init.o
+pipeline-y :=	init.o intr.o
diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/ipipe/intr.c
similarity index 100%
rename from kernel/cobalt/intr.c
rename to kernel/cobalt/ipipe/intr.c
-- 
2.26.2


