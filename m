Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C1863B
	for <xenomai@lists.linux.dev>; Tue, 19 Sep 2023 13:23:57 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 0C88580004
	for <xenomai@lists.linux.dev>; Tue, 19 Sep 2023 13:23:50 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by spool.mail.gandi.net (Postfix) with ESMTPS id ECA7FAC1109
	for <xenomai@xenomai.org>; Tue, 19 Sep 2023 13:23:48 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so32840211fa.3
        for <xenomai@xenomai.org>; Tue, 19 Sep 2023 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1695129828; x=1695734628; darn=xenomai.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TWzjN3EXFCdWTG0r0wyKwM70BnRxprYk8+JRngpCdCQ=;
        b=RlMyB5rze+sZBH7pTsXwooL/97N2APdt9PAkaxcg9jygnpDjkAu4k/hDs57ekLJ3c8
         Cfe9dx272KzVdfJHbDbYS0d1Gb3FVvDSnY1WYzdDyZeoA7pEP7D1iRcGuLuEHBY5aLob
         XtkJxrbMaV9ZE1XUOKI+MIG+SRvpuR56+oWwANgu8ACoBpJltj5/AOWKSZatDWsev/jj
         d0UhvAHGL3BLrhkYmAAch9lX27HYmKXmBH5QXDqP6Nt+45F/0HoIHABRzItZZU7fnCYS
         OLzO2LTZg6yfdaRgsy3Y1hEl7jY6zq4a2Vh5kBV7mAWn4ScWI6HVMioRDqGufo4cTU4g
         LHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129828; x=1695734628;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWzjN3EXFCdWTG0r0wyKwM70BnRxprYk8+JRngpCdCQ=;
        b=NDl1EcfknTTz+mtbKbdN8jSRulRwhqYbSJ+kERa8t4Spf/nTJH/E/qlbct0bxRZw6t
         VsOsj3MQV4jrTkvAmH5pcKSPy1ltAg40mZFrp7C5dhxSV+XJJjkxOUaR7Z2y+EHIXA4i
         6DUXkOmX/FwIsJ2gjPRHsedJdu551DVOT686CAsSHA1IPDpvAx+STQ+MHgPjsv2lDOrL
         KHE5pwWmHPJTJqYLQT66y9LDNrKZaVwU2DbwG5Vgvje26Ly/2IgsS1i+bl21YL7HaDyp
         FVCIGsl279AE9bBipPTI7kIjrKUU+Tb9iAZvxcjxPmDFNMe9L6rxkAwoZLcJkf/S9kCC
         ioUQ==
X-Gm-Message-State: AOJu0YzvyjyaXFytfSArc9nlGWqAJaCG3RYikYArR0QhqHzQrvTIPifx
	fbVnxCoc56G1qV087ONED61fqrIFOcAGeyTkK11XMpdxloyXvMFPUv4=
X-Google-Smtp-Source: AGHT+IEMXfHIe9U9LvmfKOBlRZ70sijZ6CDAw1aMybrvx1EWpAV49zzdU1lEXFERD6JFTS5AIAknGdxxSUkDkNHRcNc=
X-Received: by 2002:a2e:9655:0:b0:2be:5c58:cfa0 with SMTP id
 z21-20020a2e9655000000b002be5c58cfa0mr10389964ljh.11.1695129827794; Tue, 19
 Sep 2023 06:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 19 Sep 2023 15:23:37 +0200
Message-ID: <CAFc1U0sNjB52q=9pNQ_G6o6R07GJTPJtYZs-AHh9Oe0PVXkzwQ@mail.gmail.com>
Subject: Xenomai.org download access broken ?
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22f as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi all,

It looks like the xenomai.org download links  used in the wiki page are broken.
 (https://source.denx.de/Xenomai/xenomai/-/wikis/home).

https://xenomai.org/downloads/ipipe
https://xenomai.org/gitlab/ipipe-arm
...

Thank by advance

Regards

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
