Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E392919
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 14:31:32 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A15F8C145F
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 14:24:56 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5870820011
	for <xenomai@lists.linux.dev>; Thu, 21 Jul 2022 14:24:48 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 32681D803CA
	for <xenomai@xenomai.org>; Thu, 21 Jul 2022 14:24:47 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id D4AB7200005;
	Thu, 21 Jul 2022 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658413487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh6H1kMEu6uCX/b3tmt5z9c7XUE30b6YtmPf1YlnYI4=;
	b=WZtEMk9b6iTtoEXF/z+8Ayxn6KyIPOfkJQHSmWGtQ3uW8MuusdTs8w+qYB+BciZC/JZpjN
	fLoGKf9ND+VDMKM1kMfaLPyoknLFQwchBt8PHxkvzgzkyIfqMQ4BBVB90ZtH023RuZ88Xs
	HvUsQyngg3Gu+GeRfaPKd6D7CugwcFH3/dlMNwk9YC9VwpAka6QHtP9JnzNNVnuN5YhA6R
	R1nppa0o5+W82IHuXIV1txNKdTSOl/e0G79SK6lTOEHl9nFYZLdqnYLZmrXZc0zPzBklWO
	fP27JolFlVgG0rCZLm9/JEvjtWrFOjvsEIBXkesI9hS4W3RtAmiacT/QXXJE0Q==
References: <CAAm9oxrn5pTSPH_AqrZ_0QakrL1LDsAW2GfA=ckejhnYFPOrFA@mail.gmail.com>
 <87fsj3d827.fsf@xenomai.org>
 <CAAm9oxq0qzdxx+KnbROMCHgNvp-xEZ99O90omY4zOxXtxsEpsA@mail.gmail.com>
 <CAAm9oxqa0Rp3x3QS_oteS7PX35n4W8TYZu1=7y6U_QC5G-3S=w@mail.gmail.com>
 <87edygmas6.fsf@xenomai.org>
 <CAAm9oxqx-P9O7cONgeGwud0BvsSWok7itGzqSZdc7NRCmFLdyg@mail.gmail.com>
 <87tu7bk76a.fsf@xenomai.org>
 <CAAm9oxpbtX2qXHPxOGCQre14_7T7jZtDuN=b5U2sA2B_su6ARQ@mail.gmail.com>
 <87a692ewlf.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Sri Subramanian <sridhar.subramanian@gmail.com>
Cc: xenomai@xenomai.org
Subject: Re: Xenomai 4 / oob_sendmsg crashes kernel from tidbits/oob-net-icmp
Date: Thu, 21 Jul 2022 16:21:58 +0200
In-reply-to: <87a692ewlf.fsf@xenomai.org>
Message-ID: <8735euee6p.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass (spool5: domain of xenomai.org designates 217.70.178.232 as permitted sender) client-ip=217.70.178.232; envelope-from=rpm@xenomai.org; helo=relay12.mail.gandi.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=WZtEMk9b;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.178.232 as permitted sender) smtp.mailfrom=rpm@xenomai.org


Philippe Gerum <rpm@xenomai.org> writes:

> Sri Subramanian <sridhar.subramanian@gmail.com> writes:
>
>> On Wed, Jul 20, 2022 at 10:47 AM Philippe Gerum <rpm@xenomai.org> wrote:
>>>
>>>
>>> Ok. On my end, I'll connect a pi4 with the i.MX6, to add the GENET MAC
>>> module to the picture.
>>>
>>
>> It looks like the GENET MAC driver (or the interface) is the culprit.
>> For some reason, it
>> restricts the packets sent to 10 after every netif down/up toggle.
>>
>
> Weird. I'll trace that.
>

Confirmed, I can observe the exact same behavior with any board pinging
the pi4 here. 10 packets with proper ICMP reply, then the responder goes
south.

-- 
Philippe.
