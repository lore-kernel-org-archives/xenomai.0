Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D839182F
	for <xenomai@lists.linux.dev>; Mon, 22 Jun 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118443; cv=none; b=Zwp2elx/KfgduoHUqnoD+mKkWreZHS0RsRIyg7CV8n2q116gTQhZKC040Uw7RzqVQE7lmWoH22iyGJfCvyZZ6RQhhHNYnMU48LvqsnPxAYlTEo0fUBsrPCwP9AlRj2fTtn6lfzLSLNw/gdYRnRyHJcWX2gVru3ItwZ93gkkhWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118443; c=relaxed/simple;
	bh=8tcgHcuiDb93W5mYt7HlbOR0iYFB+lJCkb+YWtgdObs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9z2lfI9N/Ak4omhkDqAqId/DTXRpM6TXy7Idf2CT91R6VxVOqu2Yh6C00M58k0ZwcVuhvClOlbhC+nltMdiUW/9fklXNnDS0KQ3ViMyhOmwZ+SczLNelqjpUTkUjh5XWHxpL1hCGsDAKNrZnJkYme4QBLLiCFadzbZELTDgP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=L82/SFm5; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="L82/SFm5"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98F823EBBC;
	Mon, 22 Jun 2026 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782118440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tcgHcuiDb93W5mYt7HlbOR0iYFB+lJCkb+YWtgdObs=;
	b=L82/SFm5kUOj/f1g09/dVgphqjYcc9fVE0vXbMPkoOKVXP459xyY9aeWeOA0opVdhpkVfH
	Im1t0pLjcNCxy0HkqrvgF/hX+XIUKCzWoym4k9FCz4fsEaqoSSIxGqHJGjex8YEnLpbOYb
	HHSeTW7tMeFE06WofBTTeonZBtXJh2xC47r1JyKHBmoXdlmYP6lwRVdjHTHaM5Dgbiop3R
	Ey5VNIgNLAjqFrnZh1NDc9jeTdHNG1HxaVV9OUKFAy5+AhZ7T9tTgmUe0KgHnOAOn2CJDr
	yQi2myIKdcNmiNkHlEdWoqH5DbZxyb0ycucaBPXHjmFeSFBFjkiJYoROMVlElA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Xenomai <xenomai@lists.linux.dev>,
  Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: Re: Possible Xenomai 3 latency regression on arm64
In-Reply-To: <6fab68d3def30cfc168e81fc9a4e7334c18ec035.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 22 Jun 2026 09:39:16 +0200")
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
	<87tsr4fe74.fsf@xenomai.org>
	<28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
	<87cxxsfan7.fsf@xenomai.org> <877bnrf3o8.fsf@xenomai.org>
	<6fab68d3def30cfc168e81fc9a4e7334c18ec035.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 22 Jun 2026 10:53:59 +0200
Message-ID: <871pdzez14.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEspW+ShDA+1VJnRQ8CCkPvA0OIqrBS21l7GYGC0nD3Bcj6TAQ2nB90WMhdCUPVrmfXIAFnXieSMVgPsyzyYIIYZJ1hq+Y6L5lTdrSnPYyTXd7QS+ibrmYziGT1B1n7ccwyqDSxHCmOzjDLpAczOtVShAduCE/xk/xrMeN6Sc9i4CTE2eDG70DthLj9UKWWJUUgiFaPDuh68UIn8+ttG2G1V/gD07o+MMsvJmBxe0TR9m0Y+Q8nBhammWNWkue8yjHYKZmnRWE2kvoWXRT+BK1nCI6C31lp7d6PGB0YuryTGsTiZKUBmFRw4vzcsMpXbGBJv/CmT0cWLarIFvO4/j1jbx6t/1+MkT1+L2gZkuMBHl1cqBC7qILdVSd5unAjoEb7nj17hBNCCbouO/Or/kkNTe4IxxvkBHKaOiL41VKWk8un5mlnM/DvvF8WzYc7KokmQvgbgcfnre1ekHMiigZTwlka6ogVsW+PVtv6U8YA5HiSvxBWK48GFau1EScvzo5Jv6MElwqdFeKAY4xOe6eMX6O8MQzNo2U9MKZur303nG4vdlntxyrVvTkdI/LpzC4BlZmI45vIQ3d8Y88cEpyDeLlJqu4rF1PgB8sKIWUfVD/UkijolOEhF9A/qQCfyEDhTf9DpncuFpWttQI/CnCbASY7GvxN7uLuceTRAHQedg
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2026-06-22 at 09:13 +0200, Philippe Gerum wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>>=20
>> > Jan Kiszka <jan.kiszka@siemens.com> writes:
>> >=20
>> > > On 15.06.26 09:35, Philippe Gerum wrote:
>> > > > Jan Kiszka <jan.kiszka@siemens.com> writes:
>> > > >=20
>> > > > > Hi all,
>> > > > >=20
>> > > > > it seems we got some >10% worst-case latency increase over the l=
ast
>> > > > > month with Xenomai head and 6.12 - that is at least the setup we=
 use in
>> > > > > our long-running weekly test.
>> > > > >=20
>> > > > > Tonight, the RPi4 test triggered by exceeding the configured lim=
it of
>> > > > > 150 =C2=B5s [1]. About half a year ago, we were in 130 =C2=B5s r=
ange with it [2].
>> > > > > x86 and beaglebone are apparently not seeing this change.
>> > > > >=20
>> > > >=20
>> > > > My rpi4 fried. Is the issue visible with x4 as well?
>> > > >=20
>> > >=20
>> > > We do not have long-running latency tests for x4 yet, do we, Tobias?
>> > >=20
>> >=20
>> > Ok, I can try this on an odroid c4. Did anyone succeeded in booting a
>> > mainline kernel on pi5? Last time I checked, root-over-nfs was not
>> > possible yet.
>>=20
>> A follow up on the latency issue. I did notice a regression in the
>> latency figures with v4 too, specifically on arm64. The issue was
>> introduced in v6.12.85-cip22-dovetail3-rebase, where vDSO support for
>> oob callers was unexpectedly disabled due to applying 682c4aa14fe6. That
>> change is correct starting from v6.18.y, but should not have been
>> applied to v6.12.y. The bug caused a ~12% increase in the worst-case
>> latency figures on odroid c4.
>>=20
>> With that change reverted, I'm back to normal on c4 with
>> v6.12.90-cip24-dovetail2-rebase. A couple of additional fixes to the
>> generic lib/vdso support went in as well, but those have no effect on
>> latency.
>>=20
>> All dovetail and v4/evl branches have been updated accordingly.
>
> All those changes are not yet part of the 7.1 branches (which have been
> recently rebased to the first 7.1 release). Will you (Philippe) take
> care of integrating that or should I pick it?

If you already merged the latest changes from 7.0 into 7.1 on the fly,
please pick them, otherwise I'll do it.

--=20
Philippe.
