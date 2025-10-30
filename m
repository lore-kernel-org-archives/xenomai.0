Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B93683A4
	for <xenomai@lists.linux.dev>; Thu, 30 Oct 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841615; cv=none; b=t1D/B8kFG2EHI7ci9GAVpw3IUxCyJgpV6kPG8VsnLr7akFQspjruan4d7fu6d6X8t7/1WS8heoVmSuhRIOKaXEh++Lg5UmVu6DDeuwxjgE1VWfrgJr2fGJFVsXpkaZrAMRD/Hwixe7kq4Rfw2gmS9lUh5+9ihznyCCsH6ivsJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841615; c=relaxed/simple;
	bh=1AoYta74xiclGsLTKIX58gk5VTBM1O/yna2P4yCdkRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSQdDrWqg4LZuPwLlH/SV23eAj30QwIKETfQeret4e99ehWgf842L15HHm8AAApQgX+aI3iGCw85Kfm1ljlOfUaw12UmZ3ShJcI4MqlDVLZ/k+T0Ydrxgw9W0kxTy72VtKaWImLUq6aIslx7Pmw4PhMOZ8TUwMJ9q1Zf5BAS4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=omyHAlyB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="omyHAlyB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89CBE4435C;
	Thu, 30 Oct 2025 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1761841605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOFkn56gOrpoOJ2VHFGwJT9z3gjifti61z6IZ3q73/w=;
	b=omyHAlyBmFv+rpPh7/d1Ff3djA6UXPHNEWq8dnopmznTPlJtuLbuh1Rt1Bs2UJCXllq71m
	uKBQWy1h/8J7LqUTP23PLvSfa9BxbVVKbjYAFL8pq7zYGWT9ken0Zs4oZ0M7rsFQLzrt+a
	1zZl7zaQdspQusK3RjZYfYAr4UEEzHJ6MjRw8hHyW8Z7FMh2Q/DGmIAs2WnMj5guZC9plb
	FqEh1x3cIQ8/+CZvOuIrDRBaTbFCC4T1v09HIjnjYiuc/aojnGga5OXEJzXQmCNHlhf5DM
	pNl+BCkgbGR1HOcETvmB0eKbZBMZ+yn3tgrjhk1lO15quyrteUn9lH4c2EtihA==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>
Cc: Giulio Moro <giulio@bela.io>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
In-Reply-To: <20251030132602.2d1ccfcc@wsk> (=?utf-8?Q?=22=C5=81ukasz?=
 Majewski"'s message of
	"Thu, 30 Oct 2025 13:26:02 +0100")
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org> <20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org> <20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk> <875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk> <20251030132602.2d1ccfcc@wsk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 30 Oct 2025 17:26:44 +0100
Message-ID: <87ldksuzi3.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepveegudejhedtheeihfelfeffleffleeitdelgfelhfduhedvtdeljeekteeghefhnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehgihhulhhiohessggvlhgrrdhiohdprhgtphhtthhopehluhhkmhgrsehnrggslhgruggvvhdrtghomh
X-GND-Sasl: rpm@xenomai.org

=C5=81ukasz Majewski <lukma@nabladev.com> writes:

>
> <idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
> latmus_pulse_handler at 128.467208 (delay: 739 us, 195206 cycles)
>
> Why there is such increase in "delay" (253 vs 739 us) ?

This is the delay until the next timer tick in an absolute timeline,
therefore the larger the value, the lesser time we consumed to handle
the last tick prior to programming the next one (e.g. 128.466214s +
253us =3D 128.466467s). The time consumed is still huge for this class of
hardware, but ftrace + memory stressing do explain this.

--=20
Philippe.
