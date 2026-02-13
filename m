Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99222332E
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770992479; cv=none; b=FjaMMhh4XINWKTnqa9MFYBKrZmIbdzQ6bpp5vdKpwouT9ZlEaufv/0xiAg7DFM8RX1N7pWovaNhDOxPOMTi9Ju8cLckvk2I+0C/jgzgpRP1DoJ4KVK5119c9GUIW14gRWNEKRwhSxeKIJ1SQ05grCjAJMBp2hTYNWttyXC6lD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770992479; c=relaxed/simple;
	bh=ckSoZXfgqaiu/cS9dn0M9+1Cby0fFNVPxZ4fOuNVogQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFazLvQY66vqHSaBSFMerfJprkSN1/BNDiTSUFXIHVoMQ49cbEu75NY5z+hof4Z7UD6VB1zYmgKaoY4UIF/cxWzYn3Vn0Q4ceCvH5YYsLtAFLGPrrt+Xy4y1APXo6WmXSKvH+9TsVkjZo2CfZpZd0QWIc1DcLdH9GZlwkiKgeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=hLpIMkyT; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="hLpIMkyT"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 280F9581F19
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 14:15:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05CC43EAF2;
	Fri, 13 Feb 2026 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770992123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LhHfP+jQwtUc/M13c+DC3YHc2jKscC9Vta5Us4eHyI=;
	b=hLpIMkyTEAY7NXow0zNsiiwL1VRKCUmtZO0WoQQcZ2OydS7pevXBfpJozEqcWUNetT2+fi
	773Klw6Kb/JmtFIvDDGBZnH3Y5o6yGgP5nQaBe4ASW1pnIvwb/HCcMTvTKMObMmuWqQHXH
	AhfsiuE6r97Ow4xsGzVFxzVSFcQTxOJDZkoZpuesB8NYwYZc3tFRLwiWmcziRwVT9Lh5A4
	VeJeb8GZzhXhPfXklF0icTb60ODt46t7AwmN7kjauztZDFWY7Q5nXu2xzny8h2oh1we0JS
	5cD0XtslhNPhjWe7i23L8VOoOaAIUlzMPKPYCnM140UIyxngjlYS2kXQY5jN6w==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Giulio Moro <giulio@bela.io>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: cobalt-like pthread wrappers for evl
In-Reply-To: <7a955d849a7ec9245543c399ec9673d98ee4d5a3.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 13 Feb 2026 12:50:17 +0100")
References: <8c539987-12ba-912d-f50a-cdaccc2cb7e6@bela.io>
	<7a955d849a7ec9245543c399ec9673d98ee4d5a3.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 13 Feb 2026 15:15:22 +0100
Message-ID: <873434k9vp.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekgeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugeptdehveevgeefgfethfdvpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhiuhhlihhosegsvghlrgdrihhopdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Giulio,
>
> [ Cc + Philippe ]
>
> On Thu, 2026-02-12 at 22:33 -0500, Giulio Moro wrote:
>> Hi there,
>> I have to port a large-ish C application to EVL. The application uses pthread_mutex, pthread_cond etc. Porting it to Xenomai-3 was straightforward, thanks to libcobalt and linker wrapping.
>> 
>> Is there anything similar to that currently available for EVL? Maybe someone's half-tested branch stashed somewhere? Much appreciate any pointers that will save me from starting from scratch.
>
> That topic is most likely stuck in the design phase. Maybe Philippe can
> comment on the current state. The topic was discussed a few times in the
> past but never got traction.
>
> Maybe it's time to revive this topic.
>

POSIX support for evl is indeed brewing in the design phase, which -
good news - is about to be complete. This is not going to be a wrapper
over libevl services, but a full-fledged interface - involving a
dedicated kernel driver calling into the evl core - because we want the
resulting API to comply with the standard.

e.g. the standard states that timeout specs passed to some POSIX
services may not be accessed until such service actually wants to block
the caller. libevl is at odds with this behavior, since it
unconditionally accesses the timespec struct on entry to the call. The
same way, the evl core immediately accesses the uniform timespec
prepared by libevl. Also, libevl shares objects between processes by
opening /dev/evl/* devices, while POSIX relies on shared memory for the
most part. Those kind of things.

So, yes there is going to be a POSIX interface for evl, and this is on
top of my (xenomai) todo list to work on it. However, this won't be
done overnight as you can imagine.

PS: there used to be the opposite wrapper at some point in libevl
called the evl-shim, implementing the evl API over POSIX.

-- 
Philippe.
