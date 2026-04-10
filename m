Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88978F4F
	for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863135; cv=none; b=UBF/LEZNBlCvrhhQMXi+66ZFzyTntakRdawP/bC7unPUIPjUEkShThSDfxoa9/Ng44ZSpB5It6q5+gNhXe86A/EjlMAPMsgRdzwa1BAYvGLX6J1I8i9UaNkCDM6WYYEGiuE3WBg2x7sFrRj5BqWxFfDTKmtVUx7haUGxeAjvuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863135; c=relaxed/simple;
	bh=2wIAWqB6OadsDfpeMwkJ9Kjr7ObsXAPtG/XpcTLsSck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ol5/gBz4GXpLfIiQljzN1GIzH31OZzgCQkCdNogdsfyMZPgEDIdwXwB+34eZH2n3yLsY4qOpy9CHpEwdvwXl/HdvQSgVqQ108HSIr/4FZn82naVvu8lYh1fPsui66OC6peP3f1aIl4CrtGjguilZMU6OwEbrO6yDCvNxHdWg6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHn9jGe9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHn9jGe9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b150559bso19759985e9.1
        for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775863132; x=1776467932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc7DO0SblATURIInqMQzfUhGAsNxg+E9Ry2wUqUHNPg=;
        b=lHn9jGe9FFH11csQ/P728cuX/0gFDMcNA6NO/hocaBvtuDT5EuTYp0ptLPfqNxczlX
         l7sR6ejAv5/Xdabk/IwEcAZVvdWMGO7SNZxklfXnIaRASpkk0xJSRwTZTFxdU8Acjjj/
         AT6kBL2JZ66Tyj8ehX556g58sb9459fGjsi49IghR0SNl9dBXGggxbXopicB+jpSJI7p
         IPjwVzL4iX4KVAUzQ4YSXIdVeE8ubOQIE21K+odB3hAMfv42uf9agf7C3p7ngY63lNRP
         Luf+GLKvRqZgium6D/84c05VIB2nputjMHSlIRkmn+vyslvVj5k7dv7VamrUBuB/HJ1O
         8MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863132; x=1776467932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc7DO0SblATURIInqMQzfUhGAsNxg+E9Ry2wUqUHNPg=;
        b=r0IBfh0+QKueR6OqefORHc+4jzwF1GpPikTsE5+cE6/ozBuWcnasu9y0J7Yb9lljE6
         ++yafdrgmWMSi/vJRf+MsfMO3skD2GNjDjBwf6PRU1TAa9argpuNt/0/NEPEA/bzvGm2
         L/BNvVcM4uTX91xtnOnlALbM4LB+Q9RjsuVAKG3pPR36TQUkXu9gq7gBIuO1jPBmY+yB
         spGf+g4cNeKGQCN8FYiIhpiew72gjBRLJ5BiVmcAaZSU8HYq/It/ESvQQSIlE+xwWld1
         gSU5XTGVybgZq2qwtQT+i4sl4jQoDYlKYVVHDHtjiV2wbggzdcN1066p/qhLT7Zzq+kI
         YojQ==
X-Gm-Message-State: AOJu0YwWQA+7eo/AorFXfkcWZCG6A3PK9RNm/t7TZX376hQTKH9yPy4c
	EiVw8rtmsZWTAbo4C53pRvIpidYf8M9oGjvha9b7RFfn+/psZAKC4XmXTs1gSV2o
X-Gm-Gg: AeBDieuyl3GClD6xP+E69jc1059o6khTHaxZgbXzWOhkH2AQ+Oi5lAR1ypwqGlIcmvN
	IrzMIyWUvs+0qbymBQ4I/l2ikjDNs8zto0ru6DMH1Uhi8kRuIfw6EHy0ip1Q3bZdJ2WgHITwtFd
	MdOxFexFOtu7ztrhfK8C+PkyPbI5kL7QkxYyMNkzOa+yUdLsK/u+8oBHFVZ6FxqI0OsKA4GSiIc
	9Fp/qyaz36D2CE2gjjLVYIcQicdqiOdxLUB8r9VGD/QU4arCblzmEC1k6Lhc0qKeF66c7PmF8lG
	DDZIB3jiuPardodZxJYbVdkASh33jEHA+9JMpDNd+n8bHQ1Erm+9ChlWSolgKKQynj2L0nvA5Rb
	VKTkGNfyJnFAkLS1YGKtymNILrNn096Llh6FEmm3r/BhVFbkVfEmFSsfA+XOO/JKNvTBvI0BUDS
	Nwq+AsjHfG89H5fvatboyf1SpTVg==
X-Received: by 2002:a5d:698b:0:b0:43d:68c4:df0 with SMTP id ffacd0b85a97d-43d68c40e82mr2199938f8f.10.1775863132465;
        Fri, 10 Apr 2026 16:18:52 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43d63e5061fsm10883649f8f.30.2026.04.10.16.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:18:52 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	jan.kiszka@siemens.com
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH] drivers/net/stack: Migrate struct rt_proc_call to flexible array member
Date: Sat, 11 Apr 2026 01:17:20 +0200
Message-ID: <20260410231830.4576-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the following WARNING:
memcpy: detected field-spanning write (size 80) of single field "call->priv_data" at drivers/xenomai/net/stack/rtnet_rtpc.c:93 (size 0)

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 kernel/drivers/net/stack/include/rtnet_rtpc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/include/rtnet_rtpc.h b/kernel/drivers/net/stack/include/rtnet_rtpc.h
index 01d7ab152..f4ad47306 100644
--- a/kernel/drivers/net/stack/include/rtnet_rtpc.h
+++ b/kernel/drivers/net/stack/include/rtnet_rtpc.h
@@ -43,7 +43,7 @@ struct rt_proc_call {
 	atomic_t ref_count;
 	wait_queue_head_t call_wq;
 	rtpc_cleanup_proc cleanup_handler;
-	char priv_data[0] __attribute__((aligned(8)));
+	char priv_data[] __attribute__((aligned(8)));
 };
 
 #define CALL_PENDING 1000 /* result value for blocked calls */
-- 
2.47.3

