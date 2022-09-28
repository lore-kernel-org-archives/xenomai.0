Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53077B
	for <xenomai@lists.linux.dev>; Wed, 28 Sep 2022 10:41:36 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A16801BF205;
	Wed, 28 Sep 2022 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1664361689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkzTSmqqHmHWkS5KeFL/WczxM+8n2I2Oupo9DCYqFJM=;
	b=E2ewbdaaWWZyrnu/Odb6y5qF4A7TCixShICZWtjEF4etJWS7LaYYmrtyYj4PfXLt6MrdjV
	abPNjlo8IhrtJdetRICGsgOSQUcyj2lmJD4ZiZRDXf3MH365dFQ76cwnJce3ROW1GQft9i
	tQRFAFdlFaOztdSUE+Bei7sX6uIjZO03Etdh5LFBQgxUX5E8HyEW15uZwsVkEUxfmrQjNj
	gQFYUBPyFx+5jlyNuWvCDjSXGI5TwPducEB9/ytDMhbjdPKrnTckDZLmoojXl4wlYE0fYe
	9tdNg0qBqm0GJx18gpXTXFk1DuSXfOhY531gCubM/IgCagOJtiOnZlktVMI7EQ==
References: <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <BN2P110MB1288DADB384231E5FB72D8EC8F549@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87czbf7pp5.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Bryan Butler <Bryan.Butler@kratosdefense.com>
Cc: Russell Johnson <russell.johnson@kratosdefense.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [External] - Re: System hanging when using condition variables
Date: Wed, 28 Sep 2022 12:37:44 +0200
In-reply-to: <87czbf7pp5.fsf@xenomai.org>
Message-ID: <878rm37pd3.fsf@xenomai.org>
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
>> [[S/MIME Signed Part:Undecided]]
>> Philippe, 
>>
>> I have observed a couple of odd things, and wanted to see if these were
>> intentional or not:
>>
>> 1. According to the documentation on evl_attach_thread(), the CPU affinity
>> is locked to a the single CPU on which the thread is running at the time.
>> Although one can call sched_setaffinity(), at the cost of a one-time in-band
>> switch, it doesn't appear that this actually changes the affinity
>> settings.

Are you targeting a sibling thread with sched_setaffinity()
(i.e. passing a non-zero, valid pid argument), or is sched_setaffinity()
applied to self (i.e. zero pid)?

>
>> I can work
>> around this issue if necessary, but it may constrain the amount of
>> parallelism we can achieve. I can work around the second issue as well, but
>> it will make for some kind of ugly code.
>>
>
> I've been using the worker pool pattern here in many occasions with EVL
> threads, the core does affect this

s/does/does NOT/

-- 
Philippe.
