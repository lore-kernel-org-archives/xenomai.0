Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2F1E487
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065103; cv=none; b=QDm5dbKaWI6OZ+XgHXKQZ7q32eqS9lUlbIg4xVicKHvLQeeYDI2nQwn7H54Zy3NcRrXvYMnoYrJiTxGdMwx2pTfaHHbi/OQj8UAgB8w6fCEg8xnXYvsIehOPKV2A/6Yfbr3UmAmVpj438RjcAlPE75hG8iaJXBElAnvsxOnKMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065103; c=relaxed/simple;
	bh=BEWSgPXjXDkWIWnHfxK+NXe8IIxyhg2KTtDn1uGqXoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uIeIT2U8TxBRAYS7HSxjnZLsi8rRF/8ExcgqXDWnjL+pl9RCC+whacHVqVct3Qh0kUv8qfelFnYQU9OYMYAeP683rMMoemrj+oMaTKLUaZLUMOCVZMf7V32DzTekZNGg8nhYBn6grxpGfiDEeuieAP0zJMzMh27h41A7SzHoSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fuY5pDy2; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fuY5pDy2"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250905093809e8dc8fa42200020793
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 11:38:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=slaa9NwXNc+jljlNvUWpctiDkkvJIz271uuc/OetM4Q=;
 b=fuY5pDy2RoaPze2THIKmzYdOsson0TOiU6P0Cweaif440qpFbH6/ht0/NMU42k5y5cb7ff
 PbJ57H1ub/GDohc/JHVkJNiJc6L0Hu26sucZOf03i+Vt+7rjnEwOtdtXYMWCHyHFDvrREFSL
 8GUvG5hD9UPj27qoymNW3qaJy+DFfDhVfJ0vCgcD2U7I/tlZjhyi/0CkYlnEWMa/HTnOc7D0
 cuH5CKE7DuP/+XIN5F+zteEVE5uXNuXEYkf0RBTEwOSq4MmI1OFh74dCDaukrY1YxRCMx6sA
 3fE+CPDHT0yMx2B4Sh+vbP6HUvVO4xGPX2PT0IyEa5f0DKe88FiObHYQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 Sep 2025 11:38:07 +0200
Subject: [PATCH Dovetail 6.10 - 6.16] x86: irq_pipeline: Fix build failure
 for !IRQ_PIPELINE but X86_FRED
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250905-wip-flo-fix-build-failure-no-pipline-but-fred-v1-1-492c5e4edd52@siemens.com>
X-B4-Tracking: v=1; b=H4sIAH6vumgC/x2OwQrDIBBEf0X23C0mxUB67l+UHIxZmwVR0ZgWQ
 v69256GmQePOaBSYapwVwcU2rlyilK6iwK32vgi5EU69Lo3etQG35zRh4SePzg3Dgt6y6EVwpg
 wcw4cScCGvtCCt9F0bhzcbKwBcc62Ci02ulWssYUgYy4ktv+JJzzSTpsY1XDttMJfDDCd5xcN5
 Q2cqgAAAA==
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Fabian Scheler <fabian.scheler@siemens.com>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The POSTED_MSI_NOTIFICATION_VECTOR is present since 6.10, so
FIRST_SYSTEM_APIC_VECTOR was off by one resulting in the following build
warning:

./arch/x86/include/asm/irq_vectors.h:104:41: error: array index in initializer exceeds array bounds
  104 | #define POSTED_MSI_NOTIFICATION_VECTOR  0xeb
      |                                         ^~~~
arch/x86/entry/entry_fred.c:98:37: note: in definition of macro ‘SYSVEC’
   98 | #define SYSVEC(_vector, _function) [_vector - FIRST_SYSTEM_VECTOR] = fred_sysvec_##_function
      |                                     ^~~~~~~
arch/x86/entry/entry_fred.c:121:16: note: in expansion of macro ‘POSTED_MSI_NOTIFICATION_VECTOR’
  121 |         SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,  posted_msi_notification),
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/irq_vectors.h:104:41: note: (near initialization for ‘sysvec_table’)
  104 | #define POSTED_MSI_NOTIFICATION_VECTOR  0xeb
      |                                         ^~~~
arch/x86/entry/entry_fred.c:98:37: note: in definition of macro ‘SYSVEC’
   98 | #define SYSVEC(_vector, _function) [_vector - FIRST_SYSTEM_VECTOR] = fred_sysvec_##_function
      |                                     ^~~~~~~
arch/x86/entry/entry_fred.c:121:16: note: in expansion of macro ‘POSTED_MSI_NOTIFICATION_VECTOR’
  121 |         SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,  posted_msi_notification),
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Required build configuration:
  - CONFIG_IRQ_PIPELINE = n
  - CONFIG_X86_FRED = y

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Cc: Fabian Scheler <fabian.scheler@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>
---
 arch/x86/include/asm/irq_vectors.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index de7592d870e9..dd755c95f3b4 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -109,7 +109,7 @@
 #define FIRST_SYSTEM_APIC_VECTOR	CALL_FUNCTION_OOB_VECTOR
 #define NR_APIC_VECTORS	        	(NR_VECTORS - FIRST_SYSTEM_VECTOR)
 #else
-#define FIRST_SYSTEM_APIC_VECTOR	LOCAL_TIMER_VECTOR
+#define FIRST_SYSTEM_APIC_VECTOR	POSTED_MSI_NOTIFICATION_VECTOR
 #endif
 
 #define NR_VECTORS			 256

---
base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
change-id: 20250905-wip-flo-fix-build-failure-no-pipline-but-fred-3951c96cb5a5

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

