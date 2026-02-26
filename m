Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A582D7DD1
	for <xenomai@lists.linux.dev>; Thu, 26 Feb 2026 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116647; cv=none; b=DEmMwnVxv6XMJjJJwPfOTRXtgub8cYOSDn5yjWHgDkp8k0SMYXrPodVpL3zbc4mF4ympdnEty3HqsFqJSsObvXl3aAwzJib/G6C+VaKd1Xtx1HSNKqHVVZ+i+UrgjYkCVq212qfKyvZ8knjMt/Yr6QTNd9jDNVhYleUIHsl58I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116647; c=relaxed/simple;
	bh=BuTFpeRPKlzE90G+5TO0D2iEJsWkpfTWh/n0Z3Xgt7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q94A1TXBT/5AZHcHnQP5Bhg4XkOuqMxj7simzds8lByd2C/G/Q2d60Wv40+XqUNsGecF+I9j6FGNWRxvDi6uy3pwnT3pKz8eV0U5NQarhvXNzxum/XNtZRdnytC/xxPfKsqxS+l5bOmX+kRt9j9aGtwI533JnkUCgfYNfFFcbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Wxddz6hF; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Wxddz6hF"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026022614371417fb81e371000207bc
        for <xenomai@lists.linux.dev>;
        Thu, 26 Feb 2026 15:37:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B1J9FdUSMShRKsRbTXfz2Rw0fUbBGdulEVYNe4tdGRs=;
 b=Wxddz6hFGPAgIEL6SxvtYCsDBpmogI0TfrbdzWzpkX4JzbUiNNXp3rdZA/Pjv3/5x25AKy
 V888D8L6MGPuVL3HtMDG4qPPLjCjUUipxRFnWTn+IKWUVVJShlJ6VXynxGEBh2rs0uIQ2YeO
 MC1LqI7LWK3UjDbSe56Y2NOefmrmbNP/Jx14KhWvKrLkRbPXXByV6xHcJSDucRV2OM1Okbot
 3Ie+6neEFaDSe7oQ3VWEt/yjtyZlp8Oc8CAG39y9gwojfByUo8eO0M5A0CR78awRSwfmLbUm
 dj2NTMWcEKWTqLDFJndE/V029yzUODFgRLaulKRz+7wPC443bK/PXcnA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 26 Feb 2026 15:37:14 +0100
Subject: [PATCH v3 3/5] cobalt/kernel: Lower impact of wrapping for older
 kernels
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-wip-flo-prepare-for-6-19-v3-3-e730e85eda81@siemens.com>
References: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
In-Reply-To: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a preparation commit for the following wrapping of
mm_get_unmapped_area() for kernels < 6.19.

The arch specific asm/xenomai/machine.h will include further Linux
headers, at least on arm. If the wrappers.h is included upfront
the wrapping for older kernels is applied to Linux headers as well.

Move the include of wrappers.h down until the Linux parts are done.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/syscall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 943491be3f265e237ce477b9fc9af0690f99d4e6..5401f38bee272a96bc9ea29f81606c47fb0e1ee1 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -22,9 +22,10 @@
 #include <linux/types.h>
 #include <linux/version.h>
 #include <linux/uaccess.h>
+
 #include <asm/xenomai/features.h>
-#include <asm/xenomai/wrappers.h>
 #include <asm/xenomai/machine.h>
+#include <asm/xenomai/wrappers.h>
 #include <cobalt/uapi/asm-generic/syscall.h>
 #include <cobalt/uapi/kernel/types.h>
 

-- 
2.53.0

