Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D267B
	for <xenomai@lists.linux.dev>; Sun, 25 Sep 2022 15:05:36 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 092C4100004;
	Sun, 25 Sep 2022 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664118329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRnPuDo7bE9cfD3LTITzU42HWUkaamrTvUMF+bgQrf8=;
	b=FPr4e2zVcN/XSNEV+t1d4DJHyd8JaVVZeJrtQABi6Q4ay8Umy/tJYSzCoWXoVPrzwVdybV
	EsejZQn5yLC+CvMrBsodevwkg4yKolZ08yGH5S9I5L14BcYBAm7qbdGoh7SkGlyGQ668uC
	RqN37ysaKA4mETPzHCc37x9FTb7ZQOTc7gCmU4dkJilHz7hzl5uVRKZ6W1swYrUfokiKQ2
	t/f2Nrvt1e+uo+b5T9lW0+qlSG1iYyThFMOxAY+Pov066xJEtpa5q6q4o/cmYfPi4AT1jN
	jqBw5kl7zgHZBc4270ZvUal6XQVyPjR73NlDSWp0GfRZrzgTY9eA7PLT9tWsiw==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Bryan Butler <Bryan.Butler@kratosdefense.com>
Cc: Russell Johnson <russell.johnson@kratosdefense.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Sun, 25 Sep 2022 16:59:24 +0200
In-reply-to: <87o7v59o02.fsf@xenomai.org>
Message-ID: <87illb8pfs.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Bryan Butler <Bryan.Butler@kratosdefense.com> writes:
>
>> I have another system that behaves slightly differently. When it hits the watchdog, here's what I get:
>>
>
> I have been able to reproduce a bug on an armv7 SoC with the test case
> you provided. Sometimes the RCU stall detector triggers, sometimes it's
> a plain hard lockup. I believe these are symptoms of the same bug, which
> _seems_ to hide in the PI chain management. I'm on it.

Actually, the PI chain was 'only' collateral damage. The bug was a
fairly silly ABBA deadlock issue elsewhere, in the monitor
implementation. A fix is under stress test here, I'll follow up with a
patch asap.

Thanks for the fine test case, having it made a huge difference once
again.

-- 
Philippe.
