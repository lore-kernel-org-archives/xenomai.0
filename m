Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6554C7A
	for <xenomai@lists.linux.dev>; Mon,  4 Dec 2023 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk9TlZs/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so2529912f8f.0
        for <xenomai@lists.linux.dev>; Mon, 04 Dec 2023 00:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701679300; x=1702284100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVV+KvS5SbL1RhATYRHrRT+G5jCpyZrAqygM3lEidRs=;
        b=Hk9TlZs/Qg5BwHA5UKf1wb1gAyBiTwslsKfKcCcx+PauV3C6T5BLVygbFxskimFwfo
         paGfP3WbwcfeG3Auc5k2FdjOquGSwGiryDXMkf1nGWRxme0hD7+CD/hw7cWwbHXn3z+e
         vZz6irx0+2hMy3BAzkLJBwNL6lExFS1pDWLYk6BQnbLYfqfNRV4b6Vbtb9T4bQYLnWPX
         DOXP8Hj7aPCVf/DBRYhokqYmM/uhjgUrBo9+VpSPCX9udE2IhkgBbm0Qv9jc3UwmhHme
         knclQg5lSdTcJ7CNX7MjxLyaQTw5xwXyxnoDWR8wXbAp/AcjFwMZsFxUkFSTW7PrH0gE
         H0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679300; x=1702284100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVV+KvS5SbL1RhATYRHrRT+G5jCpyZrAqygM3lEidRs=;
        b=XOcGMl1fOs3+85+zJnoL7GdqUdaMQoYbzxlEK6y1hAwv2FrrmBb2QDN9d6uJAlI8I1
         h+CpT1ZAfi3oahnj8y1DkVl1Dj2q/xUs8xVXMqLz1KiBxYYxDxiy8PD10xfTyWYogGGu
         QCSLxrPkYP2kS4mBihe0O58U2uurltgskFO41PAz5YQcUioFRq1rR3l14OZxo/SQ2aNs
         4LtIwj7Tdbcu0yc0dRt5zVMAmOiARQ650i2UnJWv6ttU/IRhuOPAn8zO8+Wx1KKCWDeL
         ydFvviQNeYsb5y0yz17Dw8f3XTheO1IWKyeb6EPF8w8EKfnaBozKqhBcTBYrnGsEAL23
         xdbQ==
X-Gm-Message-State: AOJu0YyDUJuucIWXBLNw0ACvsZg3nPPxWtnn6AgBpnYZhha2gMhxRZoC
	MyYkpk2DHlryq0Fox/RYnfV/phD7FK8=
X-Google-Smtp-Source: AGHT+IFrRpgECAR0+lkbm3udseWwdUbVXcb5dNpAjVMfaBws4uubHv1PkE6WnpAXAkMtmmGeaP7kTw==
X-Received: by 2002:a5d:4443:0:b0:333:1c93:9b91 with SMTP id x3-20020a5d4443000000b003331c939b91mr2361867wrr.20.1701679300073;
        Mon, 04 Dec 2023 00:41:40 -0800 (PST)
Received: from kali.home (lfbn-ren-1-2129-239.w92-167.abo.wanadoo.fr. [92.167.208.239])
        by smtp.gmail.com with ESMTPSA id b5-20020adfe645000000b00333404e9935sm4445654wrn.54.2023.12.04.00.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:41:39 -0800 (PST)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH v3] lib/psos/task.c: fix build with gcc >= 12 and -Ofast
Date: Mon,  4 Dec 2023 09:39:35 +0100
Message-ID: <20231204083935.629619-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following build failure with gcc >= 12 and -Ofast (found by
buildroot autobuilders on xenomai 3.0.10 [1]):

task.c: In function 't_start':
task.c:398:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
  398 |         return ret;
      |                ^~~
task.c:364:13: note: 'ret' was declared here
  364 |         int ret;
      |             ^~~
task.c: In function 't_resume':
task.c:444:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
  444 |         return ret;
      |                ^~~
task.c:428:13: note: 'ret' was declared here
  428 |         int ret;
      |             ^~~

[1] http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1f73a6ed8a

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
Changes v2 -> v3 (after review of Jan Kiszka and Florian Bezdeka):
 - Move ERR_OBJDEL to get_psos_task
 - Update commit message to mention -Ofast and xenomai 3.0.10

Changes v1 -> v2 (after review of Jan Kiszka):
 - Replace SUCCESS by ERR_OBJDEL

 lib/psos/task.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/psos/task.c b/lib/psos/task.c
index f678be61d..b5cd087e4 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -99,6 +99,7 @@ static struct psos_task *find_psos_task_or_self(u_long tid, int *err_r)
 
 struct psos_task *get_psos_task(u_long tid, int *err_r)
 {
+	*err_r = ERR_OBJDEL;
 	struct psos_task *task = find_psos_task(tid, err_r);
 
 	/*
-- 
2.42.0

