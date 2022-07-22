Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60084A2C
	for <xenomai@lists.linux.dev>; Fri, 22 Jul 2022 17:13:28 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id DB1B4CB7FD
	for <xenomai@lists.linux.dev>; Fri, 22 Jul 2022 17:08:03 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5F56440005
	for <xenomai@lists.linux.dev>; Fri, 22 Jul 2022 17:07:56 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 64B16D80CA0
	for <xenomai@xenomai.org>; Fri, 22 Jul 2022 17:07:55 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 125A340005;
	Fri, 22 Jul 2022 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658509675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zDrisZI+6CuBzxYQQamdV8dsTw+Z9s0gECoW6+PSAY=;
	b=Q2O/WgyoPMS6kx+5Vfy7vOzWsIs47ku0aabPoVvql3bmHv6fRqpwRX0c8IxhZ3ML7IoeU8
	jgHWPmRIEh9LtdX5FmBY6JABI6Q/km3FAf5kGzzkoj37nM3Eg32wSE5cumONPVeVjlZwKq
	gwFCKgPm0PsPXu/xoG0ZXqDswSz7zfcQHiRrmoDsjYkGH30YphCy64SKy+/tdICwzFFcen
	uUeuMuYyGJomFyxWhuBFpVnhJfWvKsqP9pGnUK/Bjm4ic1f/4uI/ysZEoM/cj+X6LKzw1q
	H1+uq/JYeIcZVLWoDkTU8YBRxj8oiO8VoplCqej889brwHDLGCoKU55xdlso7A==
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org>
 <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
 <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
 <87edygmas6.fsf@xenomai.org>
 <CAAm9oxqx-P9O7cONgeGwud0BvsSWok7itGzqSZdc7NRCmFLdyg@mail.gmail.com>
 <87tu7bk76a.fsf@xenomai.org>
 <CAAm9oxpbtX2qXHPxOGCQre14_7T7jZtDuN=b5U2sA2B_su6ARQ@mail.gmail.com>
 <87a692ewlf.fsf@xenomai.org> <8735euee6p.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
Date: Fri, 22 Jul 2022 19:06:45 +0200
In-reply-to: <8735euee6p.fsf@xenomai.org>
Message-ID: <87czdxyt1x.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool5: domain of xenomai.org designates 217.70.183.194 as permitted sender) client-ip=217.70.183.194; envelope-from=rpm@xenomai.org; helo=relay2-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b="Q2O/Wgyo";
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.194 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>>
>>> On Wed, Jul 20, 2022 at 10:47 AM Philippe Gerum <rpm@xenomai.org> wrote:
>>>>
>>>>
>>>> Ok. On my end, I'll connect a pi4 with the i.MX6, to add the GENET MAC
>>>> module to the picture.
>>>>
>>>
>>> It looks like the GENET MAC driver (or the interface) is the culprit.
>>> For some reason, it
>>> restricts the packets sent to 10 after every netif down/up toggle.
>>>
>>
>> Weird. I'll trace that.
>>
>
> Confirmed, I can observe the exact same behavior with any board pinging
> the pi4 here. 10 packets with proper ICMP reply, then the responder goes
> south.

This issue should be gone with the latest (5) commits from this branch:
https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commits/v5.19-evl-rebase/

I'll backport them to 5.15 and 5.10 as well.

-- 
Philippe.
