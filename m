Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F6657
	for <xenomai@lists.linux.dev>; Thu,  8 Dec 2022 07:58:58 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7D1F2240004;
	Thu,  8 Dec 2022 07:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1670486331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VF4hQXhA1VC9oYRCQCz1T/nbk45tNu0GzCf/RYBTELg=;
	b=RBWEZ8QWtgdNdI9zxC8sxMhgnNor1kt2KCJSq84zXagRErLGBy7M4tsO0bD/sblf0PqOb1
	Raa06+bKPzmSw5t65VSqVsgUxp9NHPcA8MjDbz9KKbgHARh6N44q4yHvr2lrgQMeFJ5v6T
	rPXMku1nQ5JjW3+rC8Hhw9/eUVITyJijpJnhs/mY7Dvc9a02fP3gxtA5PMBk5Wk/6Nsx0t
	fvrbwwapyNNVKpgEHGHX1H6UeTDxgiG3n3emOtsZ8xCoqNrRT/TPKrPHqnBk1Tv9USA5zt
	gI9N5xoLTZhRGNbn77E3hwE5A0AdpN3N+CYzJKuQHyEJSgSRkfWNkYlEGUO9QQ==
References: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
 <87mt84h3h0.fsf@xenomai.org> <87ilish1z0.fsf@xenomai.org>
 <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai crash in timer IRQ
Date: Thu, 08 Dec 2022 08:53:52 +0100
In-reply-to: <CAAm9oxp-Zm+25CpxT7wYUiDWxZGBxStB14D8QnEZWDmCp6jYsQ@mail.gmail.com>
Message-ID: <87359qwclj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> Hi Philippe,
>
> With next-evl-rebase, I am not able to reproduce the crash. Instead
> the system reboots (from the watchdog) or hangs (if I disable the
> watchdog).
>
> I'll try going back to the original setup and try other experiments --
> maybe try to reproduce this with a test program or attach a debugger
> to get more data.
>

Ack, at this point it should be possible to reproduce this bug with a
simple test case if you think the core is doing something wrong when the
kernel wallclock is set.

If you have custom drivers, you may want to check the lifetime of any
standalone evl_timer structs it might define for correctness, to make
sure there is no stale timers being reprogrammed (unlikely, but worth a
check anyway).

-- 
Philippe.
