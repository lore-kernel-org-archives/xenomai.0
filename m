Received: from out198-36.us.a.mail.aliyun.com (out198-36.us.a.mail.aliyun.com [47.90.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD21DB951
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117408; cv=none; b=FGBOhjYJyQLMkRxLE0AYa1aSOUit3mzaxMpVYkRU/O7ux1+srgieZPuN0MyJbOUFXtlUJhpFvwrA7CdGCMpodrIUsi/22nIq2bkj0/3mQAmaCsczOq34yJPcuQ1wHQOqoRWH5y2LF1kIVTiupPMGC6GIFRJUtyT6yN4+rhOM4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117408; c=relaxed/simple;
	bh=P8UjRFbGmQo7o54lxFiwiaY5Kz7v/f40t/UdPoo6iag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z4/DSiIIthDAMKKA2tj25yieOkDgQunw8GkubUDmTLm/s53kacc2/2Q7fZXKvTSKVvpnTdH8kuHavEThPYqB1w+sLlVCZFPjZxj9E0kwd4aEsLU0I2RLiAKAYDe35WXPe1oEfpq94UfZC4s52J/0HlioYLhrqutOY542FuisLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from morty-pc..(mailfrom:liyinjie@sinsegye.com.cn fp:SMTPD_---.ZuwfjsP_1730117373 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 20:09:41 +0800
From: liyinjie <liyinjie@sinsegye.com.cn>
To: xenomai@lists.linux.dev,
	jan.kiszka@siemens.com
Cc: songjianwei@sinsegye.com.cn,
	liyinjie <liyinjie@sinsegye.com.cn>
Subject: [PATCH] kernel/cobalt: replace unsafe strcpy with memcpy in hash_symbol()
Date: Mon, 28 Oct 2024 19:59:04 +0800
Message-Id: <20241028115903.1727776-1-liyinjie@sinsegye.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

While building the Linux kernel with Xenomai support, I encountered a
compilation error related to a potential buffer overflow in the
hash_symbol() function within kernel/xenomai/debug.c. The error is
triggered by the compiler’s buffer overflow protection mechanisms
(FORTIFY_SOURCE), which detect an unsafe use of strcpy().

Observed Behavior:

The build fails with the following error message:

In function 'strcpy',
    inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
include/linux/fortify-string.h:812:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
  812 |                 __write_overflow();
      |                 ^~~~~~~~~~~~~~~~~~

Context:

	- Kernel Version: 6.6.41
	- Xenomai Version: 3.3-rc.2
	- Build System: Yocto Project with custom layers at branch scarthgap
	- Compiler: GCC version [GCC 14.2.0]
	- Host System: [Ubuntu 22.04 LTS]

The issue arises during the compilation of the Xenomai integration with the Linux kernel. The FORTIFY_SOURCE feature in recent GCC versions enhances buffer overflow detection, and it flags the use of strcpy() in the kernel code as potentially unsafe.

Analysis:

In the hash_symbol() function, strcpy() is used to copy a string into a buffer without bounds checking, which can lead to buffer overflows if the source string is larger than the destination buffer.

The specific code causing the issue is:

p = xnheap_alloc(&memory_pool, sizeof(*p) + len + 1);
if (p == NULL) {
    str = NULL;
    goto out;
}

strcpy(p->symbol, symbol);

Here, p->symbol may not have a clearly defined size known to the compiler, leading to the buffer overflow warning.

I also tested replacing strcpy() with strscpy(p->symbol, symbol, len + 1), but the error persisted.

I am submitting this patch for inclusion in the mainline code. Please let me know if any further information is required or if there are any suggestions for improvement.

Thank you for your time and consideration.


---
 kernel/cobalt/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index cde0c17ab..e901572cd 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -91,7 +91,8 @@ static const char *hash_symbol(const char *symbol)
 		goto out;
 	}
 
-	strcpy(p->symbol, symbol);
+	memcpy(p->symbol, symbol, len);
+	p->symbol[len] = '\0';
 	p->next = *h;
 	*h = p;
 done:
-- 
2.34.1

