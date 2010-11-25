Message-ID: <4CEE9119.80108@domain.hid>
Date: Thu, 25 Nov 2010 17:38:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CEE8FF0.6000704@domain.hid>
In-Reply-To: <4CEE8FF0.6000704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 3/3] ipipe: Provide __ipipe_spin_trylock_irq
	for !CONFIG_IPIPE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/linux/ipipe_lock.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/ipipe_lock.h b/include/linux/ipipe_lock.h
index 75bf0e8..5382208 100644
--- a/include/linux/ipipe_lock.h
+++ b/include/linux/ipipe_lock.h
@@ -224,6 +224,7 @@ void __ipipe_spin_unlock_debug(unsigned long flags);
 #define __ipipe_spin_lock_irq(lock)		do { } while (0)
 #define __ipipe_spin_unlock_irq(lock)		do { } while (0)
 #define __ipipe_spin_lock_irqsave(lock)		0
+#define __ipipe_spin_trylock_irq(lock)		1
 #define __ipipe_spin_trylock_irqsave(lock, x)	({ (void)(x); 1; })
 #define __ipipe_spin_unlock_irqrestore(lock, x)	do { (void)(x); } while (0)
 #define __ipipe_spin_unlock_irqbegin(lock)	do { } while (0)
-- 
1.7.1

