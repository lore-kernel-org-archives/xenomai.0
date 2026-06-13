Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0A383C8F
	for <xenomai@lists.linux.dev>; Sat, 13 Jun 2026 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372643; cv=none; b=VMgUGbO2y9ZYDMMz+6mQKjM8GkwlT/ed9/jkxwgLdVKrpKjBuZgwZuwC/I/bBCHRlPN5cTj52tsB0lQZyx8bBwsV0AHDpTIFitjvQzvx2lhnx7q3kz04Y1IVEbSZN+jrOnHighfdKvBdRNqarQCMc4mXeKNI/6jadZQDc+rVIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372643; c=relaxed/simple;
	bh=joBqFo4AVTfgC8bX3xHn7OnlQBnYhgv2mY+Ei4woQE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKNW+cbJd+XGmnU6GAaKu8JivwHmjLcFJVUwRBx7Iry8YEOPpVnoO2EWhKDE+mTbVWv0nX6yQSnabpiszzfV1dbY/zAcqlajlbyid7Tp41ElhGUXi2q8GG6A6dz7JDcw4v4NKhlqZcdjNbV4ar9Gfv+W+61TvNsLB4QRXQ8VPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MZ/y8Jwf; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MZ/y8Jwf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CAD953E98F;
	Sat, 13 Jun 2026 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781372634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLlBYsbJPlh89G8PWazemzM4oA9rMgdQzQLrRkzZhNc=;
	b=MZ/y8JwfRvRrN5d3l+3ywZG6A/gYq1FTm38fRAkJ/hVduHcCr3XlXCGR5kVdv3MGa/Zt6U
	YMs8xmEg0GYNfA6KxK6exOQSxpkt+XpTCSx9jC9Bp/B3Tc8G34rqO2WMNwW/LzvRgjZWQi
	UfXbwwkfgDQByatfvSNw2rAmZfUCtStgNzfi536eSmOECUVArqFU/TwzDOI8ZTelHQzbB/
	ak9RKffdJPiNAMjwrheD/EH5MW1MoSjBxzpWy240CLSBfZBrbRGcs4fyPKdTqm/LjT3qyj
	Kmw8mQw9ifMH89u4DAynLsrKxUwm45fuqf0oD3BZ6e6uT4J3pYc7PJEHtvTrbQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Call trap exit code with hard IRQs disabled
In-Reply-To: <874ij6tleh.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
	(Philippe Gerum's message of "Sat, 13 Jun 2026 19:12:06 +0200")
References: <20260612211719.3054905-1-florian.bezdeka@siemens.com>
	<874ij6tleh.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 13 Jun 2026 19:43:45 +0200
Message-ID: <87bjdexrn2.fsf@2a02-842b-4100-f601-1469-181b-22db-b4d0.rev.sfr.net>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTG4enVlCHNXb9wufMarb2D7x4STEWS7WSW7PLmBP0dFRkdjn8lghsDy3a1++YfDBNZC1LigzPiZhdXcZV9nds3Gs6CApIVtkcdJajxI3Nk9YELp8doNMXxCbWBq3PkqHjUKcHcc2Sf0YCFUvy7LKeE+2BsSCkhs4QQ4OitpycN3cD/do/KtDZ3SO98D7sP29c3ZbDsF4s+RntuQNJjXwqNpWi23HktyH8iKAbS9xKifDkqcq25gwLryICA3e1TYg66k8UeCZTy0eLW7SROakHhwN/vFqTGSCfijRkp4BW0F1dBAw51SmscoWKDrdifD5sEU/Txeo5BipbbdovChmt/MdpkZ+0M2AbCzkLgH98GZ0Owo8Rg+up5s5mjzOtH/eUSxPZTDAhrzNXFsIwP1WwZ1vaBACmzc3QTPWM5bBZBvC7QihkosyULgIVICTRg9ox/VxmIecsaqPM7YJEtxD27MRE5RWxhD/kBhX6f4M99J0nDK3L1kVssCQG3i8cpS+DLzNNLoCNN2X/PFKr2/ZopFSB3mu8NLjpNlx7RqouLfmUIx+5Gs6Wv95UPr2nNhxgdoQKdPMPw2o6K0NwP4VVP78x9oBYcJa7ZLbrm2ANz9/Q4CEXZjclZVVzglmmfRE1976lGSdgNhNf6n4j2VnfIavUF/u3AyYJYztOz2aCrG/g
X-GND-State: clean

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> mark_trap_exit() should do the reverse operations of mark_trap_entry()
>> keeping ordering in mind. Especially as oob_trap_unwind() is expecting
>> hard IRQs to be off.
>>
>
> oob_trap_unwind() does not require irqs to be disabled,
> __oob_trap_unwind() already takes care of this. However, we do want
> oob_trap_unwind() to return with irqs off unconditionally because
> handle_oob_trap_exit() might not ensure this. So the original ordering
> is right.

A better fix may be to disable hard irqs right before leaving
__oob_trap_unwind(), instead of expecting handle_oob_trap_exit() - which
is user-provided - to do so. This would make things clearer, and the
conditional disabling in mark_trap_exit() pointless.

-- 
Philippe.
