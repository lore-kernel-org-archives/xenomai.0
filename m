Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EC34167B
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585934; cv=none; b=dwaxmDYXrwjDQHxnrcytjnoISB4hfxy+m/ZG0QZH7eK943nLBoK2FbM8k+M2YmUycSYu740c8jYv4V3HVDrXVM6pearD+zj3cM403jVTU5Kt34YiTudkGqXY7rxEynsKXvddLX11hn7lmrGyajPr0MNFwMVtq6jBZ/Z29HE6/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585934; c=relaxed/simple;
	bh=JVJ3mTlIE4H8VaqkQcXe21a+fhQWEpjBz189wHJKv9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMbP80UDBRCypeWpgWmjGUqd8gVo/4TaLK3naTO/rMiB6jA3KHQqmmyuMJgQn6mv5b6a1DHGy4GHpZGz1mcZe2YDGcssmdWm8AjPYW0jPMPixpTw4BjlTD4l7j9veGdsthxk40gAPiZwi/jN2KASa7wR0CK8vZTX74a1eW8m9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=DAnCnK+y; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="DAnCnK+y"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A796F43E9C;
	Fri, 20 Feb 2026 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771585924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvNGvK9uV4PxH9ewvuh4cxcGndQ5QLBffLAyhgjlJbY=;
	b=DAnCnK+y5OT2w6an5Ho4F/3VbwObxlwH4P12BLPBNPUWJX0xF5+ori8SDFWqgqE0UxL8Gn
	GOp9WZKkoSgo/7aoPHxByRxZ/lm6VbvQIAPMfuXzdtNmD6rBvMcqzmHSYEf3AYeLNy04SD
	KTPj3uQCXJGfSP91wHM/JZPB8RMpMQpEzVCOl2eI/GEkz80gyHsxoKfqWjKtjQlo7Qx8wX
	pa3TtBD5LBgyKHNYcF9YpM0xte7oH0+8z+0DWma51Idw92GHx7oHlw7iT8X0gjSblUw832
	MsSvQFTG9/iC97GWq1KCFOnX0BQhGJ7D5P3XrNoOEd73hlZ5IFyCSTgiP+QamQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
In-Reply-To: <faebe432-dddb-453a-91d1-77ee48a784ca@siemens.com> (Jan Kiszka's
	message of "Fri, 20 Feb 2026 10:36:52 +0100")
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
	<87tsvbhigf.fsf@xenomai.org>
	<faebe432-dddb-453a-91d1-77ee48a784ca@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Feb 2026 12:12:04 +0100
Message-ID: <87cy1zhdob.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeffffekleffvdfhffejudethedufedtheduffffvdduudejvdehvdehjeejleehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeetjeeliefhgeefgfelvedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepjhgrnhdrkhhishiik
 hgrsehsihgvmhgvnhhsrdgtohhm

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 20.02.26 10:28, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>>> Hi all,
>>>
>>> The current time64_t / y2038 support switched libcobalt to time64_t
>>> only, removing the interfaces for the native time_t type.
>>>
>>> With that series applied both worlds can live together in one libcobalt
>>> build which should hopefully increase the backward compatibility a bit.
>>>
>> 
>> Is this series re-enabling time32 in a way?
>> 
>
> It's allowing to keep the time32 ABIs around without having to use
> --disable-y2038 for configure. It also resolves that we were changing
> existing time32-only functions to time64 where glibc actually added a
> separate one (see also
> https://lore.kernel.org/xenomai/cd03fe98-7237-426d-91c7-c6eae63a617e@siemens.com/T/#u
> - which probably needs a rework to align with this series).
>

Ok, so this is merely to keep the legacy applications building over the
latest x3 releases as transparently as possible.

x4 is unlikely to support time32 for much longer though. With the
upcoming support for a POSIX API, we can't make a pledge for a stable
ABI yet - timeouts on syscalls have to be handled differently on the
whole user->kernel path in the evl core services, in order to enable
some of them for POSIX too. I plan to use this change window for phasing
out time32 entirely in the same move, which would simplify the POSIX
implementation significantly compared to x3, not to speak of the fact
that using time32 for new applications in this day and age would be
obviously wrong anyway.

-- 
Philippe.
