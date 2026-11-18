Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010801;
	b=nu0E5txawNqs9YSNyRdAjTXzFoeEVCRy+kPJonjW5gGVQIomV9J1+IkDrqOevf31OPxp
	 8wDGwIXwEuou1HJkuvPZrbM/ZPS9Hhnt3ISDM/bNvlsUWWX9No8RORCs58ldWZRF6SBWJ
	 0q65NHPKCqwaQAsUv/h3oEnjiFXKQ4evFmSPcA7/HBpNfQCNdG4monwdZgwzqnJTewNzh
	 dmmdXv+OhWOOsvBgoAGqonZ+B3pOCjhPYEbSe0WwohIfjBF9F9H0DAK/FBo9FJT4xwb0n
	 eNEbcGseeGeiZZ2xgEFD+lefAC9ajPf/VKqWhIr6v77kZly1ofet3oDwCNUe2G2Qw1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0nDzGx33z7BLHpijyCRfZcpNSRPZo3e6MzzshecdTRk=;
	b=NRvAxW8gQs3NYExV0GjrsGniwYgHsCkXAlkKXT6EOSAstAugbo4fv64RRzufVWyl+CSc
	 cEJs3YkOcdIrcOgC7uwGDGAC2V+Q4TgZeguLC3qFCMCCWdxo24mThEDW2ZgQL1DbTf7YA
	 dM03TvfV7Sp/8VyYE6mpSark/fTG6/9D+yAsx4GzqIhXDYKIxpfnNC6LNJviW9SCXKvyQ
	 ZwZe8h0KgnOoIueuM0Q/cBvB0lmZ0itlEzqdFxxo/SBCBobgqiqkSKRgbQUkNpbFKAc6v
	 d8Y9OMIggjV4AP2TKGndlLDNkbbwSeEoFScjzc/vCnQjdU7v1VtgTFEAQEexxh8G6/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=UT7LtSox;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0FA606A338
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E0FA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=UT7LtSox
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c505186727fso141755566b.3
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795010800; x=1795615600; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0nDzGx33z7BLHpijyCRfZcpNSRPZo3e6MzzshecdTRk=;
        b=UT7LtSoxagJH1sE6nZUxbWBZ+cjLHFCeP50zHc71QR6xPbgQeRs+JbAdmCwlIAZ5uP
         eNwNsZKGX7ri3VwQUEko9sGJ0RwiB6E7d/DE6iM1fiHbyMb0QAOX2ZNxCRmva1AmL4rl
         CIMr3f5a9wDF46OFVuA3cl/fdmjUVyaa2rFz4tA6+Dsz9DhJHWK+tlInL2gAPEenWGTH
         ly8ZJXvEeyU7vhUK7y5ZDBqgFNC6usseFISwFYppZ6URY3qn2RrO3zHglV5TdwiE8SG0
         RzMBFle5/ejQ9lSYxW+nmxL7Hvp7c6JWonqxa/qqo1ZbI1YMvj9Ycliq7lc+d9Xp4Rsi
         brWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010800; x=1795615600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0nDzGx33z7BLHpijyCRfZcpNSRPZo3e6MzzshecdTRk=;
        b=J7+OTkzXFRGxbbTyWHFYI6n36iMbeIVRbvGkioc3Q+LWc4aUTq4myk8r0lYov68ZZO
         puBJejWjWRbxG7KjWT80XwRt/tg7BI/DlmetIRE7dlyWuaWqIh8mUm0w0hrGAVtFxds+
         +jHG/EkU7fTTf5vo8MO4pphrzghC+h33msAZXhKqc+asQxgPBpzfXF/1EioyPpiN3sex
         ZLhoQkYtsP0RWTZIPnR4ORi0aknTGIzo4OhYWVB7fCEnNE7zRbf7Jj+GVjInvx3iCwo2
         xjwq8fwi7xIpexRmW7MV91/1QT7O1l8lYfx1SXLD4SAkjXPmSUrSGST2xT3ASvuWEapO
         yyGg==
X-Gm-Message-State: APuU4Z87XbnSJEBMbbA/hXfVCUGvbvtqdhOAbhg7912eEmJ8XuxCsAW/
	Ct7imkeCLmpVCvHgv/hfOIAlu3jtzi/+uf8VD0T+AFEt2knRWRaKS/v4inr+Tg==
X-Gm-Gg: AYBFou0l19Xkg7sK3D34PBSppn04dh5w4RBbPYKJdNgZfaXhOKZ4nOHCGjHYs7hxd2T
	iZ6Ed0fzKSYSkD3O32w022VLk4ec8PrOYHEhyIcdmmITXUJLZF2c1kp+FjlcyWmx4sSevwsyiVD
	/0qjk3SFW9NE8nkBtevFl3qp2O+e5H1ph01fN8AMbFEx2hCqvkov4jhxnzG5Hrqo+UeLeCJNAWU
	Afsrg2oP4gtywhz7JxvDFMqKqhybmtZumLQ9tAtNFcC3nqCzdhNqhntOPHlHzfwohTh4CycYbOO
	SxN9JfAm697zLq0HsGYjAoCxAiabKc8gWbNHaTBmZbYz9xOeLqKWkTRdbUxT5CLwfxyNqrCifRI
	t/lTAL8TaC9OCvz1fa17HrdQEu4Sik0gF1dP/Zy6rCstEa/WdNzTEYFHbRcdzwd/QJH5AZduX6b
	z7yia53nZKJD7yWAg9tWpv1lmB+81x2/PKwJGWyXOm6uFw3rFADu44H9TdYzaqZa0Tr3LW+E55/
	CNWqk5tAUik+CT1Tcr+NF3AkZjNNWYjwAxkOUyiU0WW6BigmIku77dL/X+MXq9J/fw5XEPXpQ7L
	VZZiIrk36i8Z8Q9GmAen58P9ytmSMRF/yo/QSm05nNQaJYVBXYGbKna636zfq5T6MOrx+j/q0nQ
	W3P9BN9Hw
X-Received: by 2002:a17:906:99c4:b0:c3e:d0ca:d2fd with SMTP id a640c23a62f3a-c510e15a1c2mr259350266b.12.1795010799754;
        Wed, 18 Nov 2026 06:06:39 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512346c84esm1024966b.56.2026.11.18.06.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:36 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v2 4/4] testsuite/gpiobench: Include stdarg.h
Date: Wed, 18 Nov 2026 15:06:32 +0100
Message-Id: <20261118140632.1080213-5-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118140632.1080213-1-yegorslists@googlemail.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpiobench uses va_list, va_start() and va_end(), but stopped including
<stdarg.h> indirectly when <xenomai/init.h> was dropped. With the
Cobalt core, the header still comes in through other headers, but
building the Mercury core fails:

  gpiobench.c:268:9: error: unknown type name 'va_list'
  gpiobench.c:283:9: error: implicit declaration of function 'va_start' [-Wimplicit-function-declaration]

Include <stdarg.h> directly.

Fixes: 17defbb7bb64 ("testsuite: Cleanup of unused includes")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/gpiobench/gpiobench.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index f2cbb2549..44f04ff4d 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -21,6 +21,7 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.34.1

