Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19AD28E8
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 09:10:47 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6E5D8C0009;
	Mon,  7 Nov 2022 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1667812240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJJ/A1Vic0qLYVe3E5tYdj0fnDxDqX8j6PS8yf8LmLE=;
	b=T9G6gZ6B4cTJVxIxZ6RLBggWWhK0nP6rV28LQIsGYujzcIt7FPm73PNBFThKkMfnxuY2gD
	Z8oOCEpydRrMkGuylcBTKr1JMdF/oiMNGQWe3LMaYzdYkMXFxVnhb68aQujVQILOcbBv5N
	CVNe4tWlc3U6J7O/wUjx1Xc4onZ/HZpU+zHcn/hMzUJriBh7zDRmAjHp5xtSJ/VT2Q8DjJ
	kSXSrzhZkH7ZTY8QMIAt/+jHu0U/fpN8+ngOLbAUYNTHB8pf0MFpidsxJbj6sSLnN9N7db
	Lv5d99h3RLsP1nr0klqQV8jsQKmeheb6tDAWr0bSwSnGwQcEmvVDLq92kJSP4Q==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h70r7r0m.fsf@xenomai.org>
 <PH1P110MB1050C74BE6BB64AD707616BAE2549@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87r0zu7j6i.fsf@xenomai.org>
 <PH1P110MB1050EC5BE3C92F3A71EB8855E2599@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87fsg38to9.fsf@xenomai.org>
 <PH1P110MB10507285415B676A9E6B28CDE2229@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1004AFDF790324668D268830FA229@PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Russell Johnson <russell.johnson@kratosdefense.com>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Eric Kuzara
 <Eric.Kuzara@kratosdefense.com>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Thu, 03 Nov 2022 19:13:44 +0100
In-reply-to: <PH1P110MB1004AFDF790324668D268830FA229@PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <875yfrp1td.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Eric Kuzara <Eric.Kuzara@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello Philippe,
>
> It is nice to meet you.  As Russell said I am a Sr. Project Manager for the
> effort Russell and Bryan are working on.  First let me say that both Russell
> and Bryan have been very complimentary of you and how responsive you have
> been in resolving our EVL issues the last few months.  It is very much
> appreciated.  But as the manager I need to make sure you understand the
> criticality and urgency of the current situation.  According to Russell we
> are now completely stalled awaiting the resolution of this  latest issue you
> are working for us.  This is gating progress on two very large customer
> projects we have one of which has national security implications.  Please
> continue to do everything you can to resolve this as soon as possible.  I
> know it is difficult as I have some personal ancient history in real time
> operating systems and I have an appreciation for their complexity and
> difficulty to debug.  But please do whatever you can.  Feel free to continue
> to reach out to Russell if he can be of any further assistance.
>

A quick follow up for the list: this bug is now fixed in all maintained
EVL branches (v5.10, v5.15, and v6.1). As a result, not only the ABBA
locking issue was fixed, but we gained a scalable implementation of the
priority inheritance handling in the process.

Thanks for your help in testing and debugging this issue.

-- 
Philippe.
