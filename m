Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAB261B92
	for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852511; cv=none; b=WJ44xZdd3nXeiGbDVzhQyhNZI2rkyEPeU1zmEzR4ijjIdWhx6Xlc7F4MQUVD3IVS1uV2JRXe9ipAG2N0DgE9IxcaF8N07VrBOz8n7Lp/4addtrpy3r1IjEZ0C3qedUcrpTP/ImFwOIH5JKJQoQ3/WlsONvL6xUMree4CPSL3oXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852511; c=relaxed/simple;
	bh=6bHt6ACPRcAhhFioWMI3jH8nRAXq0j6J+WrLfGNV3vc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=K+QEUECk8g0TB9t+EQZRWa3V6lQpDkJFkh037fZ3ayO2TJ4Uz8z5u+qVDX9kvQMrihyYYPKHExfM85+UnpsdvJ/l8r1eeCa59QHo9j4RIG+k+4VV9WwApNkeh0RdE6cQIjGk70zzGEi0Gb4XVTq1i9IlPS6K+MRfciXaGcxh6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd93sjSd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd93sjSd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso22075585e9.3
        for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775852508; x=1776457308; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKLl8daxkVmFWDJMp7NLTrt0f1CxZqUZIJEOwZ5HCFE=;
        b=bd93sjSdQpI+i8WrweJW2rxmTnLX0NzItqKWUNoslJ5VuBlwokLspGJ7tBRiciIXlB
         DG5BIVdakaBhrqaseItrtEFZu8dSnpy54Mf3U/GlBhhF6hdM+/0aXqwFd02tYIoXG96E
         vqfS7O8PN+i5j/KIezRI5f1y6AQi/ulHqP0vbK5xyXdiKGxdHRc2LIYaOIKMoTpU72cI
         ItPMgCfWB/35L6gfkSAM2gij1cLmPPpgi+75KZgXKh1OqowxFEWIFCPPwOSbqMc6uhTd
         UXo75E8ncb6H2Ez0IxUkIdKa4kr/oPTD+P3nitvnasuQkVlA6m0tVebcv2e2Gqwe0zav
         pDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775852508; x=1776457308;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKLl8daxkVmFWDJMp7NLTrt0f1CxZqUZIJEOwZ5HCFE=;
        b=abbbyuh3vdzY+NB64Ys+/4Vv26v3Ew2YIdbmEVC5q98cbMrHGhAHLkrFk299dROoIz
         DaIWfITcRCf1YGfZkOpVz1agMh530IML0ltlTdFvod6rBCVe5AVsTio92pAFwgIYhhvA
         W7NOZmWPLB7+x5clkH1yZNmFMDjKarRDxkkNXLM045Y5bLZdM3nqjV8bHK5d9L6gHEi1
         ik3CAhqiFLFnO/eeoRaJT4Pt2B/ocUyH5Ehet67dZ38FFJZG9uv3mTTSlx1wN8R4YAUj
         Qrvk4HslTJrIVmS9DLwI9iFLffc/obgp8/sexbyNnlTPeGbPrs3dtXMwM1+PdPclxQ1w
         q1NA==
X-Gm-Message-State: AOJu0YzagERzt3n1SSiro2ipvayvOKucPNnEYQ9XrQyYGYAUq995F2Q+
	UQQYXI+nLQ68R/KxZwq7Qvrnvyr5YVZpx7bPI9LUWCP7OXk1FyYOUTTCKdvvQQ==
X-Gm-Gg: AeBDievOsuUQpGdAcwnYOUBLzI1r8ZiVXFdfjgYXr/nH4Q88FGdueUsZJiMx7ijdFwA
	zEil3jbmG+3OY+8HW6+9a1riASieQ1Fb/cKkVb7SWZVFMEzSMdzC36n99m82JGZ2aArsfGwffPh
	9U5IS5IqQfce45vHjEQ+HkDVD+/Z85vr2vkmesvEShSIY0jPcx4M7vv4728cqPOUqmA7YuNMWAg
	CrHeJSkQ4mHf4Y0OMX6fG184z33ZJLdSW03+HLIwPo7tDXWp91BDcMluaV4YGKguF83G+inabDL
	xzw4aYZG74n1FOMFTbQ/AL8abvW6P0u7ZXibcvvpaPInk8TfXPhFEszrdPbX3PdvxYaRwszCoof
	TDLVt5/QkbRHoua++INgNO6pq+X8u84Z6gI/r0NnMxQgw5lSWb4EzD66NJeDXQSWGmGfERnyErd
	kAAkn5C9ltHFg6nsDDEwnbyF7Z2nCJZM4=
X-Received: by 2002:a05:600c:a415:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-488d67bf7abmr46675735e9.1.1775852508197;
        Fri, 10 Apr 2026 13:21:48 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4a46sm65893975e9.4.2026.04.10.13.21.46
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:21:47 -0700 (PDT)
Message-ID: <b3a7cb51-870c-4856-86a9-f8714aa09e6a@gmail.com>
Date: Fri, 10 Apr 2026 22:21:46 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev
Subject: [PATCH] Fix memcpy WARNING in kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Related to https://lore.kernel.org/xenomai/f10afb4e-2aaf-4a3a-8bc7-893c1a09cdd1@siemens.com/T/#t I try my first
patch submit on a mailing list. I hope this is all right.

 From 34d65bcc3343b5323f19cd73561bf39d2652481c Mon Sep 17 00:00:00 2001
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Date: Fri, 10 Apr 2026 21:56:16 +0200
Subject: [PATCH] Fix memcpy WARNING in kernel

Warning was:
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
