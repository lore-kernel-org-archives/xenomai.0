Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F218BB89
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103716; cv=none; b=h6p1RanIZ4K9a7NNqusg/tfAcbABUXSb5081ZEHYDXR43IhKanmStyogA1uYRSYjAk1+jCJM/TANbW+q/zKPjfxOdpZ/cNkpSLItqW9dwCj9cXVK3zrvQ+bItpVVugwR4ejWiibILnOOPYifau21bStYLqboYOE0LCL3RB5wI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103716; c=relaxed/simple;
	bh=R12OhD1QXX6+xwr/WlBtS6gDqlNzSl1z+7CGJuvXQrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reqIst0ipnxk5vZ7Tznc9vWAhjI+cXpwgknEbKjxksRbMWuj0frBGWMqo/Zssd7kd2jXrMA6xwncAVE8yFxOUoo6wV9uXP3gG37YWiT28g2mdoTxIaYP48jt1VW69k/xpm//HO7z5rIMMWfnSkdcEwuWKYcLJbPETmYDI9as/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4UT8Ryl; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4UT8Ryl"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71e91ae607aso4577b3a.3
        for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103714; x=1729708514; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46hhCl6RlTcVtaCqXp+Q2JXNb1FB9f53NWP6J01XkP4=;
        b=F4UT8RylsZ/7/nIZaMOqVFTgWKqslY9QaGAB9HGyFIa7gxGvj9m4r18mhIzneaCGdR
         4n7WI0qH3OKoJ4SgDxN/gDI67r1VvkIP/WC1AdzqABGivN7txwyzK5CBfCu03AD1+57g
         60JnHuopPEIej1/JDMHZyRKFCAMkfYBoGyATDJvooKp+X11JSEYylcJ8XSqWaD7kbyZu
         1bhRnxfYYgQecRhLZcZFWL1AJrIO0v4TjHcqWUmwPqUuXYDd+ZdOXJOPedODX6RVHdwr
         C9fQVpCOHomzXcng1t5K4TamfaG3LJxaNAYB+Wazy93XQ9pmS76BREOjjAdCtl1XtPbi
         jdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103714; x=1729708514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46hhCl6RlTcVtaCqXp+Q2JXNb1FB9f53NWP6J01XkP4=;
        b=neb2sWTYzgPmARj4CpCm+9LOCZJvH0qsmwFUd1LYaLWB3MqMzXXl+7JCF4o7J5h9FE
         ejdWkYFC50DhBFhkSrglq/yNKDgdQsc49PtBt4t7Sx+6/CRu94GK0vd3/BGus8XzaoTX
         WuP+ph7X3PjmTtXzck2z9bI1wrV9jaeFPdoj/sQg+hqAR9dOfPCEA5+u/9rvvyYlvURm
         MEeyHAKWpKKOIF48sbGIZP9hqKZYYI36LGu0P8RrVkEacffo95ElLgpIrTsNnP+EefWA
         OegabVuj0twu8eqUKtikCG4VihIvA3QPRVX4giga/dG8onka1mDPrmWE+rAjO5JAljf/
         WLSQ==
X-Gm-Message-State: AOJu0YzG1RmqkanLWjEXKRbkcKhu+8fWhHWM0Nn3noFS0yWLNo7AjcUJ
	Ot2EO36/HYYaHosR6X71d5Y14/m+cJ0HNZ7UWdgmH1FcIHeB8q5Ssp+F85YIUZzRfdsL
X-Google-Smtp-Source: AGHT+IG2r/FRjoLn3cwgXkJ7mrOYgC53dRwR5aDi//Zs2VRqpw//OvtXbt0n1SREG2yvF+tsTj5rDA==
X-Received: by 2002:a05:6a00:3d4f:b0:71d:eb7d:20ed with SMTP id d2e1a72fcca58-71e4c15ea05mr24160282b3a.12.1729103714176;
        Wed, 16 Oct 2024 11:35:14 -0700 (PDT)
Received: from localhost ([38.207.154.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371740sm3391840b3a.40.2024.10.16.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:35:13 -0700 (PDT)
From: Zheng Zhang <lz5333885@gmail.com>
To: xenomai@lists.linux.dev
Cc: Zheng Zhang <lz5333885@gmail.com>
Subject: [PATCH 1/6] dovetail: Add dovetail and irq_pipeline option to Loongarch's Kconfig
Date: Thu, 17 Oct 2024 02:35:00 +0800
Message-ID: <20241016183505.738682-2-lz5333885@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016183505.738682-1-lz5333885@gmail.com>
References: <20241016183505.738682-1-lz5333885@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Zheng Zhang <lz5333885@gmail.com>
---
 arch/loongarch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e14396a2ddcb..11f9a9b73920 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -130,6 +130,8 @@ config LOONGARCH
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_IRQ_PIPELINE
+	select HAVE_DOVETAIL
 	select HAVE_NMI
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
@@ -266,6 +268,7 @@ config AS_HAS_LBT_EXTENSION
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
+source "kernel/Kconfig.dovetail"
 
 choice
 	prompt "Page Table Layout"
-- 
2.47.0

