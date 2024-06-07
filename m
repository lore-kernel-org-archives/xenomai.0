Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16E2F37
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717728058; cv=none; b=K5z9dy+rYqTyzbekyWVOMsrQRkoait0BcKEI1sVStSJafpsGcP4lG0wWrnDL5liUv1bO1A4b85Yby5qBohxtxfBmP+yAaGE+uuooKRHafwGdQBW4tg0WqC4E+FV02Y5T2U8Jd5ueHPCO/Y0j7FIh8dtpNTsyeczmt7r/iLcBBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717728058; c=relaxed/simple;
	bh=0fkAF/YOA3OyhkaAjRYsOjyxwD0NSOD3eEjPAGwKA/8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=YYMPCIQmYX6Nu68zMC+jCWciwnF9AiTfbitGDyydKqsdfh0bYWYa233yWcVEby2Pxk1fffw6Lo4qZ4BDsQfOufAEZS6eZGUlWtmFuqFi+El3aKtJL1wEAzSdSAQWfTGJZD9oxU3B4azPTGj9wk+pZzG+F6uVSaXovaTEpdyIlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7qp94K/; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7qp94K/"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f952906314so584125a34.0
        for <xenomai@lists.linux.dev>; Thu, 06 Jun 2024 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717728056; x=1718332856; darn=lists.linux.dev;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0fkAF/YOA3OyhkaAjRYsOjyxwD0NSOD3eEjPAGwKA/8=;
        b=e7qp94K/NSEJusx9TJkEzn72vabT8CFl6lIvkFMgRhbK9mHYeGyQeFxZU4KE2LedJn
         9UUfeRzBlH9MOgzcnTr1ito8Ws48zg/x5Xv9yR/vb4PT1D3960akHHQGmR+RYLAcZSii
         8da+Nit8PMvMZv41Ha/vwudEOolzTj+1y5HPH3wkkgXccUYjcXj9UKy8xlm9MdWNtHHw
         KzNQqiwFR4AHZgokfCWnm/RioobqCeWDAEHPsLGjcLFKvm+vsEDwpTlO8CdxSVHJClZy
         eJwjqr90D1YKJ2F8eCmcenkIhml+xBYUQkBADmpL6SbgbFtzpXBnjkVBddg/V1mwHAgv
         8f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717728056; x=1718332856;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fkAF/YOA3OyhkaAjRYsOjyxwD0NSOD3eEjPAGwKA/8=;
        b=Gcqm/MTubGQhqJmQigb60rv+RdlDtdmlmTvXuJElqBCDAI4cDw7WsFQVT5uho1caho
         8h0rfFuHpxvmeOP6+58VuIfAPxSV4dMs4ScKSBqAUYarNq4HFvu+4Ys7/kUdu/GwoUYg
         oT/JPshKBaWS5tDo/tMmNTxAw3h7cQRKXgH8+8GckdB+dzw5yMA6t4DdgaY0cRAmuhoH
         mgYrg06abwlULRPUrEIU9WCZz6+91fA4yX+5jTl8WR/OuqBEQaamnQxbsnmGDrztWGVr
         2UlSZdbvrEsNuJrhOUBtTyQM+BI7MElc4ifPLOCgYqNlfS1rup9PGUkU9XXECQi86n16
         DPug==
X-Gm-Message-State: AOJu0YyOgwUNnO/9v2EPU8WppMsw9BAPbnPmWPKdR0yUKG+Q/T4pbFpD
	xWSLGGVeJraE7jkK6XSaT9oICXekQr9F9ti1lF+NEUlWAFg/Qy+8ggNN+w3n
X-Google-Smtp-Source: AGHT+IGmlR+SEZmU7W6xBOOCFTUMbHtzY+tRaCt5F3eBkdzPoCJB7A+KCN1+w1ZP0E5m/PKXc4n3Vg==
X-Received: by 2002:a05:6358:9394:b0:18d:8ef1:e77c with SMTP id e5c5f4694b2df-19f1fed8b50mr194788355d.15.1717728055915;
        Thu, 06 Jun 2024 19:40:55 -0700 (PDT)
Received: from smtpclient.apple ([45.8.220.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de200849acsm1776851a12.6.2024.06.06.19.40.54
        for <xenomai@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2024 19:40:55 -0700 (PDT)
From: YinJie LI <liyinjie0418@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Dovetail/Xenomai 3: kernel config CONFIG_XENO_OPT_REGISTRY_NRSLOTS
Message-Id: <BBCC5A52-C147-4CC7-9BD2-CD0185382EE8@gmail.com>
Date: Fri, 7 Jun 2024 10:40:41 +0800
To: xenomai@lists.linux.dev
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi all,

What is the maximum value of the kernel option =
CONFIG_XENO_OPT_REGISTRY_NRSLOTS?

When I set more than 30,000, Linux failed to start.=
