Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002555;
	b=rC1bnLGENGuF3hSoVcqbyqAuU07Nq2Y5AKW2TzwiGRnAwnVQo+w16p4Wao59NGHF2kvi
	 clFujAYciRmjg+/9OnLZX3xu24Ag5u47XsjYMN2VpbgjcWlX9oZDiY+PN+HJvg86CNmnV
	 oIzb/oTKEeqKZ/58m+NbYNg3HJsixTwjUcyk24Q1F5Rn4/EwHqkMQrF4HsSpM+8ubVz5S
	 S4NnbVxzpri/+s/EV9rQJlpMFLnI2XUnOiE7u/jt3qWjKMCduajro960x1BCmb9xhfsO5
	 VQE1Tp2aOBl5emuqoPpS2LZPGLZlb5BEj4zhTT32/KRv8I2AM20wJk5ORa6FtIZsxIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sF3nOitx/RXFFWxE27aBo75MPzJ4caEtQ40JlQmXOB0=;
	b=hBLGSz2wbo8k/siGP7Qe2H0AENiCRyICsGTTsMd/paMSuSIae7ADZOrCkaRQ82txT/Pj
	 8EYToAOQ3R2CP7EvRdUEwRwSZ4uxXlcLtoakFoGjUe3ELRW/UzJ/lK+aVGoVeGd7OIGGg
	 QOVnzexc3YMurIH5OswbX4xupPf0p7iIVhFejQVqVptDVanB85HtorQJ5TSPfjMZZw16a
	 Rzce9lBt9+tYELRuuuBfoMYFg4/u47gxQn2NX2KpKSEX8wyGN8yJ7eSC+qkbc13kve7eB
	 55O8DzQn434J08RgqiSuIT2lyLGNrGo1D9a1T5GAT0P9N1zfrLhHK6nB2ZCp7ocSvyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=DscBKn2t;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED3606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 11:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90ED3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=DscBKn2t
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so1556043a12.2
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 03:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795002554; x=1795607354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sF3nOitx/RXFFWxE27aBo75MPzJ4caEtQ40JlQmXOB0=;
        b=DscBKn2tCGdy4c5DRHzIvYs7GRKPYMmuyd5Xfj76dkRstkpWBPjbjxsE+bbfmS7Qhw
         SBCCpLBi02UXT+HOPsU7nkoSmFC0bF6/5ntdS7ZJGU9jKW0LDV61FShBUFl7sNVVnGoK
         ajiLyjG6PoqHIY7L+mvdsm6gBUSGatG2Sx2P0nmdrf1h1Y8Mvg1blPFrQJKffG6r6eJB
         6y3JmA94kf6ou5IVvyTXF7kWIPvlMh4Wwnpm69mdFS4YB7xlkAa7r/RLep4U8MzUk9nS
         dPVFTtrKQjLSkkS4FJerg2qZYzuK8RnC1BGABQxpibRt2SRiopn7vZ9MRUGNC8Ee8i39
         stDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002554; x=1795607354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sF3nOitx/RXFFWxE27aBo75MPzJ4caEtQ40JlQmXOB0=;
        b=puT/EPlVWOiyh49rhNjZ9nClfgt5gTde2x09GF+2QG040m/omFylWOmM1PJXEadLKT
         NK5+gVzGXpq+Km9O3S6uAfdNNRlI52sZFVN8Li9kHlHxwJQfehdC65KKf5nDycjd2XML
         lkP5raEmf7gyoW9FnXvwvpE3qEAXSAeaE5GR1Njf0vwepZlHzj0d0Qpo8DHng4ljJlIX
         iVxlGBMNIXhRsYquYOMys8m4GcfRs29t+cU1YLsErGtk0Rki3Il6tc3pqGGMnKDmXV/Z
         rMPOeDMVxBVjDZsphIU5iqnlDqadMvlx1RkafdR8HWsaKalg516n0ed+c3pFrRLUW6Mv
         0APw==
X-Gm-Message-State: APuU4Z9P5U+7DvZHLuDNC2uAS8iqZzmU4k5S9ELXQqM+Io3pY+5Ftyw4
	94zjkQj2wW7u/aoqKycODyNUl5IirH8gf7FGBPUX7Xldg6oTcnXJjzmoZLnFuQ==
X-Gm-Gg: AYBFou2vwMKoj5NB/Q3NDFBDu/rB4aV7UopM2I0XKEDzZ6HW0oifa5uKjZFjw9TKNJd
	fekpLydaiAxJs4ePRm9ATf8e2FtV+0AwNOSHTVPf76BMZhIuiOFehdzlaPLA5Dvuzyw5rKYaS8Q
	zqV6rD0HIgDmsWzSV6TUSxYouI3RHvC9FLJkqSYLNyxHj3kcHGsS5HXEVP5JmTw6QvHrJ16KmRM
	YMLw3a3v6ay3i5U/yvbakaAOVaf74yDMR3+I9YFdIxPa2RCKnmJFuq+cQDSrCwJXlVt6sLM38AZ
	4qPQkjqgqParIvQwunSTXGapvMNhAWwY4yj+Ys/h0ltRfu0OzoYy3fP0SHRLuyGRgv2Krb7Knz8
	1SOlnJhSUvYB9IatzW2PWFj8z4RxtvC+arJ/owo6yXHs5n6CbgpvE7F2cHcdc6sbNlGgvhIbN9M
	kf6PY/Tp/F58Ubo1OuGr4nPPMrc4gTGzPy/KrmFFcPt/L4dIAiV694pn5UIM36ODV5NHIJDCrko
	cfhWrz0hl4HKFgF/tHG8SH6uLvak+I8qMDi+yWu418+vLcw39qty8HH43vg/Dok3BuYnMsv0t3+
	zhHuGueiVVlkvj7wKJJwjgonyMDBUfKteQEkFDDAI9xuFqfpAup3eyVlDs8hc2AK+YTUFDKZjzf
	LKMbYUrOn6A==
X-Received: by 2002:a05:6402:a514:10b0:6b7:6485:23cf with SMTP id 4fb4d7f45d1cf-6b887ef57f2mr1357592a12.42.1795002553963;
        Wed, 18 Nov 2026 03:49:13 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm917931a12.4.2026.11.18.03.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:49:12 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 3/5] testsuite/smokey/sched-tp: Fix build with C23 strstr()
Date: Wed, 18 Nov 2026 12:49:07 +0100
Message-Id: <20261118114909.3030884-4-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118114909.3030884-1-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
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

Since glibc 2.43, strstr() returns a const pointer when passed a const
string in C23 mode, which is the default since GCC 15. As
ref_schedule is const, assigning the result to a non-const pointer
fails due to -Werror:

  sched-tp.c:233:11: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

The result is only compared, so make s a const pointer.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/sched-tp/sched-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/sched-tp/sched-tp.c b/testsuite/smokey/sched-tp/sched-tp.c
index c2c3e41ed..e4d233201 100644
--- a/testsuite/smokey/sched-tp/sched-tp.c
+++ b/testsuite/smokey/sched-tp/sched-tp.c
@@ -123,7 +123,7 @@ static int run_sched_tp(struct smokey_test *t, int argc, char *const argv[])
 	union sched_config *p;
 	int ret, n, policies;
 	size_t len;
-	char *s;
+	const char *s;
 
 	ret = cobalt_corectl(_CC_COBALT_GET_POLICIES, &policies, sizeof(policies));
 	if (ret || (policies & _CC_COBALT_SCHED_TP) == 0)
-- 
2.34.1

