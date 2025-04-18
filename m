Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6151DFFD
	for <xenomai@lists.linux.dev>; Fri, 18 Apr 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967589; cv=none; b=nPuYw/VSLZdkKiWyN9eCM0ZD3ARQ7JOaotVDzv7xcZjUeeNWgV79OIjKIi4dSxmGEelcIVUTZ7UAe+48MitV7ObGDMb4XXSmj12CxkdJSM/ODSpWkdOZDTD2BEdYcvmmZR/LyYsiOHXPAHCwyyGLsb0XYJtPbGTA00L3ep0BhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967589; c=relaxed/simple;
	bh=BhKDuut4Se2IVbVOLwBYV7pTBHlHQaxeZfh2khZ4VKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMwM28NmtqaKVWZnHa40Xd6LbPET+3QSxXp1Ng40cwQL3Bz3RKTUHgpfLTtwtwWHa87sxpZHNhXMe1VL55eJ6KmTUoFV4AQPgY+zESgiUeJRlpTrubdi6t2rEzIHNPtk8AqJGLH462L/0g6emTI6rei8Q+lF9DOoB95bjEG9R2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=G4kBwEx+; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="G4kBwEx+"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3F8A432F5;
	Fri, 18 Apr 2025 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1744967584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xH0gFAw+V6l9yJzjpvg7ohwOEtpwznX6GJ3A5h66oRE=;
	b=G4kBwEx+c+N4QgHCL/NFCFZ1qJX4E5hsmP6oNSLuKoozvao2MThM10lGTFpWHxC/rogD0C
	mFinx+LAUc8DNMp5TCoWAC9y3fPTCUUV9rSeUwHz/BWLsFYfZBt+IqyGbWZK0zzvzGkkJA
	5V9iTLC/1KLnKV5CtWBFpdpPjJ8Li4zC+JVW11qUbxZawKu4fcp81Y/2Pap/UYwr91QSC2
	IsluFU/WGeof2h93Flxp5QQ9fGA+nFDUvXkn2zdraw8Nn5ShuFCWRsp8N8yAkL3+EImsJ8
	cxC9F/U1ogtmk3PPjEtkKuektynONCkVItnXBrZxqA94upK+3pANqbuVwx001g==
From: Philippe Gerum <rpm@xenomai.org>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Zoran KRIVOKUCA
 <zoran.krivokuca@smile.fr>,  xenomai@lists.linux.dev
Subject: Re: [EVL_XENOMAI-4] Consistent Latency Spike at 4s on Isolated CPU
 with EVL (Raspberry Pi 4)
In-Reply-To: <CAFc1U0s_6A0JKMQ+kWL+hCKGG5GcfS9C721u83Kc_qbxbTXMuw@mail.gmail.com>
	(Pierre FICHEUX's message of "Fri, 18 Apr 2025 09:56:07 +0200")
References: <CADjXCUdi2vswJNN8n2BWtPgtXu_ZXDrAD5qTcNNh=ovBmw=-yg@mail.gmail.com>
	<8bc51145-3e99-4b78-87d2-7859f9c35a4b@siemens.com>
	<CAFc1U0s64TakhZUG=ym-oANAnkNsj-L=L2T3pYAtzgEwROtHkg@mail.gmail.com>
	<CAFc1U0s_6A0JKMQ+kWL+hCKGG5GcfS9C721u83Kc_qbxbTXMuw@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 18 Apr 2025 11:12:59 +0200
Message-ID: <87jz7hj0is.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedujeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpefgtdeffffgteejjeefueelveekjeehkefggeetueeljeeggeevgfejtedvieekkeenucffohhmrghinhepvghvlhhprhhojhgvtghtrdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeiiohhrrghnrdhkrhhivhhokhhutggrsehsmhhilhgvrdhfrhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehpihgvrhhrv
 gdrfhhitghhvghugiesshhmihhlvgdrfhhr
X-GND-Sasl: rpm@xenomai.org

Pierre FICHEUX <pierre.ficheux@smile.fr> writes:

> Hi again,
>
> To be honest, I don't really  understand the answer.
> On xenomai 3 we create a thread in the Xenomai domain and we must not
> use Linux syscalls in order to avoid "migrations".
> Is that so different on Xenomai 4 / EVL ?
>

Absolutely zero difference between both. As Jan mentioned already, the
4s delay before the issue is observed is a clear hint that the evl
watchdog triggered, at which point the faulty thread was forcibly bumped
out oob mode to keep the system in a sane state, i.e. avoid complete
lockup.

The watchdog triggers when a rt thread keeps a CPU busy in oob mode
without relinquishing control to the inband kernel for more than 4s (by
default), e.g. sleeping in some way, waiting for a resource to be
available, whatever may cause it to block for a while. This is
transitive: if T1, T2 and T3 are evl/rt threads operating in oob mode,
switching between them on the same CPU without any intervening switch to
the inband mode would cause the watchdog to trigger the same way.  You
may want to confirm that you are indeed facing a watchdog issue by
changing the 4s (default) delay to, e.g. 3s by setting
CONFIG_EVL_WATCHDOG_TIMEOUT to a different value. You may also use
health monitoring capabilities of threads with evl, see the different
ways of catching the EVL_HMDIAG_WATCHDOG event at [1] (i.e. POSIX signal
like x3, or observability which is x4-specific via
evl_set_thread_mode()).

IOW, you need to check your rt loop code for the presence of a
blocking/sleeping state which guarantees that the inband kernel is going
to have some bandwidth to deal with its stuff. This is the normal case,
busy polling indefinitely in rt/oob mode is not.

[1] https://evlproject.org/core/user-api/thread/

-- 
Philippe.
