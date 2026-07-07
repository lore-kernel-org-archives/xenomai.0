Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC241D4ED
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431283; cv=none; b=C4OQ1MAVsQJS5mWPIz0vr1UBtKopuj0quxATT0s1BnuZ4lhZL+phtm6PoPVgS6qaM7cD3rEbHKJlQmYiU3juM1hY0YGcCpzvfmthgjfzIJkTDb854GETcvwRHJ4s3cjMcQaI7ES3EewhVjj4BGAf2SFiAriFW7mkVXfOJKnIVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431283; c=relaxed/simple;
	bh=SF7ONEM+svfUX5/lOp3B+Zz81j/GlP5bThcfMOg7eug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iomSYNbmK2Fn58z7wA/ZJcMKLzI3JVejNf+4BvTtIl+pUn1oUsBLsjfN1dY0svUE4q7kNco5xxUPkpitCzaGjPdmavKOprk7l8ROhu4nI3jM0eFUkv/PZwIFAuWwmwir9T5d39KUHXoTEj8F1jyjZiDU4AeqAfZsu04+6UeRbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fGBO/OUy; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fGBO/OUy"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C58B3ED35;
	Tue,  7 Jul 2026 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783431274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufp5//1WZCqKAuEgSltthD68s8UO3FRGQ96NjxQMlEc=;
	b=fGBO/OUyFwJoIdaHMZOQ9M8UMaOALxyui9xDWwnD9ql4zL+5ajHx8mqknfzztdmHP5AYgj
	zBrdErVUCSK/i7DfYqa3mMOtZqo0D3EhtT6Y68RCSjyS6ZHGcVbhPZOPiAMho5zW5jAcSS
	JdOVYxwIN7Uiku0S97wNKixFW+Hpd7mXt49Fv1sWkVImiG6PYzpxvdss0yrGtCm0G7IKRX
	sj9Pj+p5OSial+9wa92eQx1nrdAUFITawwuGRFO5fJb2AuacyXvz2w5ZyjKoIWmXaL2ldv
	nnAWH7CxaOjhxaWbe5GckYUskENahraYSHjgHpmGeOQzfve0+okkxmKis4vaeQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: hectic test fails when to many CPUs are available
In-Reply-To: <2a2e5b00-ef70-4de5-865b-c8d00c87104b@gmail.com> (Hannes
	Diethelm's message of "Tue, 7 Jul 2026 13:43:15 +0200")
References: <2a2e5b00-ef70-4de5-865b-c8d00c87104b@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 07 Jul 2026 15:34:28 +0200
Message-ID: <87h5max6sb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEFspW0RpFWqxVXSdoOR66PI4361yTUO4c/dpxff9rQusM3bkqvfL57j8jhLlSpYyv/JqrYb3EDb4rHU9sgch7AHcOmdxsazyY/vhWJ5wg3hOvzjEEDEMp7otQkn0UOkqBmCfq16e1VJaCtBpvmY28t50q3VlU0spw2nEldN3hkFvOeECRFdDxDiIY4/V4QlMvToeBvB2rUH897bP+eC4G3F6wkUy6m8etYUuf/p+/IF00fKbC8/99P7XF+AwYHC16zpnE213hdVYSOgxb/N73mr1Tou1/dTv+BMpreWTNojRnBEkzmnh+uS87P+0fvtAue/zjSXW+pRmt8Pnb/82PotEcMWUVwp5Vwthxy9S6/aU+KTWpjiVlekpk+EBCzN3FP8R9llpNWNLyfXwvDkQyHQnpPQ0fmvhgk47L+9EtP1NC64160ahNxhcUqNAJA7zzREjZN9Iol5JshwwOIxdKh0tUzMmn+lRMND2QRjeBNYpEBiVVYc8erCzqVGc5TGtHYVofyIrZ9fh9/nfF87+tf5+O1mCEXH4b8L6wn3qvIPwjHuP7F6zi8GAE+PezQL3eEVZf0Q9UhmeY4aE5ET2yWPtYQvvfApp52AMZ+qPrvDOG8K7bUZjX+QxOraIFQvds++oBFqW+xYaMpsMM99SzZ0LRMUsYmSvfEzoOmX2MGzg
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Hello
>
> This is the reason for the patch for evl-test. I guess a beginners mistake / edge case but
> if you want to look into it:
>
> If I don't set evl.oobcpus in my VM or just use to many OOB CPUs, the hectic test crashes and
> never exits. I have to use kill -9 to stop it.
>
> evl_attach(): Resource temporarily unavailable: This is probably not handled correctly.
>
> evl.oobcpus=0-15 -> Freeze
> evl.oobcpus=1-15 -> Freeze
> evl.oobcpus=2-15 -> Ok
>
> /usr/libexec/evl/tests/hectic -T 5
>
> rtus_ufps11-10 rtuo11-11 rtuo11-12 rtuo_ufpp11-13 rtuo_ufpp11-14
> rtuo_ufps11-15 rtuo_ufps11-16 rtuo_ufpp_ufps11-17 rtuo_ufpp_ufps11-18
> fpu_stress_ufps11-19 switcher_ufps12-0 rtk12-1 rtk12-2 rtup12-3
> revl_attach(): Resource temporarily unavailable
>

Mm, ok. This one is indeed an old and obscure issue which has never been
cared of. Increasing CONFIG_EVL_COREMEM_SIZE and CONFIG_EVL_NR_THREADS
in order to account for the massive amount of threads involved in large
CPU configurations should fix it.

At any rate, the test should unwind and exit cleanly when that fails,
so there is still this issue to solve at some point.

-- 
Philippe.
