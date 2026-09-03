Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701A40099A
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420047; cv=none; b=Y3e8rk5nMtZC91XOkzGapPdj3EOCSHxKU/KLhXOK3gYuv/sK3XdMhtCvhW32iW9zLtSxSa7EVVg7v3avp2b/xjZbJhOORECOhbPAlGbkmzkCkwruKeBZJ67c84LBaTAFnyQxjFHOSn6npBSQra30yMvU480VreR3Ozbq6XFBqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420047; c=relaxed/simple;
	bh=Z9PAnHkjquclQ/RrMneUiWkYe6ezE5xtkjZ8/ChZ080=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAHolsp4Tp51sf//R+wyoZ1FRMXS2HgrBxhPVlOeSyx722O6FD/MExx1f1XPnIDUg2ppyB/2ipYZfy4LWkIh4iSXqmPirXKOXd0UjIyzolhdDHt1LnNqT2DDzN9jIAxpZPlpjm12Eh8KXYQgrd50vh1vIwLqvKL9aStjPHt8htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ZPnCWP6j; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ZPnCWP6j"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7637B3ED3D;
	Thu,  3 Sep 2026 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788420034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJpTLSC6FUscw/u6jo2EzrwHAMdpCPNtrv5/Aw0ErFU=;
	b=ZPnCWP6j7ncKT7GuYqu9IoLtL3A0fKlkcov10dZR3JAGxaJvV9kiLmFOiEpvIx7NOjIMlX
	Tz17pwXkr2G4ftad14JHFCeAcBAlnVHui5gw5oL1uXhvC4j/JDCc69JrAu4dGBeWyWycs9
	IX+KzSQ6eR8s+OHNSbW6Fm9UKd8K7kyTXQMig8A3r7qvodNjq3EIlWjW0WjRJKvIyr0tl/
	7FOAnvWydxKQoW8vkYTwwI4EcxI9ezL8eSUyLm0+ngDFZrbxJdzp/gbjAw0ZZtm1uJLB34
	6NxNzt7IAZuaOr7pqfwrMExsg7XnvPN+MAbn+jDZigTELvylraXKZ0bwA9WDZw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: libevl: sched-quota test lacks success check
In-Reply-To: <86d6990a-349c-42f3-a054-494422298386@siemens.com> (Jan Kiszka's
	message of "Mon, 31 Aug 2026 14:48:01 +0200")
References: <86d6990a-349c-42f3-a054-494422298386@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 03 Sep 2026 09:20:33 +0200
Message-ID: <878q5issvy.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTE/kt97N247ib24xwE81WPDZyio11TsycCi/BvwHY8Te3ZT6Vb0JDtEXFYPfKZLhWKXeYxaV4J578y+5SU8k1Iw0YjmiWbHGcNzP6lFsYetR+YyMk7SK8ksRsu7CtiDYU+PApWw2B43DyjwdKj+HoEhWrCbkPbzLtnKtwsz1gRNbqIIfXzwOumS9S1fbW/IrvChuuC+abJzi5KiKiY/DpQtJcO4pbbY3lL+MyfXg99JcU4yjo4X5aVeFLXEFkTgkxB9BZ1CCMKnEBOtd1fxaObXm4YxLJT7yrkqStH3XIge93G8u6guFojwYV8DYXdSgatm1YCDHd3dtuV0+zKbsHkPP4LCppy884csA2q1T2z5F06RxUQEj9b+28nkGcCgz4Av+cXGe1tvRk+FbElGnD/VkSJDI2jCVOa/+UDQ8ni2RvPgFqDuBbHcwMyJLYKT5qtIreX0ukD8nM+3hn6VIA1MqUs6wyKwe8m3cBExE9/Gjrrisebau1wJ+UDpdYgSZ9+oEBWyjgPurWOJlyvcYs23gRP/3r96dgBfrcQPMjqRvPaFmWVXEDFQ1bT2JsER8E/dqK/a6M+q3W3To6bfD+Kn+cccR9IQDmV5Rx47r3CQyismT5bLYbR/5H9rsR/hwG0belKFg94lBS74BUtPlEDnWc977exwa6jf71sjJ7ea0w

Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> trying to port the sched-quota fixes back to xenomai 3, I had a look at
> again at the libevl test. And since [1], it always succeeds (unless some
> function returns an error), no more checking of percentage boundaries.
> That's not helpful for CI, though. Would it make sense to re-introduce
> this, just with an exception for VM hosts? That what we do in xenomai3.
>
> Jan
>
> [1]
> https://gitlab.com/Xenomai/xenomai4/libevl/-/commit/22ed65d951dd49b159e52c498dda49b2492138f7

Yes, I'd be fine with that, although the acceptable score could be
arguably different even across hw platforms, so we would have to pick a
conservative value to declare success/failure unless the test adapts
based on some heuristics. This said, I agree that running_on_vm() is our
friend to fully disable such check only on VM since the figure does not
make much sense there.

-- 
Philippe.
