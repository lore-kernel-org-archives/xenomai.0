From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:41 +0200
Message-Id: <20180925103809.4932-5-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 04/32] x86: paravirt: disable if CONFIG_IPIPE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Some changes introduced by the basic interrupt pipeline code for x86
break the paravirtualization code. Disable the latter.
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f92d4bad04e5..400864c3c932 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -743,6 +743,7 @@ if HYPERVISOR_GUEST
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	depends on !IPIPE
 	---help---
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
-- 
2.14.4


