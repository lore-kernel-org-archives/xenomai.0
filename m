Message-ID: <4721048B.3040703@domain.hid>
Date: Thu, 25 Oct 2007 17:03:07 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Compile-time patch for mm_struct
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I needed the following patch to fix a forward reference (caught by gcc 4.1.1).  I posted this as part of an earlier discussion, but I then realized that it might be overlooked, so I'm reposting it as a new thread:

--- /home/sfalco/ipipe.h	2007-10-25 12:59:12.000000000 -0400
+++ include/linux/ipipe.h	2007-10-25 12:59:23.000000000 -0400
@@ -31,6 +31,8 @@
 #include <linux/ipipe_compat.h>
 #include <asm/ipipe.h>
 
+struct mm_struct;
+
 #ifdef CONFIG_IPIPE
 
 #define IPIPE_VERSION_STRING	IPIPE_ARCH_STRING


