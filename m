Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F7182D4
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 13:12:07 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15DB3E0007;
	Wed,  9 Aug 2023 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1691586724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/lAgLSEoYyU3Y+T0ahpvnlOmAk4Tviztpu1/Bb9H48=;
	b=DpiGRDD5DnTaJ0RiSVdnZy9OpBHB3EO5cKccvx9+ICY2c1jOv8wQjaMMNXk/XCuxOL/pnf
	jbUuTuOoM4EIAWgEu6jzqx3Dt27spKBMPDQzSV6CsIkK8FV2M4/SHpwEB6sCA+hXtsPLQA
	F7x40FJ/cTk8hBW7Mnbg92t70Or9pyvnu7huv6K/OMJ2bEZ0QaQqMgkOMzTxkDezDjGvGW
	nquYcPTqGUrRDisJTMMLu3RWbGRk32vLoE8PXoWG0LCURR1u4BcY3weD3dmInShzxE6B4O
	lkEZt45FQ5xICfVJ5XDAAATydIq7UpcVNtzHcOg6pf+FWBks2pLnVQMxOdTDKg==
References: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
 <87edlkeu1b.fsf@xenomai.org>
 <a35a96771c0f059370357b9a37c9ab1871e621b0.camel@siemens.com>
 <beff2aa61a6b00af08baa7374feff1a0ddf6dd93.camel@siemens.com>
 <87tttiswuf.fsf@xenomai.org>
 <163ed99e-bb3f-afe0-27d6-eda78c65e6c5@siemens.com>
 <a1d3d859-5230-4b13-b54f-93e41a1a3476@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: v6.1.y-dovetail-rebase
Date: Wed, 09 Aug 2023 15:11:51 +0200
In-reply-to: <a1d3d859-5230-4b13-b54f-93e41a1a3476@siemens.com>
Message-ID: <87ttt8bbrw.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 09.08.23 07:52, Jan Kiszka wrote:
>> On 01.08.23 15:26, Philippe Gerum wrote:
>>>
>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>
>>>> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>>>>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>
>>>>>>> Hi Philippe,
>>>>>>>
>>>>>>> quick feedback on latest rebasing:
>>>>>>>
>>>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>>>>>>>
>>>>>>> This was likely accidentally folded, right?
>>>>>>>
>>>>>>
>>>>>> It looks so. This conditional statement appeared upstream during the
>>>>>> v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>>>>>> patch for this entire series.
>>>>>>
>>>>>>> Furthermore, I will factor this change out into a separate commit in 
>>>>>>> merging v6.1.y-dovetail, for better traceability:
>>>>>>>
>>>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>>>> index ce8bdd804bc7..c843bf352999 100644
>>>>>>> --- a/arch/x86/mm/fault.c
>>>>>>> +++ b/arch/x86/mm/fault.c
>>>>>>> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>>>>  
>>>>>>>  	/* The fault is fully completed (including releasing mmap lock) */
>>>>>>>  	if (fault & VM_FAULT_COMPLETED)
>>>>>>> -		return;
>>>>>>> +		goto out;
>>>>>>>  
>>>>>>>  	/*
>>>>>>>  	 * If we need to retry the mmap_lock has already been released,
>>>>>>>
>>>>>>> To my understanding, this was a dovetail fix that applied to previous 
>>>>>>> versions as well.
>>>>>>
>>>>>> Only to v6.0, however this series is not maintained dovetail-wise
>>>>>> anymore, so this stayed under the radar.
>>>>>
>>>>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>>>>> through a 24h stress test while the "merge" branch failed. Happily
>>>>> waiting for the next release...
>>>>
>>>> Do we have a idea / plan when the next 6.1 dovetail release will
>>>> happen? My internal customer is waiting for that and I want to avoid
>>>> backporting to 6.1.34.
>>>>
>>>
>>> There is a brewing rebase to v6.1.42 pending tests here, no challenging
>>> source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
>>> if you want to give it a try before Jan updates the stable branch.
>>>
>> 
>> We are testing against -rebase anyway (but that needs a trigger which I
>> just provided). The merging branch is only updated once there is a
>> release tagged.
>> 
>
> Passed with the Xenomai 3 tests:
>
> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/17252
>
> But can we update to 6.1.44 directly? Florian mentioned that there are
> Downfall-related fixes in that release.
>
> Jan

yes, .44 is actually brewing here already.

-- 
Philippe.
