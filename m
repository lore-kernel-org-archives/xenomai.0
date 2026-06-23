Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3F41C72
	for <xenomai@lists.linux.dev>; Tue, 23 Jun 2026 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217058; cv=none; b=B2TzsBoQeuhBU2HBc/QB3Fol8CFkoKWHXTAD+1dAlY2Hgai66qYrgXQtXxxmV1xUl3w8uodHRSjXXC6UzX+kJ0cEmFH8W8IHSHyabnKMSBw1GGQ0jHexjmNvH16954Vta8uoD6N1ZEJU4lLSoMItOoK99GJ9GirW088eSBzNpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217058; c=relaxed/simple;
	bh=0GddXCRag0gSyIVx+o+QbnLFH42c5kuxePJbraMN0vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJqukRJxhWjYcGoxbzPn76TRrMKsWOwxQVGMNB4fKtKKMzeLelfB4rpPLp82GJMMEbrSx4VX+mxOj8fjX02XPtoFsWSME0+Fp6LrW3Jv+L9UmWo+umz2roxOL7QjycC9xiaVcfPrMKI78B+r5cy5dZjVU08GVdXsa58j7Ml61Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=UBL9ccbk; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="UBL9ccbk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39B0F3F443;
	Tue, 23 Jun 2026 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1782217053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ro66gRmnTFWfCVASBta8KZg1ZxU4kpcw26AVNW7VjKo=;
	b=UBL9ccbkhJbv/RHNRdHkRYsBQTdRsg+EFhC1kjaVb2sZjlYHBEy5OlEZsYtO9gMbqL8PQ4
	LSGx0Y6xAvApyIkPwvcQxVODcqPkjDU/vP3+m4TWZF2cVQsBOjm89E+IyGjN8vM03MwkIi
	8icyvJCYJ+0JwJ62VsEbtyHhPTUDM3AIP/ijx2U6c9zljnVw6c1XujGwPQ4YJtmucODhDt
	9DpP/TBGCIc4QGEhaQgMHBozVeLG3Ku2rarVVvkaM3cyk+Psj9waS0I76t82z1c3ubXNuB
	h1UTDcQ4SlejC8qvAFEPEHxV9U1eDsYkJgX4GsK0DfIEfBneLZGZXdi/c3ymXg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>,  Tobias
 Schaffner <tobias.schaffner@siemens.com>
Subject: Re: EVL 7.1 and below on armhf: System hang when running the
 testsuite under stress
In-Reply-To: <ac2a054ac1e75c91efcde7f68821f4150f8d200a.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 23 Jun 2026 00:30:37 +0200")
References: <32c49c1fb7fa18b0cbb206198b67bc6cf0c7452b.camel@siemens.com>
	<87v7bbdj7d.fsf@xenomai.org>
	<ac2a054ac1e75c91efcde7f68821f4150f8d200a.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 23 Jun 2026 14:17:28 +0200
Message-ID: <87v7b9e9if.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTER7YjcTvM1N+71GzJFI56QoazT2UDRAH1kgVKOMfwTr7z98yIw4WQUgxe4foC8OZ/ulbDdPTF6MqubimumHkYZK7d8B5zo9L72AMX+wtMWv7nN+/YNs+AketuIPxIeS/Gdiqb5uK4lUvsXAYBwxNqMvZS09tqGFM/JjEhbYlEvUriAnSHY8i6SY0407mCkN2xwhtXBvmHGRRPmfGL5IdzyLy1rvpX5V2ePUEoBMM8pRLB0g1XffiTfBwxK0EdVUD/RDBJufJN4OuZ5Uc9V85pEJAKsfibxbe7redpdQbiqlkqV1b/PAwdZRnEYpw3ARN5d97MgFAfVwbCNey327gHCa0jL7kG202AcbQ9LTuY/c2i6QN1OoI3uZ2S3y6fMepBxWjHdO0+T793CASb5eVhGp2B0u1tXt/j1BVJ9KBnGRekQusL8MuAsoatOWCOZWPHGPDM/bPwIjKrGbRd1MFzv6JpyrM4VPSprU51oxIpHQII1nMnschSmMSMaopLbpNM5gebcgv2Cikyrmok6Ak53WW6XkkctFyeFnnAvqmEkJG93gaOySOU/8QrlxfMUgP0LC4idiQPKqHtGDd6Vt1rnCbiau0J2iHLmvdArU+U+res84xZRUZWyRu/exJxUDhivke/J5BOI/mx+y0Ji3HZhr69ooeG4lm2SVkpzXk9mcA

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

>> 
>> Since r58, we have the running_on_vm() predicate available to test code,
>> which checks whether the "EVL_ON_VM" environment variable is set to
>> 1/y/yes/Y/YES (unfortunately, I'm not aware of any way to detect this
>> without user input like the valgrind vm allows via some hypercall).
>
> systemd-detect-virt implements a couple of mechanisms to detect a lot of
> different hypervisors. Could we depend on it?
>

Yes, running_on_vm() could try this source if present, falling back to
the envvar method if not.

-- 
Philippe.
