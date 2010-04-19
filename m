From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:56 +0200
Message-Id: <9a6f509939b9e1769149d232936e8c927376e436.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 16/25] irqbench: Auto-detect bases of port
	address and IRQ values
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/testsuite/irqbench/irqbench.c |    2 +-
 src/testsuite/irqbench/irqloop.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/testsuite/irqbench/irqbench.c b/src/testsuite/irqbench/irqbench.c
index 844f187..ca7a313 100644
--- a/src/testsuite/irqbench/irqbench.c
+++ b/src/testsuite/irqbench/irqbench.c
@@ -211,7 +211,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'a':
-			port_ioaddr = strtol(optarg, NULL, (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
+			port_ioaddr = strtol(optarg, NULL, 0);
 			ioaddr_set = 1;
 			break;
 
diff --git a/src/testsuite/irqbench/irqloop.c b/src/testsuite/irqbench/irqloop.c
index 3b4de4f..d4623b4 100644
--- a/src/testsuite/irqbench/irqloop.c
+++ b/src/testsuite/irqbench/irqloop.c
@@ -101,12 +101,12 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'a':
-			config.port_ioaddr = strtol(optarg, NULL, (strncmp(optarg, "0x", 2) == 0) ? 16 : 10);
+			config.port_ioaddr = strtol(optarg, NULL, 0);
 			ioaddr_set = 1;
 			break;
 
 		case 'i':
-			config.port_irq = atoi(optarg);
+			config.port_irq = strtol(optarg, NULL, 0);
 			irq_set = 1;
 			break;
 
-- 
1.6.0.2


