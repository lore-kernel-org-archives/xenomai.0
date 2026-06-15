Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC673BE14A
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508965; cv=none; b=HQR4ibz9Aq9j1rilQheBp6jNVttBGntNk6jFfumPtUyLYOdlWREMiGhI326+AzbqmzVPQQBAUwH6x+n86MkgxdPyGMwm8e7ubGos/SvcB4XppI84t1hLjFO9pQIEl9thfm9JG27zxqsuvaKV/n8iqKnN2Zuoc5jeIXDHyBtU9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508965; c=relaxed/simple;
	bh=Hz1kw6MRrAni8eEEUkNfdqCHW/3x7ontw+RhGBpN9aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pg1Ca8MoT9OJczyk/wdHum1g15LprnxiuqN6MB6nWIRiTm2LdPuZSOCu9KDka6g9RyyoalBF0R5HupIQYPvMgGK9DJvKLErGcvVgJItYrcBXjyj5lgG3F9cXwJMP/jS0D5t6nWJSq/Le2ROkgCdlxbcWeoSDqmw1ZeisjGpRFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=XaozpW9S; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="XaozpW9S"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 575AD3F61E;
	Mon, 15 Jun 2026 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781508960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hz1kw6MRrAni8eEEUkNfdqCHW/3x7ontw+RhGBpN9aI=;
	b=XaozpW9SoHyfXpfkKb2BzPRn3I9by1A//UXEwwKBNV5a0ngptJLleN+cI8h2TdC8xrjQYZ
	40YW50KBsQDYUsJuXXFq8tcY/qQY77SnvB8eiH6DS4KLDsBx0BgQAfHqQ/+jy7KG83LzfG
	yzcY1GD27AgKPI7B+ArUi1iD5pNp5n6RDQyg0tAOcpYsDjRIutl5dmp4AYjrlytzEC7n6M
	2pRHTRRK7peUXNFOd3onl5ztAu008+QgDiOWbeHEqSFx7zK/IUk2ZrMzqJsGLhtpWuhx5t
	rrrDqjTHwIiDQuGtxjnSiYNA5YZ9blVsHoD7xgT3lsvDcRTZBuAJUYTxgtoMlQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Quirin Gylstorff
 <quirin.gylstorff@siemens.com>
Subject: Re: Possible Xenomai 3 latency regression on arm64
In-Reply-To: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com> (Jan Kiszka's
	message of "Mon, 15 Jun 2026 07:46:02 +0200")
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 15 Jun 2026 09:35:59 +0200
Message-ID: <87tsr4fe74.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFfRCRI7KzNAVzI+ZddbWzmLEbMNPnDAhkKqg4npc752ML6eosq8isPYpoZVBWl6OXJUFC5sMfBHGvDmz0u0jcwY+izjRMof21EPnrcxZJqjja7STw5os/7pJM+2ai0ItCU92cOuEz0G6XqrSR5Agx6SrqA+GszvBxvxXSvEuIht/MEWlKdSwEijql3+IufZEUtHIxsExayHzfYDzCXN9DfB/F1dq/0owoo+DRzF/6B1/It3nehUlEsBc1LcHJiMubhiydD4LWyf3C0mJnyDXKZSn4XXfUx79fG0pYoBn4a2X/JuYnL435s/+G1cIA/NB6nfj5mUr/HzvK2bi5ml27fDJypd/0q//eR+nZJI3A+gTu8pE6+t0xMRaVynNd448hVwlGwj8qNjhhPn/NP/a4FBjv5bI+sW84zfzWCyP5CHiONFYuVNvG8IoewwJckTH6X5qvQEbxKJptakRqiDdcZ/u7O2OvKYNuFFs0qybX9rP9pf+lsFLNpiUbal0oryKONRVlwdimw1HfcPxiLziR8OxenzQBEQ/wDVpkfQcJRCMgF8AUJDLlUJU0KIEwEHtWXnPu3Ld7aShkB/LdNJbauRG+MMQkZdWm2rkQKeh51VQtrfPbUhsT+YA7NDrd+IfFkN/eaxV2kcwP2ar15cmILKUa5g36P9m6rI9EGkOITsg
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi all,
>
> it seems we got some >10% worst-case latency increase over the last
> month with Xenomai head and 6.12 - that is at least the setup we use in
> our long-running weekly test.
>
> Tonight, the RPi4 test triggered by exceeding the configured limit of
> 150 =C2=B5s [1]. About half a year ago, we were in 130 =C2=B5s range with=
 it [2].
> x86 and beaglebone are apparently not seeing this change.
>

My rpi4 fried. Is the issue visible with x4 as well?

--=20
Philippe.
