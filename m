Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F68833
	for <xenomai@lists.linux.dev>; Sun,  3 Dec 2023 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAHyj6tc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso2938141f8f.3
        for <xenomai@lists.linux.dev>; Sun, 03 Dec 2023 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701614590; x=1702219390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgQhN+Mb7ciArjwfa/4dpvPkuOdX4aJshaG/d9ewnHs=;
        b=JAHyj6tc6EKcuXvOwiq9lkDIpjI2ObvOojzHakEcgac8eI42f12wzqUuhIkgWk2x8P
         Lqz0XZk4z/rKn59G6WfYLWBXAU2QfEdtjMfhUY7TnpM3VQjgJbHSsOuJa546RD94ngKn
         6TPR4DAsGbzkduDtUnXa8zFRQHSd5p9OY9v6cHikLBReCJ50iSCKonf3LpY0XkWlRRGr
         I1+x5th/lsvl4VqGJQGXLuAI2Qt3PleT2Zw+0IMcBJ9AAz2VTgJuz5KzNMUyRYkiVp76
         NslnCSf0xy+AJcOzvLbIUKfslx3feKvW1VxMx0eUqUF/md9vYsANwGkT3sHsKuwJkoxC
         J19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701614590; x=1702219390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgQhN+Mb7ciArjwfa/4dpvPkuOdX4aJshaG/d9ewnHs=;
        b=mRPzBeECR7Z0zDuPJ1FxpCksnMXMXiteO75GjAX4U1QZZjer8XVOI8BJcKgFyuRwKV
         JD0yEW8swEeDP0wgF+ikwXtvG0qZb0x2Gv4TBDNG9K0IUgmYvhkchnMOQobn4KdG94R7
         oB4QvHZwJiHH+oCP6motYb50EIdFJE7xdspK+Ina7mUvfls7JkBUoc/UkFHgfOaTabgW
         QZXAARR6w1FUlsS/Ud+6NZfMrp0QypPMfguDMNwF2QjWXF1A80mo5WH5Z+hMwhpl/bk7
         wQCAQuchM+jXrCm3XYWont/b/vHHBrifXsmrnydh8yebEpH8EICh9ZbjMFMNakiHd/k/
         Tw+w==
X-Gm-Message-State: AOJu0Yz/YVTUMD86to2YAKDVhN4CW/bvYgql1OWeNIy2kpUIqteXjCR+
	O/6UqjzPmlMkg0bqBKNjvQWdbbOooc0=
X-Google-Smtp-Source: AGHT+IEqE0hgExpNI5jU77C+fWLEhpU7JKYZyZxih9or9zYy5Zz4jsaWKLBDylv27lV80ma4FzzK6Q==
X-Received: by 2002:a5d:4cca:0:b0:333:3117:c411 with SMTP id c10-20020a5d4cca000000b003333117c411mr1326446wrt.162.1701614590296;
        Sun, 03 Dec 2023 06:43:10 -0800 (PST)
Received: from kali.home (lfbn-ren-1-787-165.w83-197.abo.wanadoo.fr. [83.197.114.165])
        by smtp.gmail.com with ESMTPSA id 13-20020a056000156d00b00333483b468dsm1019561wrz.88.2023.12.03.06.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 06:43:09 -0800 (PST)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] lib/psos/task.c: fix build with gcc >= 12
Date: Sun,  3 Dec 2023 15:43:07 +0100
Message-ID: <20231203144307.1940139-1-fontaine.fabrice@gmail.com>
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
 lib/psos/task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/psos/task.c b/lib/psos/task.c
index f678be61d..27bcc28a9 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -362,7 +362,7 @@ u_long t_start(u_long tid,
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = SUCCESS;
 
 	CANCEL_DEFER(svc);
 
@@ -426,7 +426,7 @@ u_long t_resume(u_long tid)
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = SUCCESS;
 
 	CANCEL_DEFER(svc);
 
-- 
2.42.0

