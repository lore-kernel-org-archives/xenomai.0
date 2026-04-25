Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51F835BDC9
	for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777127706; cv=none; b=u2u9eMFa2mygeQJjGoRYogRqtX8zK0Y6RBTlWQWPTws+FKnHJTYeSv6oB8VdqFEhHI1R4Yr5Qo5XawaaTW236Z9hNmvx4Gij2tLWBdUum+T5jWPwV2n8y3M972NqQY5ac8ATDE+8EbEF6MlOkQT7wyu9UlH7AjP1ecJaOcmRR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777127706; c=relaxed/simple;
	bh=UFOG1B5PXSxA+SLIFku/E2TqiEWHwKA958hR8RUfU6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=poO2+5MLyamIABd1hLUpS9UX9Dd2diUxn1dxOtGqtevL0XC+v3u+meI2NE6kN3kYfI9XGeq4cAmsIvSTGkmy28itz4d9v3uvYd4WZwQdwc9Pak6ebAd3RcJC4iYP3GYQyd7ZhJ7eM73b99f4a1EvrNKBgLl6ROZwpCUiq7qfFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=PiNOSFlI; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="PiNOSFlI"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 0FBB358009A
	for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 14:22:30 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F5C33EC47;
	Sat, 25 Apr 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1777126941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o28T8Ijz2zSDTGPJF3ONRs8Cbh8gmDd3JibEBOw9oyI=;
	b=PiNOSFlITNrrHXt1oCI1jTOez8MTuNeTzDetlclgn+/IhDW1W6vEvzBy47ZA7GoMygW9/9
	r7h35RpaeMLuTjyk5QHTHmt2L5ZHUqcILuyjh+xuO0imiH9EXzj3ZUONtd959pYUgNVMJM
	CDFUN9JddRxQofij4uziScR5nh/E6M8w6C39+K3Q9NA4Ppf5oFM1+ndd7bwcREdGD6UbqP
	m6bo2ovmZU3jq4aXsCYnoHuSyVnmKJ8/kbVrLOhrussHsj8lwtvy3qNKvUATNpiKxovLVD
	ZRrAissKIXlFCEQVRung6L5M3W9xlUSANEjTA31lAyUV56rUBUtjy3S0pWanmA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jesus Villena <j.villena@ecler.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [EVL] element-visibility BROKEN
In-Reply-To: <AS8PR10MB7731A9654F34FD23F029A58DF9282@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
	(Jesus Villena's message of "Sat, 25 Apr 2026 10:58:13 +0000")
References: <AS8PR10MB7731181CFB7CA13EB3A8C4F7F92B2@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
	<87fr4kqu4b.fsf@xenomai.org>
	<AS8PR10MB7731A9654F34FD23F029A58DF9282@AS8PR10MB7731.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 25 Apr 2026 16:22:16 +0200
Message-ID: <878qabi0h3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGXQKTd8tcFIuPp+4fSvc1wjdx2zGCy/8SedguDxJLaL+ppgeal66Y7p514AajubZBBppLvxFCmnharGgeQar16tOs2YXk8O43CqCjVNb/gAwg3zcVmUyw/T0TsyuMIzVuNz4fbsobk/ED1DWTrQnWC13D2dNuG+TKWaOnJ4TfhU4zToHpWpaal1QARSMxMyBQUzs5I+dZgIaopio9GALQ6hqqndBwlZyfXT3Uv+OSuyB7Q4lLP5DMY5ebicqJZTdBMcPINcoBQWu2kvY4s2smzTitaJG+tiTRhE9sPPwWIJMa8jfVgk7etSFmj/W1G9Uu8Ni8Kch81QeKmpdw87Mt1BgAAVrhqOAcCwAXvgguPB7XVrJuRH6f/JB7zCDB+HYo4ePVrSmjqrWwbbInnwlZ+DRWdDpx68n8C31P1ph8DfSzkkJt99O8QvLuQCgAeSU2bhr0lA0Lwn6KYejRSJnNeLsOZU0gqg7QrVm4g7ORc2+7ffZYmwmM6B34BnBcPshMX6VWfJzCjCTgrULOTr7UQ9JSDZzXs6EYz7JdYxi7n+cTu0DFbDUaBCMXLnHeS6HE0/5bJMf24ZJbDlEFPvbOkKSDbOJppLINGgDe2uLx9cOSmxZOsPAzZQDeYCs909IUCaDtG3dBvBEsI3BsjmnyN4waI6E1el59Y162X2EDN+Q
X-GND-State: clean
X-GND-Score: -100

Jesus Villena <j.villena@ecler.com> writes:

> Sorry Philippe, but I have applied the commit #3ddfd3f and I still get different errors with several consecutive executions of "evl test element-visibility":
>
> / # evl test element-visibility
> element-visibility: OK
> / # evl test element-visibility
> ../libevl-r56/tests/element-visibility.c:89: FAILED: evl_create_observable((0 << 16), "%s", name) (=No such file or directory)
> ** element-visibility: BROKEN
> / # evl test element-visibility
> element-visibility: OK
> / # evl test element-visibility
> element-visibility: OK
> ../libevl-r56/tests/element-visibility.c:50: FAILED: evl_create_sem(&sem, (-1), 0, (0 << 16), "%s", name) (=No such file or directory)
> ** element-visibility: BROKEN
> / # evl test element-visibility
> element-visibility: OK
> / # evl test element-visibility
> element-visibility: OK
> / # evl test element-visibility
> ../libevl-r56/tests/element-visibility.c:89: FAILED: evl_create_observable((0 << 16), "%s", name) (=No such file or directory)
> ** element-visibility: BROKEN

Ok, I need to reproduce this issue since it seems to be caused by some
race. Can you please share the .config file for building the pi4 kernel?

-- 
Philippe.
