Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5013212A
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282694; cv=none; b=De5GQOu3XhsrvAgXzyYk9kOFLC1IRvskHMlNy/2wliQb+YzgpUWyUxNLnvURtoVLENSYxejPvmck9jDqf3NtLdHtksZs/+ziDPfoHDwcM0KGko3AYctpCLkt9gc28zx0ItawgMbtrNl22+pmN3d7kQ+tzm933xeyycENiz1xZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282694; c=relaxed/simple;
	bh=RSMW+U51ONfwqC4xasn9UDZApXFMkF0prPQhA0aEkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF16u05+wpG3i14V2RLG9+EcCxsgUYg/lRIOXJiCam+dkTyfwreymeYu3PEHtu0/bolOOFG+x24wCTqQuQ2+iAWD/fIk1zgN5B+lYEYVw0P0cWU7ReH02jwJIUroQZwhgK5i9IMhjQN0ua9/QoNQGiVs5BdmHk5suCplLTnpd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=SrkBC5aH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="SrkBC5aH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bbe908380so23874655e9.2
        for <xenomai@lists.linux.dev>; Mon, 02 Sep 2024 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1725282690; x=1725887490; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4HnNoZErGmJbjpVeYUvB7UbT0hVDPK2G2ZlkCfqZK8=;
        b=SrkBC5aHZODbJEMagZthGw/XcZbAjar5junvrnCQfN2XRmZF/71B7MBK3tCUOcU7E+
         H7SKf5VADDaYFaOt1r6Y+BOFfZMLkwJgHH3k1nuoYCA9WxtP0pgMGp8huIf2ieHM/bTK
         sKESGi7PHyG2dXXEc0KnWRjKy6KtIyN6PCbfrjdZPcEIe6gVuj3fSMdBfyGFuKnujL4N
         jP4xXcobRZ6to8WzSRjZB9XMb1kakQ6glkSGcnkO4mUSlDopAVlt/hHA7now1LLE5oQl
         T8kV5SkpwO7Tc2ARtSYltZ+79ql8/x4LvqfJINigledaNap4IjvlPf7xD/J5ldC9Hci+
         09Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282690; x=1725887490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4HnNoZErGmJbjpVeYUvB7UbT0hVDPK2G2ZlkCfqZK8=;
        b=MVEdcps+JBLBSgWjmgTVoLuVeooADr9RSl53FRMtuZiZMDbt8nsNyKyYM6nq1Qi6hW
         08gjw53RqjPkBowOtDB/wCsiMiHaiRH9rXP7sMudS/QIcfdfBeXTxXrkxYWaIW5anBFx
         ud7jzYcpuf35n1GAhALHXlo/JiShd7G7/J1SyxW6Tm+KpoJIEQ28rSi/xY2Qa01qulIm
         ryTUoX9s22jbRBdezz1gjIY10f4/rEwxzN7IaKJd2B5T/mEM6gl669oEZXZuWpVoke9a
         iZ/pcO96Do9voCEy15u4LnKU/xcwrVAZBavpHtmMLDRoQTeTKr54rWtJLb8vnbPs5hCE
         TIgw==
X-Gm-Message-State: AOJu0Yw/F4aCYEDdUtlwOTcuLsgmG3FmzvKZbiN1U3cy62jKUjgaKErp
	EGqbr+ioX9dhmfhez5CUHt24yUAeRQ8noOaW8+BcPB0o1enFplUP1H2khEDRiO81aki5KIpD8wx
	yBKs=
X-Google-Smtp-Source: AGHT+IEkmXzwjHlauyfz4Dd16SYxh7c6DrglcCC9sjdWBZp6RXt0AHqOXQ3rAJlrIiFGvvS9eyYg/A==
X-Received: by 2002:a5d:4f91:0:b0:371:86b2:a7e4 with SMTP id ffacd0b85a97d-374bcfb8512mr5366998f8f.37.1725282689632;
        Mon, 02 Sep 2024 06:11:29 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba83sm11511430f8f.54.2024.09.02.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:11:29 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v4 3/4] alchemytests: Set cpu-affinity by env var
Date: Mon,  2 Sep 2024 15:11:23 +0200
Message-ID: <20240902131124.37844-4-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902131124.37844-1-simon.graber@sigma-star.at>
References: <20240902131124.37844-1-simon.graber@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alchemy test runner can now make use of the XENO_CPU_AFFINITY
environment variable by setting it before dispatching to the individual
test programs.

While not changing anything user-visibly, this stresses the new
interface in CI and allows in a later commit to pass the --vm argument
via an env var too, removing command line injection from this test
case.

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 testsuite/smokey/alchemytests/alchemytests.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index cf9f970f1..edbafe6e7 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
+#include <stdlib.h>
 #include <smokey/smokey.h>
 
 static const char * const tests[] = {
@@ -31,12 +32,19 @@ static const char * const tests[] = {
 
 static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 {
-	const char *args = "--vm --cpu-affinity=0";
 	const char *const mod = "xeno_rtipc";
+	const char *args = "--vm";
 	int test_ret = 0;
 	int ret = 0;
 	int tmp;
 
+	ret = setenv("XENO_CPU_AFFINITY", "0", 0);
+	if (ret != 0) {
+		fprintf(stderr, "%s failed to set XENO_CPU_AFFINITY: %m\n",
+			__func__);
+		return ret;
+	}
+
 	/* Try loading the xeno_rtipc module as the pipe test depends on it */
 	tmp = smokey_modprobe(mod, true);
 	if (tmp)
-- 
2.46.0

