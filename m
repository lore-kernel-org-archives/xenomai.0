Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072669;
	b=hHhXj0mV+IBtv6K1rhDF0sBFEVbPFjJYD0jQf30vCS24HU15Z7Xyy8pXfqkVRnN2wpIN
	 RlJj56jYPjxiRPv3eqX9Kq49oi41G0bzX4Q38EwtYzk4ByAs63r5SG8oLbKLRpsDDPG31
	 256Z1d0fILmz2a74qpXGj9dDrCyQfOyKEuJl8T+GVm4mE972EM1EKWrzwi7u6+ukm5gXN
	 iKLjSFlFbElFlI7UUnOjYViZ+wzSreCA6D19ztd7oLfHndkH4ppJ5flS6Dmjjrm4iCyFn
	 KUW9FqT//EhAMOSHMi9KZEXKvKDwNuB8fzYedhNQq1NNMU1yXFTYvv4A0O2qc2biUkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ks1C6uQA71xoi7fGf0JAMvW7r/mEhSB5XkEzG0MvdLE=;
	b=sLmeGwheJUOtid/DaGyLrFNuKNULAXNpdDkUCEPr9e4Q/aDFnJUOvNnq30jYMx3YxYeb
	 1DKf8JxyhxYhw0xgvetGz9DI/StUtEa8KBjKLoYash4yaTbh9MhmJIbbCFQ6UoQ6vNTJ/
	 z1wxa3Yp2DSF1yRIPi8M4XKzNJVS+V8paq7HtJ82Zxh+SEA7MNgW7nUuWU7IBrc+AUrsU
	 m2u+3tpB5KbJzOVh6mWr3oocsL7HYQP/fkCiiujjISH7JReg76/7RxTBgsKffuVZcKLrb
	 Qy9kfsIx2ozt+IaAiWwAi8ImIPrh3ks0UCJTuMfp0IFzdgwbQpsOuupa837AZdoNATQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=nkKultmJ;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFB3606A331
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 07:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EFB3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=nkKultmJ
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso1965648a12.2
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 23:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795072667; x=1795677467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ks1C6uQA71xoi7fGf0JAMvW7r/mEhSB5XkEzG0MvdLE=;
        b=nkKultmJHkzyOXeYWHurNSfFczj0gJ83ZUtOIPMGZYZn0Q6wWCmGZ28H8tc29PqTZS
         lizaWebVMhBO0UxBSmgiHVJtQmbWHO8aC3aeNTQYgpbj/vLOV86h1NCdDcSfS8klQLsw
         drIcZzR9w0L9OBSjAAcoY1VuIBW0EuD8mFng1dGKzbfpcFOfNwdfPhY8bMPkSPfgf9tK
         JM7hDvihdUeM9RClnZDYWrMDWSiz8fP+ORZb5qMDrFcbyjH3NG4HVAQ0GJMiXWM1anC6
         EaGglhLNmNz3mvHX5tI3OTfBw1pwUboEYdV4NKBeMGv2CUeznlaJsCRhBLpdZa/dq2R9
         qyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072667; x=1795677467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ks1C6uQA71xoi7fGf0JAMvW7r/mEhSB5XkEzG0MvdLE=;
        b=J9IDgDFYtTXViaNBjE8uRDdUqdwfdlV9PV8rHc9BfY++zsHYml26vGfFa6kNUYplaw
         WCOYuQpiDX7U8clmd8O0xv/J298N11ItvgOjHOwuC9YoiB8bysL++jobNYlJn5uauVY6
         yfnuVW9IvpzJio9Fr3FFM5sl2jAhxjqcTHDi+oir/rPf8v6vabMCNBLPJkATZYAPqwaw
         WJ0RckWBKSGIIlNDFElyhLUej844agXegHbP1O8hCHxD1D5EySt+NU8SIGenHQ4gDaZs
         nE2AWTaFAs8PfP8z/3qJYot2GL8qw+CUvRt46HdRRCwzaL13wvznun2c5/TTOh4a/AU6
         PxuA==
X-Gm-Message-State: APuU4Z/du3hmNrq50g11zLZqckhUlpPsAnufXIdRmMPwvn1Q4LZJ7Z51
	meCIHO5vQTqYFfvxO/+AD3FHaoixe90uZb8uBEdvsc6hWmGwOiMQorS2Utl4QQ==
X-Gm-Gg: AYBFou0SbtKdbbxKV4sl/Q3aqu3Wt5RGCu3DlMXsaqUWFgdgptk3Qs5M8f+EUf4Qtl8
	NROVukB5iGfZV7M7Ga6c2yw/sttMMU7UAJ+2PU3XljgIEPdCEHRcdB0z5V3eKbpI5LFIgJI2G6l
	1Un/zvVZ6VfnakOVfAzQLeXBgA3ItX4Lv1J4lguIbx5iqZaphYhi9RuifmD2ByvIVVvM/3DSDHG
	mUELPEqeyrtxBpETopeKk0hr23N1R9K82DtLGJDWh0+NbTrmqcoA3o+yn/nKGjNQwYDM8U//7sE
	su1MFIed/m8QJPlmy1nvAV8bPNtlNCfQZjZ856wNyf+1kLrOhdel/aAHc7ajUt4KganMtY9aJTX
	CbBdrXlWHgIjFMezPpc+GUcCZ1I8WmXtugjDzPvWsHajRbrRMCVaZI6skI9MGDSL0FEvJWroQ73
	z7skHEDvBHak96MvSGDqguKoH57+iwfVktP9nEE12OEs3l+UcB/1PzV8rIUdFcfnzFBXY++Oznc
	JTDCbFyDDV6w+LKA/IphhXllCqcHWpMnd1yfcxxC9CgQG386b8VSvOp5Bfen+b4RiLSEBby0P3G
	3lajRy+RM5td+tc8+bFMCoHbEqkH+7laJKimuyBrmSUNQiQ/3QzO0CFrQE+IyCuc1bUO1ux1v66
	YXT6hkhaN
X-Received: by 2002:a05:6402:274d:b0:6b6:f7cf:8088 with SMTP id 4fb4d7f45d1cf-6b887ec5b0amr4118005a12.32.1795072667431;
        Wed, 18 Nov 2026 23:17:47 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889a3315dsm2061733a12.10.2026.11.18.23.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:17:46 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v3 1/5] lib: Restore includes needed by the Mercury core
Date: Thu, 19 Nov 2026 08:17:41 +0100
Message-Id: <20261119071745.2409665-2-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071745.2409665-1-yegorslists@googlemail.com>
References: <20261119071745.2409665-1-yegorslists@googlemail.com>
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

Commits 41de7cc7196f ("lib/boilerplate: Cleanup includes") and
7b7ddf4a3658 ("lib/copperplate: Cleanup includes") dropped headers
that are still needed by the Mercury-only code paths. With the Cobalt
core, that code is not built, but building the Mercury core fails:

  setup.c: In function '__xenomai_init':
  setup.c:606:23: error: implicit declaration of function 'mlockall' [-Wimplicit-function-declaration]
  setup.c:606:32: error: 'MCL_CURRENT' undeclared (first use in this function)
  setup.c:606:46: error: 'MCL_FUTURE' undeclared (first use in this function)

  internal.c:108:24: error: '__NR_tkill' undeclared (first use in this function)

Include <sys/mman.h> and <sys/syscall.h> again, only for the Mercury
core, after xeno_config.h has been pulled in.

Fixes: 41de7cc7196f ("lib/boilerplate: Cleanup includes")
Fixes: 7b7ddf4a3658 ("lib/copperplate: Cleanup includes")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 lib/boilerplate/setup.c    | 3 +++
 lib/copperplate/internal.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 7bb24f6f4..e4ebfb54f 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -30,6 +30,9 @@
 #include <assert.h>
 
 #include <xeno_config.h>
+#ifdef CONFIG_XENO_MERCURY
+#include <sys/mman.h>
+#endif
 #include <boilerplate/lock.h>
 #include <boilerplate/ancillaries.h>
 #include <xenomai/init.h>
diff --git a/lib/copperplate/internal.c b/lib/copperplate/internal.c
index ed3f2e4fa..103af3a3c 100644
--- a/lib/copperplate/internal.c
+++ b/lib/copperplate/internal.c
@@ -31,6 +31,10 @@
 #include <copperplate/threadobj.h>
 #include "internal.h"
 
+#ifdef CONFIG_XENO_MERCURY
+#include <sys/syscall.h>
+#endif
+
 static int thread_spawn_prologue(struct corethread_attributes *cta);
 
 static int thread_spawn_epilogue(struct corethread_attributes *cta);
-- 
2.34.1

