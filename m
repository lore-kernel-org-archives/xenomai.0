Received: from se4w-iad1.servconfig.com (se4w-iad1.servconfig.com [23.235.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF4288DD
	for <xenomai@lists.linux.dev>; Wed, 17 Jan 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.235.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535430; cv=none; b=cpNEsLduPa3L2Wb+/G6W4frQgXgFAPanybMfjMjXYjfTLox1nwb7zzgg14edP6Y8ccauX6XN5JxDn1wObO5axJSiAsKtDg+tpqW9QBOu/Ihpi2bJNCch7EzYd5MYPzrBsvYvRafkhVHv13KoFsX1lZDLVC7sq3ZoSFdUO06+GwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535430; c=relaxed/simple;
	bh=ghCn4MovkYZCgztlynH47yELqMJTPvhbQH+EWxglQ8o=;
	h=Received:DKIM-Signature:Received:MIME-Version:Date:From:To:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Originating-IP:X-SpamExperts-Domain:
	 X-SpamExperts-Username:X-SpamExperts-Outgoing-Class:
	 X-SpamExperts-Outgoing-Evidence:X-Recommended-Action:X-Filter-ID:
	 X-Report-Abuse-To; b=Aa85goUCadHc5oQILx0XBNalW9UOGZzhTpwHVwiGLdT287sBiDhjuBUbde8wiShPY0l+24lTeH8UdzRNKowqTy2o1eDk+WfOX8x8+WA8weyF6YxWEOll7cqh0hS1g6o1qva4bvBZLq+BJMVeWTo/uNWuL5udoiq7MxrOCmU9EWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rtxi.org; spf=none smtp.mailfrom=rtxi.org; dkim=fail (0-bit key) header.d=rtxi.org header.i=@rtxi.org header.b=g462mAU9 reason="key not found in DNS"; arc=none smtp.client-ip=23.235.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rtxi.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtxi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rtxi.org header.i=@rtxi.org header.b="g462mAU9"
Received: from ecbiz330.inmotionhosting.com ([69.174.52.25])
	by se4-iad1.servconfig.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.92)
	(envelope-from <ivan@rtxi.org>)
	id 1rQFEu-0006TV-V2
	for xenomai@lists.linux.dev; Wed, 17 Jan 2024 18:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rtxi.org;
	s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ws8kxeTyPR+mVonQaeCN4Zyy9bDaWaG0lUmwMZlsMSE=; b=g462mAU9zM7LnhrkFzSL1Mq1S+
	Q34Lw20bkrZnKMuqcPYcfVwiBd/5mhbX2q81jHIRTE6F+yBLKsyMcF9IUUNQhi/OWfIgJAtC/ujNz
	VAvebvkGBTKYVSH3PUuH+Adbay3Ub66+SjfRnIAtd94zUwEdyoAu3ZUtjXqduDcoA5qfGNcCx7fSc
	d63VjX/a5vyhlMfRKjAQkyLD7OsFYLFXZ5MK0GfT0Kt6nS2Cigsb66URp0gs8nLFr4K72n7EF5cJS
	b5FpGQqPQORzQWjWRRKDlG5XEYuwbEqF/QVpGqwNjoSTDYsqcC9fClwN+kzLqud+iYDxEWIWKXx+L
	Rt/RwApg==;
Received: from [::1] (port=46328 helo=ecbiz330.inmotionhosting.com)
	by ecbiz330.inmotionhosting.com with esmtpa (Exim 4.96.2)
	(envelope-from <ivan@rtxi.org>)
	id 1rQFEu-00Ga4H-1V
	for xenomai@lists.linux.dev;
	Wed, 17 Jan 2024 18:22:32 -0500
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 17 Jan 2024 18:22:32 -0500
From: ivan@rtxi.org
To: xenomai@lists.linux.dev
Subject: Re: Troubleshooting x86_64 evl bootup
In-Reply-To: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
References: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
User-Agent: Roundcube Webmail/1.6.0
Message-ID: <34ba04db1b45f6c546a2195f0a8e0ad3@rtxi.org>
X-Sender: ivan@rtxi.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: ecbiz330.inmotionhosting.com: authenticated_id: ivan@rtxi.org
X-Authenticated-Sender: ecbiz330.inmotionhosting.com: ivan@rtxi.org
X-SpamExperts-Domain: ecbiz330.inmotionhosting.com
X-SpamExperts-Username: 69.174.52.25
Authentication-Results: servconfig.com; auth=pass smtp.auth=69.174.52.25@ecbiz330.inmotionhosting.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+Mrb3tjy7t3hBxgQGTbj2NPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zM2Yn+ifXDUaVfcH2UdAod81AJ1TFUyPPWZD/fbWINKOfH
 zJ6mVE7ewsipSVIfs4YpjymycbeamHkHy1jHxvMQABHVTw1lV42ob3hDgXVUNRrZmhutlYgqreu/
 P9NI45012jOF85Kv6fCAxgcD8ltXtPrQqsGLrECr51ySuHmtre3om1NOCXE1kCr91rpFr6RoWVCb
 J90C820C8IDV94ZMIyjbFUQY1CUernJTO7qkOddCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrU
 Vh8zaVyj66M1yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2ggTHzfqZI
 wwACW9bQ+KDdJhsM51Mye8eo6Y/hXEFbc9MIm4qZ5/UkJuZ+By/rOgnAAKmW7SISmwD3O07KW3Zh
 YDkW7+erWZ92q8bI/tBEya5tuBWXiK6eoWgQZnNLL6SbpUc7peFeo3eDQNYbhOKhzzgqmaDn5SlD
 Y9mmtv6e91aWBLor1oCWetcUjeG94V2XRv0eLDH2VxfUpX1i2sQBtmaKnUd4mN3xkONnx9HiFPU+
 Ah38ENdxgw7ixFZaXcShwvNj+trPHbioooz4SraaM+AC+9Z356apX8Ql6vjzl5/FFwtmK8QNyakB
 sz1lFzQC/DjVp9r4/TQ9+fLMXXltsrOVETDvX1r6juAzzCdkl9QRwusdS4GFqVHXFW5WReuVLYZY
 owgCrdbMX997wRREoxtak6yLrWcnyndkB0F012ZmMRr+w2X69ygMahiTQMBdfP4xeY4Ex4L9zZIk
 hhx7ZsOpyKA69LF1Ge2GaGfxmfq8bxon8djJ4ZfshZL8IhO77duugWgmqZHBDDH3Mm//g/VSoffW
 7VAGp45zAgB9nKNjzpm0lxYA3q6cDY3g7yjrRH1hNwTDHehLmTlW0tbLmDBtUD9+Z7GHz/OHPkRS
 typsFt3EfutjrssjiWZbF0wADuiMjPRTVWNyTJ7O0CWtBzEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se1-lax1.servconfig.com

On 2024-01-04 13:34, ivan@rtxi.org wrote:

Hello everyone,

I tried building and installing with a newer kernel version 
(v6.6.y-evl-rebase) and i get the same error during bootup. This time 
however, there is an additional message:

clocksource: Switched to clocksource tsc

After which it hangs for a minute then the same output previously 
described is printed. Am I doing something wrong? What additional 
information do you need?

Thanks,
Ivan F. Valerio

> Hello all!
> 
> I have been trying to upgrade a desktop that used to have Xenomai 3 + 
> IPIPE to the new EVL system. Compilation is successful but the kernel 
> hangs during boot with an rcu error message followed by a stack dump:
> 
> rcu: unless rcu_preempt kthread gets sufficient CPU time, OOM is now 
> expected behavior.
> ...
> Call Trace:
> <TASK>
> __schedule+0xd76/0x1950
> ? sched_clock+0x9/0x10
> ? sched_clock_local+0x17/0x90
> ? inband_irq_save+0xe/Ux30
> schedule+0x69/0x110
> schedule_timeout+0x19a/8x2f0
> ? del_timer_sync+0x50/0x50
> rcu_gp_fqs_loop+0xf9/0x470
> rcu_gp_kthread+0x15a/0x210
> ? rcu_gp_init+0x640/0x640
> kthread+0x12a/0x150
> ? set_kthread_struct+0x50/0×50
> ret_fron_fork+0x22/0x30
> </TASK>
> 
> After some digging, the evl page references possible issue as "loosing 
> the tick device" but don't know how to confirm whether that is the case 
> here. This computer uses an AMD Phenom II X6 1035T processor and The 
> kernel branch used from linux-evl repo is "v5.15.y-evl-rebase". Any 
> suggestions on how to track down the issue?
> 
> Regards,
> -Ivan F. Valerio
