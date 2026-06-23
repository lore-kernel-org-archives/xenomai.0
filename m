Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEC1D4606
	for <xenomai@lists.linux.dev>; Tue, 23 Jun 2026 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217864; cv=none; b=q5aA9Siju87J8QJtQxuxAdutuGa4uS8K7cdZ4PyImp9Q3z4lUW4a/vFfHnCNKh0m6bSiRmBXWEEiBGWgy+j9lfBeGfN8TWum8mprqGI8ABtcdu9wGdTb7Z4slCfkpR9bv8v7vBii+qRJLkxpdeZ6SqDRunYs0tyKR4Msh6LyycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217864; c=relaxed/simple;
	bh=PRke1B60FhmmcvXLNhcAa5izmzp5A7PloJWcTFW26CQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XlH586QngGnf9Rz+Z9w6BgZC/5kQFfQx5afrGDpy7zHJIUq8iQKBBFOH914PJBHwEIvefo8SUFxR6JcdG0c5I9IhZHdyOff7omNyk6uTgmbMx7oKizqZ50tcCFAAfNrt8uj7LM/vBi8/dtcH28iONtix+s5kAOEb7bb91hI2kjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=HNdLYyZd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="HNdLYyZd"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87F023EB86;
	Tue, 23 Jun 2026 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782217855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mN0g5Z8PcefjCm/XFvhyC42780jsU49IrjPdMjDwX7E=;
	b=HNdLYyZdtqOYZ6mrHJH3Ectl0ylr/poc94JfSgfch8DHL8+w4fNnkhXR6mepArpmggCgzI
	cGKX05IjAg2fFeBuePQuTic/RscpnKnlCWS7HlD3SNUc6oiq0BoD+jlujdgpz0FVFAF44U
	/weSeyH9g4kk3HkZi/7GFNySSCCj1fQbgl0gVPIg40vcYuMpkvr4bB04vS8a50iHb5t+W6
	9dycGk2NoqBA0QTmuEwZUfQzzeMgFMwTd8Tnfcm8fyJQQPApFGfjUfMkVsoOrBhF8hKwHw
	SyvBxFvKQrPwseYB1T44ppg9yYgHrawxZ+LL989QD1GlSNHNnsRGRsKEIBuGhw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: EVL 7.1 and below on armhf: System hang when running the
 testsuite under stress
In-Reply-To: <87v7b9e9if.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	23 Jun 2026 14:17:28 +0200")
References: <32c49c1fb7fa18b0cbb206198b67bc6cf0c7452b.camel@siemens.com>
	<87v7bbdj7d.fsf@xenomai.org>
	<ac2a054ac1e75c91efcde7f68821f4150f8d200a.camel@siemens.com>
	<87v7b9e9if.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 23 Jun 2026 14:30:54 +0200
Message-ID: <87pl1he8w1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGuAg9NBFygDqsoXV5CVlkoZypg2clMmiJXo6Ulrk7BNdv2BdLLRn3Fa8BHHv9bqsCJWPPUwdA6BlRZIVrVKGTs8C2hT0+1rGaT0yKJnEfBX5o4cetOkD0zR2pnEu7nd2fZV0+1S+5Ck+KfVrJ6r4k3CmyXsvprrcLiwILYss76A2x2gXJBcezWOq7H7T0kTVf6OjqM+T5asmYIufOEV0qI0jCnhiWdqWwGz1mYIIEqC2XLNK7JETHizlxizv2Hqlvye34/VOFnynRutJthPSaZ6Xc0MAokVxGZQhEaOjftL5fd9KjPXR6TNclOr7mGHY2856enmb/S1G+B5bBNDBZVHrM2izyL7eKRRtb88h4UHyZmxw4A1eIamweTwhY0nwjreQ8T7c3BnQg4IRQhwp83W/Mj7Am/lL4YltNq7hylUQ716hlZprG1tV9PgkENKuzJjS1M+lbFOIz7SxAxRAVxpsDR/fs3wWG5UgZKmbcs7fw0EyvPUjEfuzlVZsOcngNRyaluIohjKyuzajFkN1uXr86ConhkxKO4+Bl3cyqeaKfh4obX48tHK01N+BgCgGp+V4X5uSE0G30J/qfxEWSAiwmNVLd81i463h20zpcRMClyoHOz2iDvL7tgabXH7nJTcDZ4oShrwy+02nyFwDdiVtQjIA8zrpHOmd/mtSmWrQ
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>>> 
>>> Since r58, we have the running_on_vm() predicate available to test code,
>>> which checks whether the "EVL_ON_VM" environment variable is set to
>>> 1/y/yes/Y/YES (unfortunately, I'm not aware of any way to detect this
>>> without user input like the valgrind vm allows via some hypercall).
>>
>> systemd-detect-virt implements a couple of mechanisms to detect a lot of
>> different hypervisors. Could we depend on it?
>>
>
> Yes, running_on_vm() could try this source if present, falling back to
> the envvar method if not.

Actually, having evl-test feed EVL_ON_VM would be better. This way we
could still control the vm detection by setting EVL_ON_VM as desired
before running the test manually (i.e. without evl-test). I'm preparing
a patch for this.

-- 
Philippe.
