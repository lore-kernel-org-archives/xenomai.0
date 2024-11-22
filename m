Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310022075
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281402; cv=none; b=YZEVbjZmlNCMvkmMbnmYrBAsVGxTdo8IDyZXYVBjoq7TXBcGJBOAi7olxoBsmbr1hqVd9kk1gxROD2sEAK7Jx0aJ7vi02XjxOVzmzKT97ajtPZeAnyV+nFBQosPBWGT9JgJXwwzYbMu1abRptgH52gA9FKDv7blB5U6MAqsAIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281402; c=relaxed/simple;
	bh=SbKgFao88q8ZuT4bKL/rv7L3dxtFgKHg7px9F4KeHUg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rZGyoJT3gXrjgl/QbdWJKnjmqYU4FqUoOGrSej2fi4sFKrUk8KZ3c8E5R6bv6w4e66VzLEikhkaCKFfkyI4II/Ii2Az3Q6hJTAscapNiDUZLjR81WiJCykaqY3QXunHm2gmyvaLJsz8iElhrCx5yGJ8iz4fU+AbiIcu7WIq991E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=KlK/WyJM; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="KlK/WyJM"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 0ABBC240006
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:16:38 +0000 (UTC)
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3F64E9417F9
	for <xenomai@xenomai.org>; Fri, 22 Nov 2024 13:16:37 +0000 (UTC)
Received: by mail-lj1-x244.google.com with SMTP id 38308e7fff4ca-2fc968b3545so23643781fa.2
        for <xenomai@xenomai.org>; Fri, 22 Nov 2024 05:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1732281396; x=1732886196; darn=xenomai.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KJeQox9aSDSgv9kVgx8j3WTT1E4EYIH2HJn2hdNWw6U=;
        b=KlK/WyJMdiDpCtIGU57TpGlsns/bCDnHWwkOcDfyv91dGZsHlImJCNZHrFADnkfVeA
         /HO6Ie/1tdy+q/w1JtzvdTYbAbo4WT2JU+6Xfg14okU68wFVA/tVvzpSD6I0M3xC8YK1
         neWx375LMXLx/FiqyIUzCqDM9BXLmaEEz6yFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732281396; x=1732886196;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJeQox9aSDSgv9kVgx8j3WTT1E4EYIH2HJn2hdNWw6U=;
        b=lRRQSkaonkk02/90OsDEiK38ZG9CuCuIFlNi7dAhuwU5HL2sUtjGnWre5zSsup6Uzm
         5MVv4IBZKIxlodoZ/MQc4z3olqb/e185XqnwTVCGH+4To38K2RHghh6eHOEaRr4aj0jL
         /jAjOG42dYhqeXDgOKhdysNO5verSyNa05jannshDilFKcUTgBA4svZEYcGPOdr8/alU
         i04TSj2slVNpsNoetk10devuzQ/OkssmgAEHoDBzz0kRyEVP7PV9B5WmRnfs66mCcKNN
         L2VZeoxUY7n68/GV8n8ZP+u4xc30QS+eBxI0MXxJOWBpYnEv/3DgEFy5Ku0fxHdHfKlq
         WDig==
X-Gm-Message-State: AOJu0Yz+X0kWoyQisIz0zTBadWCSDzs96i/PQqbYxvWUKUrr8of0QN4g
	bccAk43HdXpjpeQZat6KmFIC9MkvoOrv0Vzs1uvZlnz2KN2P9odXjM6qs5GqxZlBPm0XBuFjANU
	6hRXcimxW2GADgCoTWGbNGodCaP+kYY7S+lFHhvUyj9mO0ZqWo2zlb1H5
X-Gm-Gg: ASbGnctIs6nLlScZPPrx8dJtB2TpIX3lNn/s/pKvDrLk1hqNnc44Nyot63vpQM6aVBl
	Zjn0y4pwIRD+jTOJcWIiTNib2+WUA7o4hN92o1Wyrxb23blB62n+p0qsAaSMXdwVT
X-Google-Smtp-Source: AGHT+IHN9KlkvkvnSHTWMJt48ZYj3X9ceX3NGls1HKbgXjhhmBbf4p86Uv6lIzAibpOVp9QtG5FgwjKqiQW3CIIBcEE=
X-Received: by 2002:a05:651c:88c:b0:2fb:382e:4120 with SMTP id
 38308e7fff4ca-2ffa71a2b8amr14748741fa.38.1732281395979; Fri, 22 Nov 2024
 05:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 22 Nov 2024 14:16:25 +0100
Message-ID: <CAFc1U0uhQg4UBLg=qQb7Lvc72FEg5c1hi+s98hjvqGuuS0D27Q@mail.gmail.com>
Subject: LS1046 support
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::244 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

According to NXP documents, the LS1046 is supported by Xenomai.

https://www.nxp.com/docs/en/user-guide/OpenILUG-1.11.pdf

Xenomai features are supported for LS1021A-TSN, LS1043ARDB,
LS1046ARDB, LS1028ARDB, and i.MX6Q SabreSD. More information can be
found at the Xenomai official website: http://xenomai.org/.

I don't see it in the official ports (3 or 4) but I've just read some
discussions on the list talking about layerscape.

https://lore.kernel.org/xenomai/87v8uykfew.fsf@xenomai.org/

What is the current status of the layerscape boards?

Thank

-- 
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
