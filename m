Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FE145355
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105104; cv=none; b=BL+aBmn4ZksC3zzsmmfQC8P8wbfxrDmazSXx4yNdUK6bNMosCmKFl50l+fIIo+VCimTOqybL7N1xrT4gCDFur0xbQKj0rufH1VMoi3D1BXN9H6t8cncijsRakAhthamYnXE1USH8KBpJC9SKF9hRz2/rRGd1FCZ/5lDfT9k3x8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105104; c=relaxed/simple;
	bh=vzNp3QFD5c5MNSaOz/rHRdWr/iIKfoYJmtbtHk760PI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hUC3wdbvAY44NEL/TpsZQ/UlOmm2CY0KNWbVK+xj485/yb6y8ISKa6zNlynUsqYrIdRcBG90MkEhAv2H8ZsvDvJoAKoF6pzpPuIm7VQtKQVt80dR65g6l7ibCxgICvfCTU76GoOsWEx+Xcmz3ANOA5ubzTwQX9Oo5prhHs2yxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=g8rYXG/i; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="g8rYXG/i"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 54935580351
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 18:31:40 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36A163EC8F;
	Mon, 13 Apr 2026 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1776105092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QzOn7socQyGoLfkBxZ/GeUKj0KBCAaXw0SYDfrIXpIQ=;
	b=g8rYXG/iMlO2N9zG8oahbjnhMl6D4sM0I/s5FG+hhHPvfqNVBUrlR/QzwXJ1IgoblFoYA5
	iU8IwpKOcrrJBXEHQKErpzlbO79h3AF80qz5lZ92XffCLgeuBmFQtzGAvwG/W8HRLYXcPK
	FSi5KjMjchxHCmDj+ySHUc4G3szuL9d3C+6kSTy3wtaaFCT3PecqGQHzJI+r0QXR+13GIj
	rXhvF7iISzV0JytxOR43xMTLTBEDmu0qekJiReFG6k4TCJWzAbxM+9Hw2E7PmrGgg3O5ny
	y3ryqEuVScCcYdH1PqvZWYOCeVHN5qVBKr74iCwx2e5vWR71WgYri2K1Ti7EsA==
From: Philippe Gerum <rpm@xenomai.org>
To: Brandon Ho <brandonho667@gmail.com>
Cc: brho@relativityspace.com,  jsridharan@relativityspace.com,
  xenomai@lists.linux.dev
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
In-Reply-To: <20260413181929.1801013-1-brho@relativityspace.com> (Brandon Ho's
	message of "Mon, 13 Apr 2026 11:19:29 -0700")
References: <87v7e8yzhj.fsf@xenomai.org>
	<20260413181929.1801013-1-brho@relativityspace.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 13 Apr 2026 20:31:31 +0200
Message-ID: <87h5pe7lvg.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTF3oeevSF+ltWCoNKeFx4DYgCWD7duvgPzwjsn4ZTMI7u377m8IofCuY+3xLVhvgD473Z1eM7JFKuQAIxtS0lexvtNsjA6XUb70/Di/yEo+p3SF0wVm6ZpAYk/2YArum2M2TfdsyM9tz5dNUxnuDtDHfT98A3ipOnJeWamwWq77ExpHoFXyqRHJqpoxbaYooUmsSIs613xCFmsNJJ44gqlkp7ULQSRP0eayQwb//0dk80C7ntQ1UVIXF2rMqEjYqEKduZLJGJ6gpHQSJUYY3aVKHCWrXNxbNYMv7jXH0h8BOxVtNz5PDPYowQ2mN6gx5a0x1cLGD+uE4OrGlQEz42mCPhUgWOi5RwEImUefqaXlXRHxgWsbSX0v4oM/IvBYfqfQ7I4EjetJbrz/vBo4vY+1zzcj6pQDYBjkl5TX80ITYos2G9lgg6o76/O61L8SR0RlE3UqifvP7tI62f4he6flaL9GusCjHIb/4YGtWM+INVeWfnWsbzRlCpxP/LNfDZ6PwMe8uCQi7z1bqboROaZEhfDFYHf5h6/CMN7UQZwacEBLegus1KiyY/I5utQ/9BPcWxOL4iPmUrxzUfE2xVSGsMxwjZmnuu27rlYbGYvnZCLVRlwA+1eaHUbvdR+M19g+/PSpmRHyJVK+3kEQudRI9ZMGIt3AJpsACFO8z2gMAQ
X-GND-State: clean
X-GND-Score: -100

Brandon Ho <brandonho667@gmail.com> writes:

> Thank you for the responses! I recently came across the
> `compact_unevictable_allowed` sysctl option and it seems like it could be a
> good fit for our use case. Setting it to 0 would prevent the kernel from
> compacting/migrating locked pages, which should eliminate the minor faults
> we're seeing during compaction.
>
> Could we possibly set `compact_unevictable_allowed=0` by default when
> CONFIG_EVL is enabled?

Definitely, yes. Thanks for chasing this issue down. This patch is going
to be merged upstream asap, you may want to apply it for a preview.

diff --git a/mm/Kconfig b/mm/Kconfig
index 7bf469354faf3..759af896a5c7b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -648,7 +648,7 @@ config COMPACTION
 config COMPACT_UNEVICTABLE_DEFAULT
 	int
 	depends on COMPACTION
-	default 0 if PREEMPT_RT
+	default 0 if PREEMPT_RT || DOVETAIL
 	default 1
 
 #

>
> https://www.infradead.org/~mchehab/kernel_docs/admin-guide/sysctl/vm.html#compact-unevictable-allowed

-- 
Philippe.
