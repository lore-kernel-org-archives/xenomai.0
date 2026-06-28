Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735D32D7FA
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782661227; cv=none; b=iiTjD+yYiXzgkVv1tetmf9ZlMgf4lL+UUOFa26mQatl8OFgDp7lq7s3rrBeyAdpiBd12w3jQeQahbK5NznfapD1FZurN0VYyJpx72VGgYTVeJ4q6kdAvp6Yt7DIWYMyQnaxFOXpnZKrE8/iEPUGBGEG4BI3DXwIwhHXW2gnNnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782661227; c=relaxed/simple;
	bh=EkPEuL+3RpFZfohVkbt4AnUWefLSAleaHkdSKvhNtDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYRFWtFKlhq5LXCO8BEcRMW2tTEhaXFdIy/7YavBfOI4OVq9cNCks7oKQ74WiKoAxNqQGJ6sDhtyGCpElJETcX4zisJZZPV+vVQXgyDBQ51KM0yAoJE4MK1AlDJM3adJvDfcG2MBkgSa3ejsGsjQC4wu70LZYZW3py8P9Whmwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huNn8Uu8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huNn8Uu8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17892855e9.1
        for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782661224; x=1783266024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AvgDZZ+GDipc7FDAhddnF6bPccRiFdVQ6+nDrCKvPps=;
        b=huNn8Uu8XGp3eBH+L4ijtE8cHZ6iq74iOnqJI2N6wSvloYGKj71DI0Qym1CfR8asi9
         TkRuvJ5C5DtaOfQEOOopdWHdDjeZUAp9SvWDrY99I711JpMV2+JImgIDf2cqMmlsTrPt
         liCF0mSOsA9A5aUtDVWCFiEWwjadcfAmhTZb0iqjX913j5GYZ1XAUfpghdaZPxj9UzeO
         cfxCyBDg5QxWCDjKSvBlFf7pFtesMe8dm2QdUxfcqUQxjnjnWudeREGNMirNU2nSlzV2
         o0+rgN9ZE1mzNoS3/HLlajV4sZrQH+WKL/ShekZOtgFirfbwdv/cPSlOqEi2FF4Gxp14
         zY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782661224; x=1783266024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvgDZZ+GDipc7FDAhddnF6bPccRiFdVQ6+nDrCKvPps=;
        b=WtTWekG5TR/IEDH0c877R1bYGY6oFZpmGcR0bFg8QNvdFtIoVNrQayxPc8LpUABd77
         L3VyFfe0dime1mbJh9SePsHwGIUztmE8jHJ9ujV3wyJPN4Lyb5khsHMEYTiOCn6yQXv/
         VY4e1qpweq2//v2X9GvItadrpjHvFCLnMNWK4fJntW5N6UAunm040xWPiyHwgO6X7MLF
         ju4EKo55YjqMqCaUgBKDeGT2uEXAjlb9YqiQT2dr7PAfdvNWue9XLkBoN5mxp7bK/TKY
         xS9mc+8SpNPtw43OHiaVbMZvElWbQKxy8ZpNDP8S9hZCIWvhw9creBVTDT5yt+xavwJF
         O+Qw==
X-Gm-Message-State: AOJu0YyX2kKCpWil2F99Y6Bo0TPAaJQaZLhpRYGW5pdYyQI4cmFTj1or
	BBHCaNf1I4HTWBHlMRo8Op4v0kAE0e4orUuG2B/adCc/zlyvvDgkq/mlRo3XoQ==
X-Gm-Gg: AfdE7ckTfv5YyCL6IreHEfcyq1vEpV+9KqQSTWCvQ518wegsMJHtG0AkNsROHJDa6OO
	rfhw6ddvKphVROKAS/jxsrXYTMtrB5HPiWkumo6c2cArgewactUXz/HpDF83zWwUtzKmK05IgFY
	heYFg7+W2NkqaJQ+ymWbYUsAWIRrwoN6N5tLHnqiOEhAVojZksE1v01gQCQ0uxofM28swD6rdAy
	Mg8l60r2dnk9sLnDubVDjk9QIVFPzHmctNhc7Yr2jl6D/+RAMmZ1G6kvQU1Z2OtY7BoawBFOiDr
	ZbUZreMnGivbBTigJJh6rLU0yQX1TC75YgVWy7tfqAkf5DA/UT1cvSmP98Nl8woBRgg7sISbugC
	Ok4SMKLzAC2FMyr5if0bh0AxW5KkFu8/n71mB2vyZ5dwCDuBnEJ7CY8iELMNAeI/7+d5bEKl16k
	yZ8/8CX5jrxol2BPOr61WPFy3cVg==
X-Received: by 2002:a05:600c:8b53:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-49266864977mr207361985e9.14.1782661224151;
        Sun, 28 Jun 2026 08:40:24 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-473dddcb295sm144870f8f.35.2026.06.28.08.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 08:40:23 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 0/1] tidbits: net-ping: add ping tidbit using raw socket
Date: Sun, 28 Jun 2026 17:39:55 +0200
Message-ID: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is the result from experimenting with evl networking. I use it to do basic
connection tests from the out of band network and check the timing.

It is a bit complex due to evl doesn't support IPPROTO_ICMP sockets.

Using the in-band network stack, you can use: sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
and then only send the icmp part of the message. However, such a support is not really needed,
it works fine without.

Hannes Diethelm (1):
  tidbits: net-ping: add ping tidbit using raw socket

 tidbits/meson.build    |   6 +
 tidbits/oob-net-ping.c | 480 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 486 insertions(+)
 create mode 100644 tidbits/oob-net-ping.c

-- 
2.47.3

