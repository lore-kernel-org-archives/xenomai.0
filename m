Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77A16438
	for <xenomai@lists.linux.dev>; Sun,  3 Dec 2023 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4/QiakZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40bda47b7c1so18432045e9.1
        for <xenomai@lists.linux.dev>; Sun, 03 Dec 2023 14:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701641840; x=1702246640; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQu2816e/IbQQTiOsKqZs9MJy90y/aNZGJDtpJOTe6E=;
        b=J4/QiakZ9QbtN5pSyvwIxG6LMg75w26uWtJ1ugsewzEicpigTWVeTeV2um7CEEZjDa
         n6WsDZ4qXru62rsq0IwKPObo3Bl5lO8qMugYVPAiBY/m1FP4hyIAMATnNwFo1MlPQVYZ
         gxMAEC8IlhgxdIFrL0fgBikOS5n0KMkDtYHAv78hPa9otcqW1Tt69iEqMGiT2iKz6pdY
         vQ8os3WLgm7Av/ZBrMlFHQ0sHbd4Vyn/q6HfvTkGIJZCLEmkGoSbOT5tH97WCzOTVfoB
         3eou+YRps846qBK8ynWEmk41Q+Lc3jJ9p299vJY2YxWcywAPpx/iT8u1QKPgxKaAOumK
         edug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701641840; x=1702246640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQu2816e/IbQQTiOsKqZs9MJy90y/aNZGJDtpJOTe6E=;
        b=Uq+0eEpdtBDHvAr05Ju1yg+CiOr2/oe4AoRv2NtdLLqD6PbD5OTX/RbFOZnd+z5YZ7
         16WUtOgGGnQZx/Oh09orPqauwZWqWwuyaXBUCsBVOruhFtJec8+t/VZB/A3ChvTJOeQb
         VO9DgemPm+W7Pk00IsG1c4Ud5zHdPrgECb3E/pRL1EYVWcacLqpHzPZhwQEcP5LSEPyU
         RdoE2hTOgNHyiO8Y7uwRfGdquCiJOS2ReDkEElI1Il8xDmhKoao3Y9K8VfO+4Odtjd6b
         NodXwFyqrM8etnzHsu4eVgQ7DR6vhbbeiJxhzuj+d9pVDwdvUMJ1apLNXS3WYMfXCiDY
         ToNg==
X-Gm-Message-State: AOJu0Yxh4aGzwwON6q939VNT2r5cG8/P7huap6tZZIskl5dwhvacKLr0
	qgMZ3igusPhG90tnIskttGJMcMFg+BE=
X-Google-Smtp-Source: AGHT+IENW80wj1qWPy0NAwjZ9cUlKHr6Uy7x8W/g5cTKUnpwD2B9G3k64aRqVTbJgGUIMA1+9g/1HA==
X-Received: by 2002:a05:600c:851a:b0:40b:5f03:b42c with SMTP id gw26-20020a05600c851a00b0040b5f03b42cmr799315wmb.334.1701641840146;
        Sun, 03 Dec 2023 14:17:20 -0800 (PST)
Received: from kali.home (lfbn-ren-1-787-165.w83-197.abo.wanadoo.fr. [83.197.114.165])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm12766800wmb.6.2023.12.03.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 14:17:19 -0800 (PST)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH v2,1/1] lib/psos/task.c: fix build with gcc >= 12
Date: Sun,  3 Dec 2023 23:17:11 +0100
Message-ID: <20231203221711.339018-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following build failure with gcc >= 12:

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

Fixes:
 - http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1f73a6ed8a

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
Changes v1 -> v2 (after review of Jan Kiszka):
 - Replace SUCCESS by ERR_OBJDEL

 lib/psos/task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/psos/task.c b/lib/psos/task.c
index f678be61d..cc7e5c9c4 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -362,7 +362,7 @@ u_long t_start(u_long tid,
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = ERR_OBJDEL;
 
 	CANCEL_DEFER(svc);
 
@@ -426,7 +426,7 @@ u_long t_resume(u_long tid)
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = ERR_OBJDEL;
 
 	CANCEL_DEFER(svc);
 
-- 
2.42.0

