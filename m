Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074762F
	for <xenomai@lists.linux.dev>; Sat, 16 Jul 2022 10:24:06 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1652C240004;
	Sat, 16 Jul 2022 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1657967042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhtESIiqJ/5XGANGIUKa41PlbZCr5XS5v37LLKtwh+8=;
	b=kAW8FFkFaZB4AO5l4umw1CdjOmX/CKXWtNJK788bPbMjPk6Z0dwDcICfbTsz68+FEUXETl
	F+OgyAyywUwqewimLBaAbTaqOSMa3D5E246TQtMKYm7+psUFrg7W2I+l3yg/FNM51pwXyd
	Kf+bItGGQ+Qrcg/Zeyb9wHSqaunIRigeJGMbX5iPOZtJ3pOe0bdrdp2V9s+56dhJHgQK2x
	v3kv27VcLercJFEeHXKtbqQaDppYWbCcU86uC+BSKa1usEuUU/c0CXYmNT5cElJDU2L0mH
	GSJw1FCex/StZUolMmf71L7/Uv1YakXle90epMPVJGVJtReq3aEn98eDd6Oasg==
References: <PH1P110MB10502D67A603D43F701FB193E28B9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Sleep while holding a mutex
Date: Sat, 16 Jul 2022 12:22:22 +0200
In-reply-to: <PH1P110MB10502D67A603D43F701FB193E28B9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87o7xpqrsu.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> In one of my functions, I lock a mutex, call evl_timedwat_event(), and then unlock the mutex. Whenever I call the timedwait, I get an error from the EVL Core saying that there was a sleep while holding a mutex. I was following the example on [1]. I also noticed under a test at [2] that there is a comment saying to disable the T_WOLI mode on the thread because there will be a sleep during a mutex. The test appears to verify the timedwait
> call. So do I need to just ignore that error whenever I am using an EVL event? Or do I have something else going wrong potentially?
>
>  
>
> [1] https://evlproject.org/core/user-api/event/
>
> [2] https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/next/tests/monitor-event.c#L40
>
>  
>
> Thanks,
>
>  
>
> Russell
>
> [[End of S/MIME Signed Part]]

The documentation is right, but the code is wrong. This patch fixes it:
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/1dc0d91aa3a5c2055fe8e492df0b229546d4f5da

The test suite was updated accordingly to check the right behavior:
https://source.denx.de/Xenomai/xenomai4/libevl/-/commit/1b30808a6b0095736c5e1059377e2cb07225e9f6

-- 
Philippe.
