Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0D28F3
	for <xenomai@lists.linux.dev>; Sun, 24 Jul 2022 08:47:52 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BDE1A1BF205;
	Sun, 24 Jul 2022 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658652464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8f8Kmnbd+zH6jGYpbh6Ke4D0DYVYJM+12V3dqEklSk=;
	b=mWWf7jKZEdvDCj1V5ck9C/LajUsRpcFyk9OL7fvFfkHBGySQXvuzjh/KxFZNXy8M39NVPN
	r/m1bv5WcXOA/zNmPs36hfuMQD7FhaJoAEjEp8Wmp/EUTxy9za8JxJTs5MOqAdKz9B9vfJ
	IcwP1FJst/R+jSVVkAAFgNHb6C1i65E/KPJx2Wsd4m7tLpsb8A7wRRqm0xxZIlHG9b7wpo
	TMcetKG1jrM9fWiYHl2Sd0GaLxTe0b35O9ykes6yXXo6DweUGtj0Q2ZQmhq4OGtrU3Ui4h
	vvc90TzO2vDrP5FQPD4GCDn/egCgC+4nlJP7BozuItQMODhSedySfJsfUhz+EA==
References: <PH1P110MB105042C5A2262DF250224C69E2919@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87sfmsmc9h.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Weird debugger behavior with events
Date: Sun, 24 Jul 2022 10:39:53 +0200
In-reply-to: <87sfmsmc9h.fsf@xenomai.org>
Message-ID: <87h736rj6a.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>
>> [[S/MIME Signed Part:Undecided]]
>> I ended up adding an xbuf and another thread to better replicate what I was 
>> seeing and exacerbate the issue. I can verify that all 3 threads show up as 
>> expected under "evl ps -l". You can just run the debugger with no breakpoints, 
>> and you should see the "-1 error occurred" message printed to the console at 
>> least once. You can also put a breakpoint on that print after the 
>> evl_timedwait_event call, and the breakpoint should get hit just about every 
>> time. Lastly, you can run the compiled app outside of gdb, and see that the 
>> error message is never printed out.
>>
>>
>> // g++ -Wall -g -o test 
>> test.cpp -I/opt/evl/include -L/opt/evl/lib -levl -lpthread
>>
>
> Ack. Working on this shortly. Thanks for the test code.

Please pull these kernel patches:
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/0d2d4fbfe3311a3ef419864cd4f1c6ddfd017a2c
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/6dd3b2e4c3a535f49595cb2463aadefec7f8670d

You may also want this one from libevl, although it is not required (but
recommended nevertheless):
https://source.denx.de/Xenomai/xenomai4/libevl/-/commit/c55ea95fdd4a790cf3905a2660d458e0cb518516

In short, the issue was due to unwanted syscall restart upon
signal. Fixing this was the opportunity to straighten the behavior of
the event mechanism upon interrupted wait.

The test code made it possible to spot the issue quickly, thanks.

-- 
Philippe.
