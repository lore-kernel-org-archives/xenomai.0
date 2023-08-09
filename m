Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75319BC2
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 17:05:35 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso36108895e9.1
        for <xenomai@lists.linux.dev>; Wed, 09 Aug 2023 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691600733; x=1692205533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlEyG0wxjBRZI43GRvzm+2L2jmGGxluRbdHj8wfiAEk=;
        b=lghm4T3CQYcRRhrPFVPAiiGEqC0NwOXejukUD9UzOQWwIDAIe+r+3zZANTBcvSobDR
         P9vUTlSCZClvx5lHVlLphYgGkY2P340UEQlifqxsp6YtOHYuM47VaA+4hgYDz7385FO2
         ZBs1cQL//pQpa766KVxUgcqb8RSdItlYhVwShm7VJWNKF8wLeHeb6qCjLrXUWY1tfHuL
         TUaXRrg0wmoHpfUKtftKmGMGqHKKVh7m224Tg9Mphzx0dh5TMw7MF+LRKl5Bvs6VywPt
         ilTCP6IC1mG7AUpNUTgzIw/GGKSMV/ivq9Ey3iJJozQNKXSBVwmWefz+6lk73+ipYziR
         aCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600733; x=1692205533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlEyG0wxjBRZI43GRvzm+2L2jmGGxluRbdHj8wfiAEk=;
        b=UQ9eDdKIiwEdd6UtIAt7Fh31Ay37ZVBI0RTAAOeR+hyoXDKFo5vwIP6imHW9ZDTJhZ
         sVPYSx20YoQTkHeBmtb62aKKHpEAdJho4Q+z6iLJ1/WsdPVYk/+x/7FkNb/bvAyoQxCB
         vn9Fv8W1BpJCfZvi0rCCGINkWMkBzD0kIRKNf0srrInpiJg5iavTu+kISNQuYtoCjabL
         qrwjRdinrUk1m3npOf83M1m4dHAtqgFhRfZO+MBdfsGybuu5f6nW0ASveRiaBTSMfJcE
         Sj+ySgqYSMNVij+2DtlkIPo/2lf3wREd0PRKXaG0KhQTjmigAMSa0pleol2mkeoOhEdv
         ivvA==
X-Gm-Message-State: AOJu0YzmROGDLT3q1d9fL8e1fJW3wBo9ZUUkIOM0urN9UBwG/PAaQa8d
	kxJiv+Xyb2FwJLuQB86qqkM=
X-Google-Smtp-Source: AGHT+IFxtZjY87NrTXwAs9eiq2026TDbywO86pE1QjKXvZ29xhhD2w5x/IUkllAVoR+GlOi9xOk6pg==
X-Received: by 2002:a05:600c:3641:b0:3fe:26bf:6605 with SMTP id y1-20020a05600c364100b003fe26bf6605mr2332064wmq.26.1691600733299;
        Wed, 09 Aug 2023 10:05:33 -0700 (PDT)
Received: from trax.. (207.red-79-144-194.dynamicip.rima-tde.net. [79.144.194.207])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b003fe13c3ece7sm2517583wme.10.2023.08.09.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:05:32 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
To: jorge.ramirez.ortiz@gmail.com,
	xenomai@lists.linux.dev
Subject: [PATCH] evl: increase default number of xbuffers
Date: Wed,  9 Aug 2023 19:05:29 +0200
Message-Id: <20230809170529.3243299-1-jorge.ramirez.ortiz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default case is too limiting. Increasing it to 128 allows clients
such as the Pipewire Multimedia server to operate without additional
tweaks.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
---
 kernel/evl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/evl/Kconfig b/kernel/evl/Kconfig
index a5ce944e9d29..e41aa74be84d 100644
--- a/kernel/evl/Kconfig
+++ b/kernel/evl/Kconfig
@@ -144,7 +144,7 @@ config EVL_NR_CLOCKS
 config EVL_NR_XBUFS
 	int "Maximum number of x-buffers"
 	range 1 16384
-	default 16
+	default 128
 	help
 
 	This value gives the maximum number of x-buffers which can be
-- 
2.34.1

