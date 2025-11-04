Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87F16DEB3
	for <xenomai@lists.linux.dev>; Tue,  4 Nov 2025 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244747; cv=none; b=ZBRrPFqwJWCxO7ip+84d6Ggod/F6R+BEpKDVbPUCxUi+jtLekjF9nVZgVjkS9WniOY/aLLIo2k3SeLrwUvZVs3W2vKX0pUQgeyYnqN4f8Blak9uyEAFmU4YH52j7Rlp82npANrwnNY8tjK2hz9ltjBfZWcPgG5ByeCRZrAYDezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244747; c=relaxed/simple;
	bh=l0C1dyjj/7i5tCEssyWnbrk0i6T3tGg7GNOLL2zuUzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQeLwauPuayOyhpJ1qBU3B0/tU6yzV5FVF3dlf6+a1meZBboY7BhTloJT+XWchGnG6gDHkgJvQqxM+jMdInwS+z16Xk9ah5vw+2YYegJTQCJdjo+DheoKS9AwFMrXcSkcfMrUUzKRpOxpIIuBOu+ium09CK062ZDtkonAm/Dndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=G2Zxg2Yt; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="G2Zxg2Yt"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7762E582573
	for <xenomai@lists.linux.dev>; Tue,  4 Nov 2025 08:19:34 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0212144302;
	Tue,  4 Nov 2025 08:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1762244367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDRzMc/Zx6Tr/gdUn7retyBqn7vWSbBI1Nbkp74e/h4=;
	b=G2Zxg2Ytlo29/dmt6z6A1EnIwnh1+drOUJ4pbanR3ew4TT7TCvcaj4L3ZskIOBu16TrpG3
	iqXk6j2MvNrsFo47CQ10udlYxafQq0EeDVJUs3ue1eV7aTpMWVz13n9lH6r0goukumLc3J
	Whu4l2bphdzRptuy0RNd/iylpNCujJyPkui+7cQk9lITjk5Ww52GQF3tpwxAZ13J0RH09s
	cW9uVpbxEdlL0EtccHwysQ8YYlJ+jDMhQB9/0/B34VfQKqFMjZ0Kj7qjnJ9JfqB/vlg3R3
	cHkfoSDjbzKLQv9CsFJqtP8iEOTnF9tsGHEu5EAZjZIvPV8/2I7TmW7xEO0hxg==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>
Cc: Giulio Moro <giulio@bela.io>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <20251104085329.3bfa97f9@wsk> (=?utf-8?Q?=22=C5=81ukasz?=
 Majewski"'s message of
	"Tue, 4 Nov 2025 08:53:29 +0100")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org> <20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org> <20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk> <875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk> <20251030132602.2d1ccfcc@wsk>
	<87qzukuzy5.fsf@xenomai.org> <20251031165615.2c9f72f5@wsk>
	<87bjlnc9u5.fsf@xenomai.org> <20251101165957.12432bf4@wsk>
	<58fcd922-3a50-74c5-bfee-01cbcb7e1e6d@bela.io>
	<87cy5znrc1.fsf@xenomai.org> <20251104085329.3bfa97f9@wsk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 04 Nov 2025 09:19:22 +0100
Message-ID: <87v7jq43cl.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedthedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepveegudejhedtheeihfelfeffleffleeitdelgfelhfduhedvtdeljeekteeghefhnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehgihhulhhiohessggvlhgrrdhiohdprhgtphhtthhopehluhhkmhgrsehnrggslhgruggvvhdrtghomh
X-GND-Sasl: rpm@xenomai.org


Hi =C5=81ukasz,

=C5=81ukasz Majewski <lukma@nabladev.com> writes:

> Hi Philippe,
>
>> Giulio Moro <giulio@bela.io> writes:
>>=20
>> > Hi everyone,
>> >=20=20
>> >> CONFIG_COMPACTION=3Dn - it also automatically set CONFIG_MIGRATION=3Dn
>> >>  From the Kconfig dependencies CONFIG_MIGRATION=3Dn -> !PREEMPT_RT
>> >> [=3Dn]
>> >> (i.e. it can be only enabled when PREEMPT_RT is NOT)
>> >> I've just set CONFIG_COMPACTION=3Dn (which also disabled the
>> >> CONFIG_MIGRATION) and now I cannot reproduce the issue on my setup
>> >> (i.e. v6.6.) anymore.
>> >> It looks like those (enabled by default) config options have
>> >> slipped in
>> >> silently and introduced the issue...
>> >>=20=20=20
>> >
>> > I can confirm disabling CONFIG_COMPACTION and CONFIG_MIGRATION
>> > fixed the issue for me as well. Fun fact is that I started looking
>> > over these options when I first raised the issue, but then realised
>> > that evl check did not flag them as problematic, giving me a false
>> > sense of security ... Without knowing much about the internals, in
>> > hindsight it makes perfect sense that the process was more likely
>> > to fail early on in the lifteime of the process and/or of the
>> > kernel than after it had been running for a long time: once the
>> > memory layout has settled, it's unlikely it will get moved again.
>> >
>> > By the way, I was thinking that replacing an in-menuconfig warning
>> > (a la Xenomai-3) would be nice to have, instead of having to
>> > manually run evl check on the config file.=20=20
>>=20
>> Actually, we want both. Some automated configuration process may not
>> give us any hint loud enough, a runtime check is always welcome,
>> especially when providing support.
>>=20
>
> IMHO, it would be enough if we would have:
>
> 1. evl check complaining loudly about CONFIG_COMPACTION=3Dy and
> CONFIG_MIGRATION=3Dy
>
> 2. Just adjust Kconfig to have:
> CONFIG_MIGRATION if !DOVETAIL

Unfortunately, CONFIG_MIGRATION is required via the CONFIG_CMA
dependency for some platforms such as i.MX with Vivante GPUs.  In this
case, we have to enable this feature, restricting page migration to
well-identified runtime phases. We might try to add per-{arch, platform}
conditionals in order to narrow the scope, but this might be a fragile
solution.

--=20
Philippe.
