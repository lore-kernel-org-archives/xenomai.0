Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7B2745E
	for <xenomai@lists.linux.dev>; Tue, 19 Mar 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868481; cv=none; b=PLr7c4qzHT1AU73MXgxXPXxSUoPXJ/9mJKz+Ri3cvHdQF4jVy8lgbv9XzZCk5B9UH8PFeQw3w0X28XbQHIVZYl5x6ENXYvWBlQxmu6qYo+8FalV/nL9tob+H0AGkdFnq/vaHX2mrtpOPyPZtj8q0TLSELJmq8uuTbGjzu0MiaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868481; c=relaxed/simple;
	bh=KYYei26qtB7WfdGnmtWZaqnUhonXLM2shZ4NWwkDQMo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B4QS5QliA9EEw2pUHzMW4KC9IUOW6gSljSRwhfUWyAxoKjrNsOwVggv2qj6+du0ATdF3EBsHtxiVE8qbrf2RFrhrNeYlcbqJ+oTqJwaXQ0cm5R1/XRYYiohY4q5TPv4H/DSEB0H6sgcfVB7EwNu0EUO6PS/qGRRzOPyt+lRukAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=ECZIDtNb; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="ECZIDtNb"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id EABCD100003
	for <xenomai@lists.linux.dev>; Tue, 19 Mar 2024 17:14:29 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 10E6674003A
	for <xenomai@xenomai.org>; Tue, 19 Mar 2024 17:14:29 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso76682561fa.1
        for <xenomai@xenomai.org>; Tue, 19 Mar 2024 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1710868468; x=1711473268; darn=xenomai.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+eSBnSoZM4/mz5KHW9p+JP0vcgzXywjTMkZWNqJxVwY=;
        b=ECZIDtNbb+P+1jYyDeLpkj3yBKsUZ9OHN7WrFwUNnTUkMudD1SXMYpls/paPBZDsKv
         kbmW3lE+SukUM3es6FNAwPPjEQBLCkdDxZ9bB61WjsWgCOd4iDTm9ewwH8UU+29Pxjoi
         MxZE4GCum+xYh5REApeqEOVA1A8Y0nMioHxUkfaYZujWMCHt1dZflz58RZkh9frGhn45
         WIvxr1AjuuS+aTQLuYfrWIsmhMaC3xYyzQ/gzpqPS/jLEP2DA/lRW41bVUYeMaI0ketq
         XeAX5lma3QeICHRX8lvzpbWvr9dxKYkNj8KKgEuh1950IcVL/3APW1AXiI2KEmxQQ6l+
         tOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868468; x=1711473268;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eSBnSoZM4/mz5KHW9p+JP0vcgzXywjTMkZWNqJxVwY=;
        b=uIxNNZfeumIK9CpWnaXzq6ZhEOa8ppT3WNQ4gjMgtGw5joiJAe4De1c0AP/j4d3Gqu
         TA3laOjIYAUFDBTmY99W54bnTE+oOThtVl0u4mWd411NzBVZ3Bk2K1lldEz7fP4vmOae
         01Y3k+gkjTsysEpl0q+JtE7E18lcd+bRXSC9B4bYR03ZjsZV2yrAsZtYYzdeRtQnXaQk
         wis3cgWbSvyVdd84YdKv4cfrhSISYAj04rI4IVEz1ony3ry3HBs5X2/yyVkMvsZz+uvU
         sHMTLgAnrLVg2rg1cP0UTAq+eXV/fY2Zn6F+m3xQF2aLdYXsNWAW1gbVHwbFux77b+Uo
         bRwg==
X-Gm-Message-State: AOJu0YxJLE+Lo0He3RaaucB8dojDJg4eNiXwkdUqVzNyL95DOJuhL3Y7
	aLvJkKBxHIRu8zaGEJeEyA6fOA+iZ4dxZJxXt9xvofSvdsF6CfKML0/CJxsCX3G3lG8evYewT1g
	wWSkJDm2JWYEsZQ0zeC6m1nxGagBsVDAjlQhXkqSL2eFCsPbyGHE=
X-Google-Smtp-Source: AGHT+IFd22x0mN0Otq6p6NfPWmh8IjhCIxYVCcWSQr/p22YZ0lhIDk6Ljl3mXyzgeFqWioNxQVEejQ2Mg+ltzCmewwc=
X-Received: by 2002:a2e:22c3:0:b0:2d4:764f:8256 with SMTP id
 i186-20020a2e22c3000000b002d4764f8256mr8623427lji.53.1710868467994; Tue, 19
 Mar 2024 10:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 19 Mar 2024 18:14:16 +0100
Message-ID: <CAFc1U0taqtH_iP=f1z6E=Gm91YG4q_2Wosmstygb9wiadThj7Q@mail.gmail.com>
Subject: Detecting migration
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=none) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22f as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

Using the SIGDEBUG signal, is there a way to know the source of the
migration (function name) ?

I did a test with:

nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
backtrace_symbols_fd(bt,nentries,fileno(stdout));

It seems to work (using nm + readelf)   but it's a bit "rough".

Thx a lot.


-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
