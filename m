Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418357;
	b=loVkyVf8hqcA4GKYAgow6ZyN1SUPi0+rMYlX4gNZJAxQT2W4E3hIBiciQgh/Gl2KWx1f
	 DCzvMwYYX2F8wI1sTNzkleYJ9/tV3VwCTpqsTMSwHesBfzkRY8O1IvJaFeqBC1FyAmeBl
	 PMWDooq+mPQDtTorTMf0thLwhWpEXCLnYRfzJqZocCyrYdB9igfpP4XhTbUW2A6+ljjLb
	 ZmHNONuQK9GmowUUfWu6GWC0g1+zzZVIlk+apaMu4CO52JYXmU1YVSuVFlxoz7cdsdaE9
	 I1EQzeUz/YyNa+HjXeOg/RyfyOA4qAXs6dNq2+24OADP69d4KUcTGU72QXY64nxR08A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418357;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=hULeypsyS1lq5Fg4QI7ReOHkMb24ac0KfX8f7idPbA4=;
	b=pFlY5XY0L1sgDRtCNsiM6iPdKdE3BzqnTZrdu4CBgWHp/XNQUWxhMPwbZLepLG6mJp/z
	 JJENxrCBZ5RFvwzUrX/Fe62LNiGZRR8oy8X1d40GAdnoLWl4xD5XT+wBmScsLZPFSZkDt
	 MaI3u0NbbJD+SB6Kq7vk7vq1qjGzMqfRBIRMizvhvBPvT8fBEgo/gFdmbOpsrCZ/nQJnf
	 Lygs4XdQ241ObUItNuLSjDM1JlaFvhuOFru5HRFLZvJXyYleICm0K224Msz4nFd5biigY
	 uGTKxJBXNXq52lmMbTTfC8K7ds43wopMH8bSYeXxnVtCgySD5vds7GlfRTO1nzLUg+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=YXCXztuO;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A5606A33F
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 17:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D70A5606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=YXCXztuO
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C69F3F5AD;
	Wed, 11 Nov 2026 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794418348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hULeypsyS1lq5Fg4QI7ReOHkMb24ac0KfX8f7idPbA4=;
	b=YXCXztuOjB6ekwG1sTrZFw0KnXM7uU7Ikjs+woKVH8ftJAICxMTWxjnj5ya+UXH47UEcpp
	M741PbiWPYkW+09mZA1yO0YGSOQ7r2Si1d9e8HTjnuDrtK/aAC4Zo7m7UI7TqQmI0lzH/n
	77QOMcokgbzV6IfqY2AQtQl4XcWTSEwluOjHHtyjLNoxmiflUcG7FLi1iWG+/Sk9YsWT2t
	Z5bugvst2FJ1nWpyeEaIBwtd1/8CGbXTiRHzMeUgZzmknKdB38JXIf0VnZBaSBUXTUU3ov
	XuJzSsJ6yao3hQQbFX5HBhFm6CNsB2u61Pgus3+iJhszrEg+gqUFu6+C9d8cmA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: O_OOB ABI
In-Reply-To: <18f772e8-118f-46f6-963a-58db46724e24@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Nov 2026 13:18:38 +0100")
References: <18f772e8-118f-46f6-963a-58db46724e24@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 11 Nov 2026 18:32:27 +0100
Message-ID: <87v76346l0.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGEd8gMGEnKeTe1SwjHMAWdF7PRtdq9q/4Z3BG7dPcgDDVWEHnnivDdqb6eLq79lmPBKOu2q3mP4hm7Wd1EIBII3aPKxL03f0UAptjubfSzc83Ce0tgVp/Bd0DZ1bRDiigxOZ5VeIGnNl5g7VeqJ+42t4cuMrIExuVTJYGiRg5GO62nFRaZyuIddu4TdyUqFt92SEiUIs/JZzREKndIbwJ27dEPmXAnh5KPWUKbriqJaU8Nggj1iNq1rI3CsRM9pN4Ovqih5wErT/yYwrgNgGd0cJGaE98IcVY3s6yNMABSaQmKL446yYLo83yimWhi+apagPPCjx3DzBG1Ckn1uO5tXhGsBtavetclSKTcMfpfL9iW0CeWYW6mP4taxIx1uiWDToah76NLDAr0qrMh/NEC7uFroqa67vqTIXIALgxEURE/Snlj7ns71whLfmGnUb0YHybmUvKm0VLno+eyTeitViWU7w7d6Sz2LrzEcws3JN4ChlLh7GLqeVrKOvDB6aNi/QsdDejdYHmnFu1d9MqmPJaxHMX9SVNHofaR+C5mOipDG46jy1xyxVgB+TS5DrWZPvA+8QgeV/HW8nmZq1CAeRrvt38toYOBAe/8K46N5LuLq7DUMBg+UeZDGc4ec7bdIiSkaFBW0eW/w6DkbZ2WpG+4+wD/quUfyOkrM8j7GQ
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> FYI. I assume this is an evl-only topic - if at all:
>
> "O_OOB changed from 010000000000 (1<<30) to (1 << 29) starting with the
> v7.2 port. That changes the userspace ABI compared with 6.18 and =E2=89=
=A47.1."
> (opus-5.5, while reviewing my 6.18 rebase)
>

Correct. Only the evl core enables the oob capability for regular
drivers, which userland may request by setting O_OOB in the open
flags. This is out of scope for cobalt.

--=20
Philippe.
