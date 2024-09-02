Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2517DFE7
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273458; cv=none; b=Qo4PaZq4+Z89D0SobJubBYL4A/5b7jFcTIVMEJ3az99wC8Tz2Qiq3/yHmMLXDn/leKqPbMPDbvOyh1mcTyVm7lGnfa3kHpgdgBL1axMpSixO0y7W/KN3zIX+02mwP9HmPgRi6dfd3APpXsbrUwtbSvL6FenzRFV28AhqqDmY9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273458; c=relaxed/simple;
	bh=HUp7Bjn/YGm8Iu9C1CqCm6SzGpaciqzxpg1A/PSM5t8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SoejUmV1gVh4m6fqYBIxNEGCHpl8zF833rwhvY76NxRWxiUoCleKXjMEPvgTiD9NcUWQkFxENmwCWT7zDx1o9YJT8LFrUqqSVEKTqc329SscQCb94TR6jmwIEQ3xF1EI0nNnpZtx4F45W1ykXMtzIfEOM1/lJTw+hq1VElO30nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=qYSVZEL/; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="qYSVZEL/"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 4C8A6100004
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 10:37:28 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 80865AC0FD2
	for <xenomai@xenomai.org>; Mon,  2 Sep 2024 10:37:27 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-42bbbff40bbso24997675e9.2
        for <xenomai@xenomai.org>; Mon, 02 Sep 2024 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1725273447; x=1725878247; darn=xenomai.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zIUxI4nmThI/kRxtnEZ5hYmuLfEJ9v6Pk8MWo1gfVeQ=;
        b=qYSVZEL/tM0D+heL8p6KqzW+aeW1+S7IwI/KZuKQkN4sulfFYOZ4I6IHRCcWemg2Au
         xYj+lpeiglLof26YfwEKJSbpl9AvOBFxKQYN+p21Yxd6BajY3WqK8D+p35OLjDaNmWs2
         0nmA0SIhbojfOEAB0g4D+sRrkJU2zXxZ0MyTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273447; x=1725878247;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIUxI4nmThI/kRxtnEZ5hYmuLfEJ9v6Pk8MWo1gfVeQ=;
        b=TkpR0ChTB2DJ8L1QKkrvfBUNtrSdRkJXJhYKswzgPy1eruPoCL5wtR5vX/AwjALh7O
         vVqXe95hLrq6ZcjKPELNbeZ0FvvF4xR3/1fjwJ9d7hIVhjczLpPeOgO1WcpwcRXnt6Ol
         1/mgJOHw0ztQ2C7RcloVg2MPRhcwzkrqmg7hQBpHJmJ+n3Vz1CmW6u5I5jg4ExxGmIgD
         +n5ZFGTsWJUAPRLgadxPlVd759ImaN+/saUO4UhT/qxzKYon7UWcrO0Udwo3csSmV4sV
         g/pAB0keTO4QJNMWj9H6jLEp2Fnz3lsZq7wCW2XKf4Hkq/biHXE4qtPNiUVUStDDBmtq
         l3fg==
X-Gm-Message-State: AOJu0YwOjTcYlxhNHRV1NrK6WSjNbwaNmxCspHTltrI+wSgwsQBkCjFI
	XiSNtUMp5k+HaEhD17V6l7TQiDBL8MpcI3DGa6ICWBm9ISbjmIH9QRNadZTUeMNmgNNmxdP8d4P
	wjq1/ofghJ3VfnQMd4kwWnXxbBs4l+JkMsaQZoKcSS6haRqa0
X-Google-Smtp-Source: AGHT+IESK+E1/bflY138DGJAMcwOMqbQFalDDoPQMX8hi2+k8wY3ECsUo2xwa+GtRy+p7ExibpneMZ/gpAcKBY8XoTk=
X-Received: by 2002:a05:651c:508:b0:2f3:ecdd:2b8d with SMTP id
 38308e7fff4ca-2f61e03a5b3mr74099021fa.16.1725273090153; Mon, 02 Sep 2024
 03:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 2 Sep 2024 12:31:19 +0200
Message-ID: <CAFc1U0vFRz4E11z7v+kL=_E8NsNJvAsXvc3qmHBSzpnKzNfpug@mail.gmail.com>
Subject: xenomai-images for Xilinx SoC (ZCU102, Ultrascale+)
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::32f as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

I would like to use xenomai-images as a demonstrator for a ZCU102 board.

I didn't see any support for it but I think it could be possible to
add it. Is there any documentation available ?

Thx by advance

-- 

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
