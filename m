Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB659215069
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734813; cv=none; b=cM9k2uAnEXqnyKF4ckeHbhiYMB3J+at7WR35z7r/HtUIzzmIUibAGDIB5Qm90wnj4yRfoAQe2EW5Yc+Gcfck6imrH41N8TpSIYQS4d06M4uUDy8K8MRI9yA+YymZvMbZw/4JevozX3UcuVH8UTgsg/oSypBto3wSJHMpgp/8ZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734813; c=relaxed/simple;
	bh=pfT/0TyA4YtK6uLgUCNgLRf86sirmmQ+kBF+PvC2API=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5iqp6Lvuiv1eeEjk6TAcNekL9277T0HeR9W6W+LuvP/NtQVFQQNg3joHCAZZeUcCrbb7RIJ9QZEXell4hDD4HRxiOAOQbaKGkYOysOlsv/Qp7gkcyxw16VOVG0aP1YFSIggwiFl71lm3ir+ix/LuRTxGMoMmMyBy/uyh7bUIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC9byIiu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC9byIiu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fcf59a41ddso2312394a12.3
        for <xenomai@lists.linux.dev>; Mon, 09 Dec 2024 01:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733734810; x=1734339610; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnaMps8uHeuBN5ZwOBgtpnKf9m6+wX33oFqg4x+XBeQ=;
        b=AC9byIiuu6vPHt8fnBmWW70YWiTMgyf2MbU8Qqsud3VogyiKixap7eckshz6hnwK79
         zh3NbFGVbFtDDFf7awCgkit/C9e1q/CS5WxXqs7Z3+BpPKEFWXGYjfdiPPW3Cpm38Z0O
         EBaCIDyim3+lkiw5wQBPCmdLWJg6lLlj4qDG28foQg/mPhTv6xSOFUgIUHt7iXmC0KqB
         swQhgMs1rzng+zMH6Aa9TIiDHXOLhuaKG4tM4Q0ljQ3iX2CBLdTsdaqhg8jPOx+TdvXP
         7lCyTlt6Mm9AeCXSPhbsaR982H2zYCMejq89qtAJQS2YaljccX5FtxHEJairpuEC89yK
         ZxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734810; x=1734339610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnaMps8uHeuBN5ZwOBgtpnKf9m6+wX33oFqg4x+XBeQ=;
        b=sArirVjNX0wHDgKUhAurmcnqvymRY6dNwYe9Iv+Qm/N3PSuJ18V2r3OazCooOWVqLA
         cKlCshVmFfGa5Pq3BW4p+xB5eQMcaaEcczlfiFsOiG4aMNi+fEi5+xDZZfuQ8hhr6n0+
         FoaZAxVEqdvbdfKJ1QdiW7Srmx6/4zk/E2VHbEPzuruj7yZ8AFoj/ceTPHiBtyRzN/YX
         tmTNnMUWqH1qOpAMxW8vahHzjG9OkHSRjocx6pORM7ULoIWbGxt7IWOUQsfS25XEvOsU
         iunQhafT5CxXVMJVWd2kLJyzv4OebjiORPOQQOVSjN55MT5ZGCC3wTGN62fabsQpxZfs
         eWlg==
X-Gm-Message-State: AOJu0YyHXYO8HBp57iU2Yizgkjk+fZBuFUdmkP4HnEa6QVNkFzWWDKlF
	5QCDrFAq5nkcB7pEauGxDr89crQstt2NPhKRY/BZIInRJQhq0w1hTRAagH+u
X-Gm-Gg: ASbGncsV7oFUup1kN72albeUgF1NUqJibFo6uIbdnwxZNciSNX3IOlARziSa7e7pUPA
	4d8BlwN7c2xewPdrw38keHdKvM6FjUNJIJriWY07a6bArpVFDuHVi5WExc33wWFh9sBKs1aq+pz
	SQr5V8y24lgyRTC3lgF0QPikjNWsfrR273N8euMoGe8bj6DjNDqKmglYwGucLCY3rZZHFkIJ3Ru
	Ffb0vmlS5vieFvu3ZKasjqjh1bshm2hsaHlh0Oeb7OXZYGpaVDA+SE4/CAyyBB9aLtBznJg
X-Google-Smtp-Source: AGHT+IEOkwsA4ILPLQU5H51zKtSdQwSmtPVdG0KKtz/B03wz8/VtPU+3vbVeWF5EO7gJ1KSBDpjHjw==
X-Received: by 2002:a05:6a20:7344:b0:1e1:9fef:e959 with SMTP id adf61e73a8af0-1e19fefea4bmr8769741637.27.1733734810056;
        Mon, 09 Dec 2024 01:00:10 -0800 (PST)
Received: from c6b487f3e4fd.tail12dc50.ts.net ([223.72.121.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3a637c41sm3478817a12.78.2024.12.09.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:00:09 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: xenomai@lists.linux.dev
Cc: Qichen Qiu <ruiqurm@gmail.com>
Subject: [PATCH] lib/cobalt: remove unused `pthread_attr_getdetachstate`
Date: Mon,  9 Dec 2024 08:58:52 +0000
Message-Id: <20241209085852.676777-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The detachstate is used to determine if it is PTHREAD_CREATE_JOINABLE. 
Since this check has been removed, the retrieval of detachstate seems 
to be unused.

Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
---
 lib/cobalt/thread.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index dee39a8d4..e237e7ba1 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -129,7 +129,7 @@ int pthread_create_ex(pthread_t *ptid_r,
 		      const pthread_attr_ex_t *attr_ex,
 		      void *(*start) (void *), void *arg)
 {
-	int inherit, detachstate, ret;
+	int inherit, ret;
 	struct pthread_iargs iargs;
 	struct sched_param param;
 	struct timespec timeout;
@@ -167,7 +167,6 @@ int pthread_create_ex(pthread_t *ptid_r,
 		 */
 		pthread_attr_setinheritsched(&attr, PTHREAD_INHERIT_SCHED);
 
-	pthread_attr_getdetachstate(&attr, &detachstate);
 	pthread_attr_getpersonality_ex(attr_ex, &iargs.personality);
 
 	/*
-- 
2.34.1

