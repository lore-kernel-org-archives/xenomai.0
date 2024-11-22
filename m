Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C1BA20
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279521; cv=none; b=PaJVXXsIXsDADioLf7LFdUtjPkAbsYek1o4FEIEYKvQdRsvv5SdxlL1quE3WBHB91IW+yI0eGgnp7KhiBg5SD4/+4cBKV24pX9EIGoXEZd6cpq/EyOffV5rWGjBKW1CLOCeUS3UWLPmKcv3MY2MlC4kHwCxbMKABQZSet2YxnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279521; c=relaxed/simple;
	bh=GPTjQ+4I6yRDKuF1KotS+68XfchWb9bvoOJYaLQ7p1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Y2jNYrF/EJjwom4OVmm8lFbVDMgAxvSwKajCaxh77n5kq4rChOIB2BLstY8UxcCkIUDUccuaqf5MfklCx437FkBcdGQKF7ROKfZ0EkASPsmHjK5Y/8YScLKdWLC1NT1b6XPtk5i9OMihy7WMa6oP+XDh+4ELPqmq7PrTF76DtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=UdCrKatc; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="UdCrKatc"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 92A9D10000C
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 12:45:09 +0000 (UTC)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	by spool.mail.gandi.net (Postfix) with ESMTPS id BBE4B7803CD
	for <xenomai@xenomai.org>; Fri, 22 Nov 2024 12:45:08 +0000 (UTC)
Received: by mail-lj1-x241.google.com with SMTP id 38308e7fff4ca-2fb49510250so24807931fa.0
        for <xenomai@xenomai.org>; Fri, 22 Nov 2024 04:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1732279507; x=1732884307; darn=xenomai.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vXAZfxxEevziWd4Ush7vOxf2cEkkk15N18/rnsSpFZ0=;
        b=UdCrKatcs2iptymR4hmantcxyoPM/UnknWs/2iL/iP/5kiUSLi4xvsIu/3NbyA+oO/
         55Kq/qYETFlng/Nxnwyx39aOLngKpGHutTRJTDU+tNx229h09vrn/3PrY+giHFuuuVP7
         q55cJH7oo0J8FqEAyAd6F7ABWq9Vw6ZHSRKGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732279507; x=1732884307;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXAZfxxEevziWd4Ush7vOxf2cEkkk15N18/rnsSpFZ0=;
        b=tsg7DJn0pQxSZRQ9SHZp/aJPu0Nt2lpMVCIT1+8BuMgQfrEV9Myw1u1I1pPzAVW58L
         LlSR8aX0ggDv/6kXRW5IRUyzJnFWyoO12Cih16b9c4wYSepdx8f1oih2NvAiEqJKKsLK
         9DPd5HEDAvyBeFgaVaTIAxBDVr3UAqRfNfFWIS91i5HRATam9wmKIUdE3N9Wsr0Bqhjt
         TVO5VWJbILLQrmdVPIdtwqugbBEjeZipsrwBk8Xsz0c5T+b20M3IEa7aWSRcQUROjv5Q
         ZR0W93OLNcrS33UxDSoXEs9WJOfPuaq/TbDdxex+/PQpfinIV9qRbL0s5+MfHFZC1mS1
         DeIQ==
X-Gm-Message-State: AOJu0YxURqUtA4k5Y1TohoNU9ahK2zi/XpM/4v4QUNrYp6U5dZ6S9JVe
	ZOm0qd/ceIvEJnItxeFccBWDtlKPgn1xP1D5SWjq0922fnuUrZLH9Mn8sHolA/i8/t40eH5gizs
	ByRhf76P3pEP3vsiRLnhH2ffSqp8H8Ue5+7pLl6GvU6ZHlQ74z2853g==
X-Gm-Gg: ASbGncsoFu6O0MWe+mu/KLeZs+00ozUv0bkcDr6wufz0dFhrr3GgTtOio4iW+zcGnq8
	ABmJMElJM9qHipIwxdVV/q/BuEdzCsaiUNp6lwE2Mq81SyQUgQLpNkouD5hyoLasI
X-Google-Smtp-Source: AGHT+IFz3qG4WFr71NyaIa7e8zDI4VRIbGSWPLdIp+eg/4S1s+ggM1KH0fLqWBi2lamTT2hx9F0PzoOdl6dDAmgsj9Y=
X-Received: by 2002:a2e:a80d:0:b0:2fb:5688:55c0 with SMTP id
 38308e7fff4ca-2ffa719788fmr15406011fa.38.1732279507153; Fri, 22 Nov 2024
 04:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 22 Nov 2024 13:44:55 +0100
Message-ID: <CAFc1U0ud_mp1nfZNR9xBML4ddgXo-qAu47=cwtv+GBQ=3kf9WA@mail.gmail.com>
Subject: Xenomai.org + Giltlab
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::241 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

Looks like there is an access problem sometimes...am I wrong ?

Error 502 on the website, very long access to the Gitlab.

regards

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
