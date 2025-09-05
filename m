Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE5345721
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072590; cv=none; b=WbowyzNjQtsK7+vYDih/TKiy4M+dHgtHuvYOnArPcTaqB14AGLB2xKHCsTNNa7/D+BuLU0AlIX0iI5PDuTjRCy4dOunXtr1qnPyb4bvxKTqSzn18pNVoH3Ky4Cn4tX/p4bcDifpYTE82/QRQbS1391Gmlv16WyPRx0ZafbgFA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072590; c=relaxed/simple;
	bh=1IcQvhGfWjIvrLzk4ocekMQ5WiHK5XM1gIz4eX5nlNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odHpNxZ3mgLhTPPE5FmomiDD608fKgt73mvMdGGpKs3kuX465peOSHwjfFybCGZLVxhIOvWABiI0WOCmvz5LMmKAmEvOTYVhk8SRi/9+gcTjg1sv6ATBRJYiSIdV/wFsCpEvzVYueZErVTXTqYIcKFAyNBpe0N2JQz30L9PV2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=AE3c5QcF; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="AE3c5QcF"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250905114259fa21c5fba200020747
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 13:42:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=yX8E3/s3HIIlloRB36ekv+NSQUWXjVG8gUMvy6PBbCw=;
 b=AE3c5QcFPF0UdGDifTa3gEbzUoxV92qikOMW9KAeJPnvLTdgALL8w6xh1UaQNa2LdbiuKs
 G58nQEsN4Jau89SbcFo7vYuUZz0PeCVScIs9u2tV8+UDJZ1wqouvuWkXbJ/NcDKx3bJS/TXA
 wJ/noidOotiChYdI7DUSE5sWbOWhppZrlKdmlZdN2DmLednYnSSwSwNveWxKFgxcNoj7CDvv
 Af+G43aE4PmPlDoyO9ziLEFRIDd4HOU/f5DaXURN2ECN8qfcqWSe7wFo11AJpFYmYUFu/dp/
 vMsIt+Ex9M15QctVdl0OSXHUKJHMWVqmdY+YSjel31oq8stdCFmCOV0w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/5] Allow to enable CONFIG_FORTIFY_SOURCE
Date: Fri,  5 Sep 2025 13:42:53 +0200
Message-ID: <cover.1757072578.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

All findings were harmless, so silence them - except for one that was
actually pointing to unneeded code.

Along that, a zombie was found and is now eliminated.

Jan

Jan Kiszka (5):
  drivers/analogy/8255: Drop redundant zeroing of subdevice struct
  drivers/analogy/testing: Kill the loop zombie
  drivers/analogy/testing: Resolve FORTIFY_SOURCE warning
  drivers/net/eepro100: Silence FORTIFY_SOURCE warning
  drivers/net/rtcfg: Resolve FORTIFY_SOURCE warnings

 kernel/drivers/analogy/intel/8255.c          |   3 -
 kernel/drivers/analogy/testing/Makefile      |   2 -
 kernel/drivers/analogy/testing/fake.c        |   6 +-
 kernel/drivers/analogy/testing/loop.c        | 285 -------------------
 kernel/drivers/net/drivers/eepro100.c        |   6 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c |  21 +-
 6 files changed, 22 insertions(+), 301 deletions(-)
 delete mode 100644 kernel/drivers/analogy/testing/loop.c

-- 
2.43.0

