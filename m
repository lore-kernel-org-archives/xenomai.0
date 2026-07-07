Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610E3F889E
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422141; cv=none; b=mGyF8UZYp8D4wJCj4BQruLMQigQqDxbpdT2d/4hDLIH+vU2gUfjzCEwgtGSTpVCB2RenLO5lcHam0fH6lhl1T6LSKDTAKMsXc/z6bwMgs0XyoXI54708EWATYRx3n52FOTtr3fgHE44ruGlDJ1RnxjjjaBtjF/RyvbXSe0XpDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422141; c=relaxed/simple;
	bh=aX/77OcNDaKi2qVpD9DwYJbftF6PAUCuT6EdGbd5vwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nf5LXYxPaWVyQK6s66kwkQV65Gi08c8RqGJksp1W1ym8CbQ3c9nr7+2WwJzP8PSvbYTKbPY2afxVSElvvEMF6WJK4ZzkwMclLqbRE//CGpQtVBHxWk2Mp+jzGVVpXuaxMlqLcUfUSMDvrCa7BUJY3m1H5a1557C5xc+eRLvMEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnkHGiq4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnkHGiq4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c83474ddso35676055e9.3
        for <xenomai@lists.linux.dev>; Tue, 07 Jul 2026 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783422138; x=1784026938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCjvtFWIZyB7f0xjqGmGeyhopK+uWxyGtnrenuDEHSM=;
        b=ZnkHGiq4O6t7kw4rew98cuo5p1I1IOeyEpgsc0kmgIabt0w+V23k3fIWGBqdm7uD/x
         8LzXDeBxovgS+q6QADB9I/k3v49IPr8bYIIqjSGowtYHO07hRcijXt0u9J6Gve1bTMYS
         4DKLEzdLy5digQRpowhoB6qtLxq5YOXjQr97t30fMaTdus+Ys+FVDaSVzJhNUlxdNNjv
         joPBzy4hFM0dn6XmpVi3wz95YxXgnKTGO62GfbrjAbDBFxjnZkGy9UHq0ADAmUgCQhjF
         xMfKJXaigdQNlEB6qEWbn2qEBiCzgD4i4NgsIZY/IW5D5HyMaa9/nVebAoELr62ws1jm
         iHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783422138; x=1784026938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCjvtFWIZyB7f0xjqGmGeyhopK+uWxyGtnrenuDEHSM=;
        b=MHnKrD49nWjEGwB6/kdmhDY5rFKZ2CdAmkRODu/VdDYseMTEz+aK3GD+KZJOLqr+1C
         Dhc7e0NKqVj2C5wTeb6h90VL2wfqD8Qb9tohhFSy9LbY4Q3ouS+v0/NBEWS5YYmjWmc/
         njAsW4/K12XT9gR8kIWvVId5eK17QRAGwthqUGQlQxKne/jnxSVSaV9qgId+WKKliCUS
         T7KaQsEnRUEG08xPr9XuhW2EJ6OhycCjvz8Y5Ew7Vkxenr/PpVqH+7NBg6wYGI8bFTAV
         00Lr0Duc3KLEZUESVHvxJmu9aYXFOK3c0kPdikS4/Wi0nRKFAFileKKyQBqJ0U6nZuyJ
         s/JA==
X-Gm-Message-State: AOJu0YxyoxO4Kv0bM+RS4WRJCAVLjokQX1DzFGVayjWJqMS/nv4ZmA6x
	La4j+sNkGiL3dowTibs9mlbxnTSStOb3AdoNnU42+KJbOkvDPXhN5FpDUngZkt7+
X-Gm-Gg: AfdE7cky6j9HXcVhmS+o7oy0Jq1xVit2IC9Oy2xh+WoJRy/CosLMSAQr25ZMioP1yz6
	SWMi+9v7lp211qrflmvR57LlFAxaBUEz4GMVw2wEPbHF544syOyCU1ehtlESgOxnxwJEYchP3bF
	HR6c/6Dvs8zq7qEgWnu9xRIPVqnh0b5dwWGQ3Obv59tp0dbOiZVmAtozf30jYCmAtJ0YXd5KPc1
	lpg7NmiQNfNcOSz0Iols0SyzkII55DK6r0iHJE425Zy/rP6V4oZ9o4OTDiadDJorrbsQwncu1MG
	mp3bEzdDE3g6nDJrLFA9TEZyY+fvRBZAC9FfkSPo4QEIU8voS+j+RSKdNyT/HD9VcLcY9yHVyL7
	CPwbEVBYaFVq0rur+WHOGgmHYcPAkzosgsJ4d67ATJ3JICu8Uxj12gK8N0ZGM/fkP6dReT78AHm
	iAZpT6ELYRqwEETrxqiRZS1FFgDQ==
X-Received: by 2002:a05:600c:8284:b0:493:c1bc:79c4 with SMTP id 5b1f17b1804b1-493df063dd8mr55140965e9.7.1783422138303;
        Tue, 07 Jul 2026 04:02:18 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47ad69519c2sm35547450f8f.37.2026.07.07.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 04:02:17 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] utils: test: show test name before running it
Date: Tue,  7 Jul 2026 13:01:09 +0200
Message-ID: <20260707110109.10253-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This way, the running test is visible. This helps for longer running or
freezed tests.

The log is now shown after the test name.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 utils/evl-test | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/utils/evl-test b/utils/evl-test
index fa3ef73..5139d09 100644
--- a/utils/evl-test
+++ b/utils/evl-test
@@ -83,22 +83,23 @@ result=0
 while : ; do
       for t in $test_list; do
 	  test \! -x $t && echo "$(basename $0): $(basename $t): no such test" && exit 2
+	  echo -n "$(basename $t):"
 	  # Swap stdout<->stderr for the test, capturing stderr into $log.
 	  log=$($t $test_arg_list 3>&1 1>&2 2>&3)
 	  status=$?
 	  if test $status = 43; then
-	      echo "$(basename $t): $log"
+	      echo " $log"
 	  else
-	      test -n "$log" && echo "$log"
 	      if test $status = 0; then
-		  echo "$(basename $t): OK"
+		  echo " OK"
 	      elif test $status = 42; then
-		  echo "$(basename $t): no kernel support"
+		  echo " no kernel support"
 	      else
-		  echo "** $(basename $t): BROKEN"
+		  echo " ** BROKEN"
 		  result=$status
-		  test x$keep_going = xfalse && break
 	      fi
+	      test -n "$log" && echo "$log"
+	      test $result -ne 0 && test x$keep_going = xfalse && break
 	  fi
       done
       test x$repeat = xfalse && break
-- 
2.47.3

