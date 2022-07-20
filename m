Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E456AA0
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 17:47:35 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 7302F100004
	for <xenomai@lists.linux.dev>; Wed, 20 Jul 2022 17:47:27 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 75F0ED802D9
	for <xenomai@xenomai.org>; Wed, 20 Jul 2022 17:47:26 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 27E2C240006;
	Wed, 20 Jul 2022 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658339246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1FbXEkgXJSl5yqJCtrvv9+CFcc385iRjWESfGWZrGSY=;
	b=SiQmYQmNUK+QBL2smKCtLlethifpSHDaL4nZbRMYq8m9w92ZH23DDFhHmO3IvSOlV3Oq3t
	KYFXp+Tsgj37Kbl5wXUcsJTIpXYguQbNetc6kW1+aY3ZqV2xWjndKyOEK4ElU5qgr2DPCo
	QFmBXMqxYwIli60bftVQjPom7JW/Tx1uFK5ky0wZZ3K3QaF0remz+0d4IeTef1tQxPkb3U
	MEWf3nCiIJjjVXXKjkUlVXSms8WliL0VCykNxAApCqPD2nFuMp50Z6A2opEk8rsxat4oV3
	SgfI3f7DayyqABNpnESUYdwA6jbkADmhxVikFa3G+fX/hGlp2VhSz1e3dUzCpg==
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org>
 <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
 <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
 <87edygmas6.fsf@xenomai.org>
 <CAAm9oxqx-P9O7cONgeGwud0BvsSWok7itGzqSZdc7NRCmFLdyg@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
Date: Wed, 20 Jul 2022 19:41:08 +0200
In-reply-to: <CAAm9oxqx-P9O7cONgeGwud0BvsSWok7itGzqSZdc7NRCmFLdyg@mail.gmail.com>
Message-ID: <87tu7bk76a.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool5: domain of xenomai.org designates 217.70.183.193 as permitted sender) client-ip=217.70.183.193; envelope-from=rpm@xenomai.org; helo=relay1-d.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=SiQmYQmN;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.193 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Sri Subramanian <sridhar.subramanian@gmail.com> writes:

> I just re-ran the test and yes, tshark (on the pinging device) sees
> exactly 10 request+reply packets, and then, only request packets.
>

Ok, so for some reason, the sender is fine but the ICMP reply on the
receive side does not make it to the wire, although the ministack there
says it's all fine.

> Configuration: R-PI4 (pinger) -> CM4+IO (oob-net-icmp) on
> same switch, version 5.17+patch on both.
>

To be sure, is your 5.17 tree up to date EVL-wise, with all the patches
available so far for 5.15.y and 5.19?

> I'll try to scrounge around for a 32-bit ARM board I can test with
> to see if that's the differentiator.
>

Ok. On my end, I'll connect a pi4 with the i.MX6, to add the GENET MAC
module to the picture.

> Sri
>
> On Wed, Jul 20, 2022 at 1:46 AM Philippe Gerum <rpm@xenomai.org> wrote:
>>
>>
>> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>>
>> > On Thu, Jul 14, 2022 at 5:59 PM Sri Subramanian
>> > <sridhar.subramanian@gmail.com> wrote:
>> >>
>> >> On Thu, Jul 14, 2022 at 8:32 AM Philippe Gerum <rpm@xenomai.org> wrote:
>> >> >
>> > <snip>
>> >> >
>> >> > This patch may help:
>> >> > https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/2ad6b2207f9f1669f64f6816428a20e1bbd6357c
>> >> >
>> >> > Feedback on this fix welcome, so that we may assume the issue is closed.
>> >> >
>> >>
>> >
>> > Hello Philippe,
>> >
>> > As noted below, the fix doesn't crash the kernel.
>> >
>> > However, I observe this strange behavior with oob_sendmsg:
>> >
>> > 1. With oob-net-icmp, sending back ICMP echo responses, the pinging device
>> > only receives exactly 10 responses, then stops. oob-net-icmp continues to
>> > print on the console that it is sending responses.
>> >
>> > 2. If I just use oob_sendmsg to send a packet every second to the network and
>> > then run tshark on the receiving device, I see the same behavior -- 10 packets
>> > received and then nothing while the client continues to indicate it
>> > has successfully
>> > sent the packets.
>> >
>> > 3. Once you get into this condition of "non-sent-packets", the only
>> > way to get out
>> > is to turn off eth0.42, reset the values to oob_port and
>> > control_vlans, then turn on
>> > eth0.42. It is, weirdly, as if the oob links are restricted to only
>> > send 10 packets.
>> >
>> > Again, the environment is Raspberry PI/CM4 and I've tested with both
>> > 5.15 and 5.17.
>> >
>>
>> I cannot reproduce such behavior (x86 <-> i.MX6q on the same switch),
>> the overnight test was still ok both sides after 14hrs. Does tshark see
>> the packets going out when observing from the sending device?
>>
>> --
>> Philippe.


-- 
Philippe.
