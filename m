Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81302F3C1A
	for <xenomai@lists.linux.dev>; Mon, 27 Oct 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564922; cv=none; b=AQzkWI9fvF9Fd9OWSLkZg+sPhjBnV3khK0Z3SuuKfDqp2J6YnNox/KqkWi3plZSWByj3735CbMdBDkLfxB5+J9rXLIYQw5P+VviPS/wtlamP9tJUZvNSn6B/EbvtSfhlkNaGA+/fjAIaGZ79KYsj+1TrRLaNt1xaPUjOGFOzCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564922; c=relaxed/simple;
	bh=L40yrkHIaWxIFVC6xrrI4w8uqkUQ+2JJI3FSkRM/D7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blyEpxLJwwxOSjOrAXUHZQiac8UfJHJ37Ph6GHavJIUEE2A7aBixIye3wpBfYgzxO5McMoEjDcqRdAm99SHWpLjkhyJWNNCesN59OPyLWhuFGIrwBgz57D40qd4JADJGgzT3K99K+ilpWAOMvxaoKzjBWw2JfIw92xdE5akyHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=TXW5rHf2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="TXW5rHf2"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BECC43B29;
	Mon, 27 Oct 2025 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761564912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L40yrkHIaWxIFVC6xrrI4w8uqkUQ+2JJI3FSkRM/D7s=;
	b=TXW5rHf2BkGgyDc4Z5qWuUJajsOx5hqSTJJYxMl9yaDU/Rch3jIsCBMaHYsUcWJ9Y9BZ6K
	+35FW2Ac9ukiniWi9ieQyHsjUdyoX7WdJRt4byusQZh7TM9nYzpOG3ZbO47jCFOtRCkCrg
	sOoxa3/D7/IUxIUuwJqaCxekQCzkBO5pz15OtQq3bk4IgpUTGv2f8ig+igIwfrM7Uqwu8s
	CQSd09kPTP5zqNy4MzbRLBxua7wOKoEyi8XxDJVE9r5do3UxF2j/jcZ4FqNwiUPCuqoDjs
	LVipb7QeGCtLUaPSp7EFivT9IUSyPM43jHCIlJazEvp7Zpn4+EnFn3SsnUfRwA==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>
Cc: Giulio Moro <giulio@bela.io>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <20251027120535.7933c720@wsk> (=?utf-8?Q?=22=C5=81ukasz?=
 Majewski"'s message of
	"Mon, 27 Oct 2025 12:05:35 +0100")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org> <20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org> <20251027120535.7933c720@wsk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 27 Oct 2025 12:35:07 +0100
Message-ID: <87h5vk7f2s.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepveegudejhedtheeihfelfeffleffleeitdelgfelhfduhedvtdeljeekteeghefhnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehgihhulhhiohessggvlhgrrdhiohdprhgtphhtthhopehluhhkmhgrsehnrggslhgruggvvhdrtghomh
X-GND-Sasl: rpm@xenomai.org

=C5=81ukasz Majewski <lukma@nabladev.com> writes:

>
> For the record. Both Xenomai3 and Xenomai4 have been run on the
> identical hardware.
>
> On Xenomai3 there are no issues...
>

Dovetail deals with those things, and this layer is shared between
xenomai3 and xenomai4. So the situation is still unclear.

>> so either some
>> traces are missing,
>
> I will check if I can add more tracing.
>
>> or something happens at hardware level which the
>> kernel does not know about, as it may be seen on x86 with some
>> uncooperative BIOS (e.g. SMIs, thermal events come to mind).
>
> IIRC - Giulio reported the issue on some ARM system...
>

Yes, but he also reported that he could observe the same issue on
xenomai3/cobalt as well. So we cannot rule out two distinct issues just
yet.

--=20
Philippe.
