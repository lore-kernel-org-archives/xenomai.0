Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010796;
	b=N/uJp6OGSZrbBn96yIf0T6DNpqsDlDRRc+Ce3pMlcjNshcPnvoZALinfz1wtjFCFIR03
	 LelueG9G3oEd9T5Bk0D9ub0kwpeBLJU8s8NcvaZE5Jn8TAnEWyFDMzde1F1pxBGfKfDco
	 hhHCWALku49F6nBjwhMEIpdHasXzQvKdu3H2rad7kBezH5ZAQCjTS/DAT93T2l2otC/Y0
	 tppug1lRwoT5NOtn1HdQ5fL6QIEt9ynkXzTOuKaOhJ2uMPhLnAqXFnpWfwQmYd1A1auTv
	 Vd8C2dv9ZxkwoCBXozKiQ2vfSkg8zesBi1ZIxrUYPWRr399fPvqYrooBLAv+TG6JjqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ks1C6uQA71xoi7fGf0JAMvW7r/mEhSB5XkEzG0MvdLE=;
	b=wBk/BSi6rse86RspNf+SZIjC0FGMexuOqXSoDFm61VL38ckdR7wV/Af6VVNSYUti3kCR
	 s4ZlcK0Rh8dXdCuUHCNBGnMxG2q8J4j7vkqB0ABxVEv38CtpnDiG9bsWG3SEJ9EC7O9fg
	 V2+MJxi1o7smY0ZugAQtK52XBMGroDIJ9e2ObdZhvx+iDPSuRQn07QpglsG++0APYBhE6
	 hRYj802QdlsdWq8D8WMb6Xswj9vJPdexcsiQe0ExkBZwE4NWqqc6U0a6tUUEDQX16N7Bo
	 5SyDnWZy5lVkfkA/YqPsCnpJ0t4HU+lNcyPHANsn+opboiDMko4EqHf40icr2NoJU/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=KuQoTlVc;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66460606A325
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66460606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=KuQoTlVc
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so1478791a12.1
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795010795; x=1795615595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ks1C6uQA71xoi7fGf0JAMvW7r/mEhSB5XkEzG0MvdLE=;
        b=KuQoTlVcuS0cNcL79akM69kuR+AFf57kbjtwkI/iTh0cPTLo8MCHhNaFxWOhpNeIzq
         LTidIqNnoS6fLJX4zN4+k7mpDCrmiGFIb84mgovM0tlul59o/rBTjNu14THtkuHY52oh
         4Ux8VdZiTLdv/5DOBa3tAj89T1KdqvQtF2wLG82Pl0BgVGSvsMfIhxJJJtwMS86bc983
         CokPYX6IfoYEaGpAUdTvAnLnepPbvj/Srh1peU6itGL9KwogNBY4F9hznPVqLNM+iekS
         YYJhpZ90qtNE1fisP16XZtnDRCoxesYPidVa0Uy81lDOBjnslQLUHBTe9hX0miMdfDhT
         Ocqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010795; x=1795615595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ks1C6uQA71xoi7fGf0JAMvW7r/mEhSB5XkEzG0MvdLE=;
        b=ZuaHcvv2tBzZxjl5IP0pbND3muKTzdgWg9H282qxcdcY1g+wD/64jUzLOVbLiN1YmK
         gRfzJFwN4y29S+qy1Tj8PkPAOpBFbYoHF7pb2EGXEAHzrRZRTYL1wAOdQe2degVNIHRe
         9X0JrcnStZQEmyrIAk2o14RmgAkuTmJkkReWQMG+aj41CLwAg4Ru4SJJkcsMHRCctwZI
         8B/uu9DAShN846a4ZKq1OVgG0Tj9RPx5Eak5X0vQVS7p57MzJRwbo/s1Xb6qQG8BsnkO
         DQlY+2xChjoOgxlQdGZJWnvn06sYzMMtBbC1UDL9gUXACXCYqNJR84IvGyCoUev8Kj9H
         /52Q==
X-Gm-Message-State: APuU4Z9wY5lEQpYe1oiW3tZIZmKyvQCb5nC5V14XEX9ukgAZKncJmEBZ
	+YS8VmnIQyLm5tVFHPbKOc3MUaouGP+MWawLWils2lNNN6DBXzyAnOm39MesMg==
X-Gm-Gg: AYBFou3+LjBbRhrN8PfQKgIrh+CwPcOmBhWtH8FeCV0AfGEAqdngPk34GHPBe5OyTHx
	gB5IF1FCXsz1Xv0FEy8rzjim8qPr91is6qMxfo6Z6Fbas6XU0oIwlsRIqKqTf3h7QtPLheOMlbI
	6Cd/jPGFNKSCE6yKL/b6G9aqgbqG5o33piB5mGBQ4YjeoEW0ArCMZMaWGny2RZOneaZKR3Q/G4S
	uESGSczU1UTRBSrOD/OVFcHDFOtFtRLjupW+DPJMu771fhwOeCwsXFHiNGc1jBnqCeUVVVJllDv
	WakeJaQ+FNPhokbEbdEJXppLuxchPJQCf8DGA9q9mzWQSD0Y3w7H5uBX8NAYYoKgoKEBC0RC2lD
	4+Mv0icGAkCfOsTXUhUiBaYd+sCOdbMRlOz45wCfmggAbJ2xOtGkP9AynRywlJdCYXJ55mpe8+P
	srbtuJg8Lx8GQ+BXEGEbdj1/HyMTO69a3swqofb2wSqhjUJIU+pKMucUT+QEelgCpOSP4UFitFr
	g9fjFTqeSSZ0a8Yt8pVnicLE/rNzVVTU8zZ9LEU6nn2NxR6GNikJnx7bifiCvsY9Xrhi2KDJ8fG
	sC5GDxvnfc+tH2N0fAmHzhzM3wHutK5w5ORKMNxhw8URwDQ3h81PSg/hiqNvL2PkXkviAhBQvKr
	vsozBhDV5
X-Received: by 2002:a17:907:728a:b0:c4d:8e7:29b9 with SMTP id a640c23a62f3a-c510deba35cmr248611866b.5.1795010794695;
        Wed, 18 Nov 2026 06:06:34 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512346c84esm1024966b.56.2026.11.18.06.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:34 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v2 1/4] lib: Restore includes needed by the Mercury core
Date: Wed, 18 Nov 2026 15:06:29 +0100
Message-Id: <20261118140632.1080213-2-yegorslists@googlemail.com>
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

