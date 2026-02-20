Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D81487E9
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599976; cv=none; b=ADIrHDAkqJy1N9lx4+9SwoC3ruLxbTGGyGpg0CrG4yo9ntNo8eJWdtsTFxU5wQnw8OBCiy3jVne1RLTjfc9/jaDdC6WOPVX11kKLEWDVQmNLw0JV3IHghtAxL9uqXGhuQDWENLC6S9bcekHti5iNzoYv3zBkKB5zkeyfW5HRDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599976; c=relaxed/simple;
	bh=bNX67wMcS3Xv3SCQ6hnOdw7QfPZK1y2USyWBW2Uacw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PoI23SegMyO9Qfi5W5hETv7V3qrscjCknbsAcftkTaqIPAgSoLVi4tEro+fm4dxpsmdAV7IDMZlF4oGNR9/Z80sx94aOmiu2Eh/rV9T8+TbZbCTOSSm48r7/F+fzHy7hRYdrH0r7BaupSis4+DmTLeJbQVbdVFml8DK5L0OGoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=F17KhK1b; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="F17KhK1b"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88881443E3;
	Fri, 20 Feb 2026 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771599972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jl5QE3JmBdkkld8xFy0gseFhjx2f4Rd6nKIDnvgw4wQ=;
	b=F17KhK1bLv/hGC7zwvMhjm0eOPHX6EAkh47v416XwXXi3n8aCOelEMk0N0VAkG4RjQwVYo
	cC2Vrkg1YbqiLy72rdEVLHVsiwM1bbYkTh9wwfgwkrlFkKw3dRwDtsiVm6Rgd63IeF39FE
	T9fUmZ1OLESU8CUYxisJdJ6AlN70NjGMbdQlI0LfuE2PGWavVU9sWgQ/Uu7mB0s3u9qxwE
	ySwegkRI+T0UFp8PxeNZhDKkCHEK2f0KeTTVBt3HTbXjaAfH+hU93RAPGXK9cubSIfr07E
	Audv/rN6bePpzs3/2RbMCbONLMblxb/osruPU5NOcD4wGzwi8nGMRdjatQ+4YA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
In-Reply-To: <fdea742b5c4d6d71d7061bd0421981d13b370022.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 20 Feb 2026 12:19:04 +0100")
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
	<87tsvbhigf.fsf@xenomai.org>
	<faebe432-dddb-453a-91d1-77ee48a784ca@siemens.com>
	<87cy1zhdob.fsf@xenomai.org>
	<fdea742b5c4d6d71d7061bd0421981d13b370022.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Feb 2026 16:06:12 +0100
Message-ID: <871pifh2u3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeffffekleffvdfhffejudethedufedtheduffffvdduudejvdehvdehjeejleehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeekkeekkedugeegfefgfedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvk
 hgrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2026-02-20 at 12:12 +0100, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>> > On 20.02.26 10:28, Philippe Gerum wrote:
>> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > 
>> > > > Hi all,
>> > > > 
>> > > > The current time64_t / y2038 support switched libcobalt to time64_t
>> > > > only, removing the interfaces for the native time_t type.
>> > > > 
>> > > > With that series applied both worlds can live together in one libcobalt
>> > > > build which should hopefully increase the backward compatibility a bit.
>> > > > 
>> > > 
>> > > Is this series re-enabling time32 in a way?
>> > > 
>> > 
>> > It's allowing to keep the time32 ABIs around without having to use
>> > --disable-y2038 for configure. It also resolves that we were changing
>> > existing time32-only functions to time64 where glibc actually added a
>> > separate one (see also
>> > https://lore.kernel.org/xenomai/cd03fe98-7237-426d-91c7-c6eae63a617e@siemens.com/T/#u
>> > - which probably needs a rework to align with this series).
>> > 
>> 
>> Ok, so this is merely to keep the legacy applications building over the
>> latest x3 releases as transparently as possible.
>> 
>> x4 is unlikely to support time32 for much longer though. With the
>> upcoming support for a POSIX API, we can't make a pledge for a stable
>> ABI yet - timeouts on syscalls have to be handled differently on the
>> whole user->kernel path in the evl core services, in order to enable
>> some of them for POSIX too. I plan to use this change window for phasing
>> out time32 entirely in the same move, which would simplify the POSIX
>> implementation significantly compared to x3, not to speak of the fact
>> that using time32 for new applications in this day and age would be
>> obviously wrong anyway.
>> 
>
> I see no problem here. If possible - and that seems to be the case - x4
> should not deal with time32 anymore.
>

Yes, moving to time64-only would be straightforward for x4, and would
not even break the ABI. libevl is currently converting time32 requests
to time64 by using bounce buffers for (i)time(r)specs internally, we
only need to drop the latter - which we need to in order to meet a
particular POSIX requirement about deferred timeout handling.

-- 
Philippe.
