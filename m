Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFC7B
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 08:46:43 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 759BF24000C
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 08:46:35 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5534AD80F9A
	for <xenomai@xenomai.org>; Wed, 20 Jul 2022 08:46:34 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E5A31FF804;
	Wed, 20 Jul 2022 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658306794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBOPk/J2QuMJO4mxdeYzUsiULhRU5Mdl+z1+X0wlNZc=;
	b=f1nIhAziGQ26QcFILMu0vROssT+fh2LvUbc0JNQCtDgSR0QOC2CIyZlVwlTujHlstkfc/N
	ZWOeS7VZ+/v03AsD0VGo/P0lqJxiASZHdbNh+9hETVBtqdHwyREvaZC78j0TXTHl0zURTe
	g+8L3rYICNJmMH3qIr25AW/wl4ICz2XI9iu+P/NM5Ph7romhM8YGhsIbcvTNn+oLIXxUdO
	oSnUkJByzD2i3R3M02StGwVyFWsJm1v4eyEBY3r8vP/V10Q0R8J0R75orEIvvwLUxU6Al1
	jz9WwHbTascrz/PBheLKRGZKRBPlSsc0G3ac/AZi2z+I2LdIvnfaIVV289/yzg==
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org>
 <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
 <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
Date: Wed, 20 Jul 2022 10:42:33 +0200
In-reply-to: <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
Message-ID: <87edygmas6.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool5: domain of xenomai.org designates 217.70.183.199 as permitted sender) client-ip=217.70.183.199; envelope-from=rpm@xenomai.org; helo=relay9-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=f1nIhAzi;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.199 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> On Thu, Jul 14, 2022 at 5:59 PM Sri Subramanian
> <sridhar.subramanian@gmail.com> wrote:
>>
>> On Thu, Jul 14, 2022 at 8:32 AM Philippe Gerum <rpm@xenomai.org> wrote:
>> >
> <snip>
>> >
>> > This patch may help:
>> > https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/2ad6b2207f9f1669f64f6816428a20e1bbd6357c
>> >
>> > Feedback on this fix welcome, so that we may assume the issue is closed.
>> >
>>
>
> Hello Philippe,
>
> As noted below, the fix doesn't crash the kernel.
>
> However, I observe this strange behavior with oob_sendmsg:
>
> 1. With oob-net-icmp, sending back ICMP echo responses, the pinging device
> only receives exactly 10 responses, then stops. oob-net-icmp continues to
> print on the console that it is sending responses.
>
> 2. If I just use oob_sendmsg to send a packet every second to the network and
> then run tshark on the receiving device, I see the same behavior -- 10 packets
> received and then nothing while the client continues to indicate it
> has successfully
> sent the packets.
>
> 3. Once you get into this condition of "non-sent-packets", the only
> way to get out
> is to turn off eth0.42, reset the values to oob_port and
> control_vlans, then turn on
> eth0.42. It is, weirdly, as if the oob links are restricted to only
> send 10 packets.
>
> Again, the environment is Raspberry PI/CM4 and I've tested with both
> 5.15 and 5.17.
>

I cannot reproduce such behavior (x86 <-> i.MX6q on the same switch),
the overnight test was still ok both sides after 14hrs. Does tshark see
the packets going out when observing from the sending device?

-- 
Philippe.
