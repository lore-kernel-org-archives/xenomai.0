Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1651E3DD3
	for <xenomai@lists.linux.dev>; Fri, 31 Jan 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338149; cv=none; b=ZzkAySlUy6snk2nBiVCWMUXePONMlcPVD2O8J1fAJTKXwWDaZbdcuTZ2ozUQEm7l+2+U5td+wYI7/b58G70gZTEDghQCdSCHg+gq0KxGfvGqhlckuWH4RyG9KJIz/9PVdh18zzS+VIHnorkCthhm2HpmxxL9ApAK8jYy3Psuz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338149; c=relaxed/simple;
	bh=VUNOQBlMHmSJJR4qPh4K8d9U3X1Fb44tUEx04xK4Wj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XY5cVRfnowtWVAPINWkuxAWqEWVMH9F0YxPMGjLadD9UkZT5NM6Tc6rWXnia3hLgJYVFP3DJ0QJbvGULkT70Iddt1Y+flRxZj2cOLSFauMa7hplaB/MhP7UCholg3HQcfk+Az6glrT0aaFp1NLc0lihlyAVEvBn62fQbAuG66bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=g7687/Qe; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="g7687/Qe"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250131154216b1c30f648ae661c736
        for <xenomai@lists.linux.dev>;
        Fri, 31 Jan 2025 16:42:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iDtp0UW+52mXPQ4RbuFlxW7VhNn19HjL9YHLr4eh30o=;
 b=g7687/Qeec4BXFM5WMcCR+k1ZzAA9fJ2Q2pCV0DF2BNjzMWFc45Rk6OoLTX2tdQBeqURnf
 Dt3zdFCKQFH3tFxNxS0Wjne9Iuyi8n0ylwMcic0YZmml4EYbmRx2n0QeKESi3EtV5ftEDwu5
 gDK9sNuMvw+fzT5SaYerpL/yS/Arh2xAXjcH7sd1xp+6ZkJRyK3CVT4nyKjAigwrKc5E3yak
 RNbVax52G9nRgrMl03tBg2RUFp1Tw30ZU5vqrUNkfFW/Kman3nPqSPKx2zeUcN8ml/O8O8sk
 uzEIlvfDATRi1qY8n4f1YsJw8Fpvj/aB+7doRcsGlz+O3SlCWLpocmGA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC] migrate to syscall(): Measurement results
Date: Fri, 31 Jan 2025 16:42:00 +0100
Message-Id: <20250131154200.1221616-2-florian.bezdeka@siemens.com>
In-Reply-To: <20250131154200.1221616-1-florian.bezdeka@siemens.com>
References: <68d9f583-59de-4bbf-8ea2-af8ece427495@siemens.com>
 <20250131154200.1221616-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

here are the measurement results, comparing v2 of the patch series with
Xenomai next branch.

All measurement runs were executed for 6h on the boards mentioned
below.

The second line (per arch/board) shows the results of a measurement where
only the userspace (so libcobalt) changes were applied, while the kernel
(cobalt) modifications were missing.

Versions:
  Xenomai:
    next: Xenomai next branch with the "measurement patch" applied
      v2: v2 of the patch series + "measurement patch" applied
  Kernel: all measurments with Dovtail 6.12
     
Boards:
   armhf: Beagle bone black
   arm64: Hikey 
  x86_64: Siemens IPC 227E

The numbers (need more than 80 characters...):

       +-- execution time of the injected syscall  --+
       |                                             |
 Arch      min    min     avg    avg       max     max          latency                latency
          next     v2    next     v2      next      v2           next                    v2

 armhf   2.875  3.125   5.347  6.251    16.625  34.125    17.884/ 43.247/ 98.016  18.086/ 44.097/102.018
                3.083          6.065            37.625                            17.889/ 44.425/ 99.143

 arm64   0.833  0.833   2.575  2.716    40.000  48.334     4.306/ 15.240/220.732   4.957/ 14.216/217.138
                0.833          2.703            47.500                             4.620/ 15.515/210.081

 x86_64  1.104  1.308   1.356  1.577     7.116  12.396     5.274/  8.498/ 41.115   5.654/  9.015/ 43.380
                1.272          1.555            10.801                             5.609/  8.902/ 45.061

Best regards,
Florian
