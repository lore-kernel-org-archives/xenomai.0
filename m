Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF76FD2
	for <xenomai@lists.linux.dev>; Wed, 12 Apr 2023 17:09:40 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id l18so11561972wrb.9
        for <xenomai@lists.linux.dev>; Wed, 12 Apr 2023 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681319378; x=1683911378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HN3RSuLH1io8thulhotPecmGHfxXIHA7kEbuNdHuCfA=;
        b=gRV5y+UKupK7OwlIWo4Afw/vOKbduTaKLQeKp0kX1YXaeSVizt7VL+sZEC461NYavu
         lbiKLUUQB+7BhoJjfRg9NHzkV3cRtTW2S9Ea3PJ3cpwenxRTE2Zc3Z3MNvL+hNN3JAgL
         y8O9hdXhgrIR5xjet2tbhBbIi98b0liiVbIlzl9PvbgOW59pJRSxf0TEiQLUftN3ON4D
         h/j5AXC1MjQgUjortMU1vn9lHVDJQSFrtyaISyqjfISm4UG4ZaJ3+O3XpcZpQRkYSAe0
         QyiXEiIA3ESchYgpFZPi/LVykKT8qeSpVfHvOO96r5A8fRXIn0VelrUCI32c3eP2nmMl
         CPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319378; x=1683911378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN3RSuLH1io8thulhotPecmGHfxXIHA7kEbuNdHuCfA=;
        b=FoPbJSFBWGvjqPLZyaVaJgsiZuIqCF12wPEOVlT7a5sHQt23cqr3UHMH/xYW24VdHc
         4W4uLDRn+11BhiqPDTFAPpH/zCGpPUubbPALoe8IGUHyFf5dbVAXtloQdjmylhmwZuKJ
         052+KtSqh8eJqZW5s+mLeygtSohytOlVV3+kJeFUil/XQ2sFEREskq5XeDG3BhB4A2TP
         BqzWWBleqFeagHMN/s0IMlqGLT8ISUlvbkwIXwkW2/YUOS2SElxJub991bAQ48lLDf34
         Hjj3eA7BqeFpODcsztBieI8vOZz+HVGE9vAy1S6DFqM+2IRgBRD+WcqQ5io8by1znRFs
         cn8A==
X-Gm-Message-State: AAQBX9eBPy/om8IlNtSujgx8of/QtjQZwPkiBltPXow9z4UXVIlzZr4a
	dmdZgPDArFln6muLc2cMI/IYS+54OGM=
X-Google-Smtp-Source: AKy350bQJESmRYLiPrJg9DpzM6n6sgtjYNEr+Yt6uax4321dz1KPkPC2NHuWC/TzRAED+y6XJI1D0w==
X-Received: by 2002:a5d:554e:0:b0:2f4:b119:5ab4 with SMTP id g14-20020a5d554e000000b002f4b1195ab4mr2065194wrw.48.1681319378409;
        Wed, 12 Apr 2023 10:09:38 -0700 (PDT)
Received: from localhost.localdomain (20.red-88-9-167.dynamicip.rima-tde.net. [88.9.167.20])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b002f2783ba25asm7180509wrr.65.2023.04.12.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:09:38 -0700 (PDT)
From: Dani Sanz <sbrk.modules@gmail.com>
X-Google-Original-From: Dani Sanz <d.sanz@ecler.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Dani Sanz <sbrk.modules@gmail.com>
Subject: [PATCH] spi: bcm2835: fix NULL pointer deref for OOB transfers.
Date: Wed, 12 Apr 2023 19:09:27 +0200
Message-Id: <20230412170927.80793-1-d.sanz@ecler.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dani Sanz <sbrk.modules@gmail.com>

There was a problem when calling ioctl(fd, SPI_IOC_ENABLE_OOB_MODE,
oob_spi_setup) to use spidev in OOB mode after setting up the spidev.

The kernel crashed because on function
bcm2835_spi_start_oob_transfer(struct spi_controller *ctlr, struct
spi_oob_transfer *xfer), it tried to access bs->slv->prepare_cs,
however bs->slv was NULL.

This patch sets the bs->slv value to the correct bcm2835_spidev object
during bcm2835_spi_setup(struct spi_device *spi), so the NULL pointer
dereference that happened later is avoided.

Signed-off-by: Dani Sanz <sbrk.modules@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 2626abfc0a5b..1051482df945 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1244,6 +1244,8 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 
 		spi_set_ctldata(spi, slv);
 
+		bs->slv = slv;
+
 		ret = bcm2835_spi_setup_dma(ctlr, spi, bs, slv);
 		if (ret)
 			goto err_cleanup;
-- 
2.25.1

