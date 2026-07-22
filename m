Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FC1474CC
	for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703739; cv=pass; b=FwG26K0szQz5WlaXeG0FBEl2pnxVa7RP8kuCwhkbZdFVt7KpuJ192PtTaXjRq0HW8GytkZNOH7QXuv5YB7DX0Yy+jtq0/IP13qX+Jd9wxoOvvaNElnW/qy0+NhcCrDzFfiwjbzsjWcf50g3TR+DCQ+ibwzsqBW5vgU/V5DJ/kGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703739; c=relaxed/simple;
	bh=97SdAoXPPvj48hUsOJ8Di3GTlHG2lDBm5Z7POn97JcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uELx0xQVJiH6GmlpVwI38wzxQRgNSuoJoTPbfJ6SusXKdUsLZaEgJAVsWF2d0WZi7H7x7NvNrgypo0SUWdmavwbVfrreMg6aRwkhAwMSe14pmDAc1ihE+N8YKVdmLTg8TIvWls1cWlpF9IILgOnVpTObvDzUU9Irs1gm6lTKSmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibv-augsburg.net; spf=none smtp.mailfrom=ibv-augsburg.net; dkim=pass (2048-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b=YMD/sYhA; dkim=permerror (0-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b=lHMSFoE7; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibv-augsburg.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ibv-augsburg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b="YMD/sYhA";
	dkim=permerror (0-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b="lHMSFoE7"
ARC-Seal: i=1; a=rsa-sha256; t=1784703551; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MbygS/LERrfT6A2LVHmS7R8YNY3ZAhRJJb/3BHLTAuVjvpl46VwuuSnHHG50ewHL+G
    T2O7+buE3y+CPdZABJpME6wGyIwSl0akzPcJ0tFFdeEIbxGf/K3uMzoABOKx+zHEhKfU
    3DO384fOXOCCQiPoLpaGtgEuruXsbwRzHpxt0JEy3U7gGuhlIeOaheIRdvLGYjOodcRD
    Erc5LhDnEdIcF5AMKWRDlBX7Glyy+tGAlqDjJsCP5V5pNGzXOZ8egy4ajv8S+K+kQkxs
    WmcSIX8DT3IkuZBPwLRw3v2dGAODwtMURK/1F1C60unXSmqpeAm2jTh0Fb/rznH4P1ST
    LbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784703551;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=ZrBQAcD9kfX5HDWHq/cyl2dRsCHdhaKDxH9C1k/3lto=;
    b=MRxzqp5AsQKjGFCFCPdq3bdYKFk68rwdmWidJ92lqUYD7X5U//YEpDUObr5hKhyiX0
    Vps5unsK76Q/6nxnspFdJaY1+4GjYqbM9rcbxC5L+0mnXWZfndMxukm3c2kntuvY5ebV
    v32IJVfq1ULRN/YZzdcKP/z4lUO7J+PUN6+0zHLvZflcscldt3O1OzcdBO0p4gCPbIAl
    nZouvFeWmG3sHrAw8xAhS66Vyg09Gu/B63VOuDmJl20JnnP/wMI25wSOgKinddlvL8X5
    Nvta0xpYfXYvHIIRA0yExpL2ozDSEUY3K88SRCdd+fRsf/RbRK9ncE36OCvi5rBJ6szY
    1o+g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784703551;
    s=strato-dkim-0002; d=ibv-augsburg.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=ZrBQAcD9kfX5HDWHq/cyl2dRsCHdhaKDxH9C1k/3lto=;
    b=YMD/sYhAlj+sGXm6DgPDZat5/KG/dE5UrsjppAa5WIZi3qoNVcsMLEape574HQ70Yz
    ZkFrZa1y4JXHLet4cUYeHYUczS64ASArxnyo33aIt/sVKnwxZrUDpkhipNl+Y9NnEDgo
    XQ/6pxzBjAl0upI7OXVzcc0qGQ+8zy1/ylyiWeGudJJsv3fWE7iCwoWmtOfQKOO3EEvR
    vSSH3IoTw+eBOYr8OdAbzpzquvrT7Vu6vtwQBCJf3FOErz1CoFnp8+f0bCjmG47R/72J
    qZJmd74RonVAthNioU5Km0+2JVipQos+mEYtIcyMa2d6ElhvCeaJMz8KIpT3ZsShewXA
    z4SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784703551;
    s=strato-dkim-0003; d=ibv-augsburg.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=ZrBQAcD9kfX5HDWHq/cyl2dRsCHdhaKDxH9C1k/3lto=;
    b=lHMSFoE7Hqi7FzQucKdT/lf+hgpXdoUxetQK60SVHtsbGSrynK5Dz7UQ/Jqth5gBn+
    Gz1bEwAIC7BxhSgQbhAg==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9JMCwOG/8exKYiOUajXIudlAcw+7La"
Received: from [192.168.178.181]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Nec57f26M6xBH8T
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Jul 2026 08:59:11 +0200 (CEST)
Message-ID: <f50bdfd0-3f00-4893-8303-13e7de4997ff@ibv-augsburg.net>
Date: Wed, 22 Jul 2026 08:59:10 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hang during smokey posix_cond test w/ cobalt and PREEMPT_RT
 enabled
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <8b51814b-b91a-480b-bb7e-2cbf13660f21@ibv-augsburg.net>
 <ebb378df-45d1-469c-928c-523f16a39460@siemens.com>
Content-Language: en-US
From: Dominic Rath <dominic.rath@ibv-augsburg.net>
In-Reply-To: <ebb378df-45d1-469c-928c-523f16a39460@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/2026 10:03 AM, Jan Kiszka wrote:
>> What I'm not so sure about is the following:
>>
>> - is running Xenomai 3 with cobalt on a kernel with PREEMPT_RT
>> supported, i.e. should this work?
>>
> 
> Conceptually, yes. Practically, this combination is very likely
> undertested (e.g. not part of our CI).

Understood. Thanks for the explanation.
>> - is it conceivable that the main thread continues execution in the
>> Linux domain before lostage_task_wakeup got called? Or does this
>> indicate that there's something else wrong with our setup?
>>
>> I've enabled all of the Xenomai, dovetail and PREEMPT_RT debug checks
>> that made sense to me and I'm not getting any errors, but of course I
>> might have missed some useful CONFIG option.
>>
> 
> Did you already compare the event flow you are seeing with a reference
> flow you could generated from qemu-arm64 image of xenomai-images? That
> may help looking for the essential differences.
> 
> Furthermore, you could patch xenomai-image to turn on PREEMPT_RT for
> 6.12 on qemu-arm64 as well and possibly run your test in that setup
> (provided its portable enough).
Thanks, that's a great idea, I haven't thought of that. The test is the 
posix_cond test in smokey, i.e. nothing of our own, so I'd assume it is 
portable.

I'll make sure to give this a try and report back, it just might take a 
couple of days.

Regards,
Dominic
