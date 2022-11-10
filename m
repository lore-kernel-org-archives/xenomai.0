Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850C625
	for <xenomai@lists.linux.dev>; Thu, 10 Nov 2022 09:08:53 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 536A6C0007;
	Thu, 10 Nov 2022 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668071331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUrm4sMV+joLNqwdPuimySPz7zxPBrSHaCNJzd7LBOI=;
	b=A0YjpXixHXXSN2RzAzw9LUZZb+PN1sYbdP0XsWx8Djp/qFINujTrLe/8/7K4r0nGa5EBA0
	Q1Eif/cEvlYOMSDbrza8b9M9JfwAHugSjjDURRiprf2yfxoRoqunRCSUzY2wsN8c4hZibQ
	xCym2PuNO3o9NvF/hNHNsNjlyvEjXK2aYENn4KNo/QguFN1CZuf2ViAjW2BFgcpgViJs0S
	6X/YEpIY7sDoPdvV/jeluoOWAPq7wqXqx+m7eG16kdzWv89uXVYc0JQ+HlR2UY12yIgSYd
	7ML7pSUaihZptT5XqTHsytSNL51woMp9uKkKrr2bAjlJfrQz6KXWURh9aZ7MEQ==
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
 <VE1PR08MB4909620AE0E4EE0139B54276923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <f275bac0-492e-c8da-ea30-a48ebae505c4@siemens.com>
 <87iljoh1gd.fsf@xenomai.org>
 <d19b9dbf-9831-99ab-67bb-01d06b9b00f4@siemens.com>
 <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>,
 Richard Weinberger <richard@nod.at>
Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Date: Thu, 10 Nov 2022 10:00:33 +0100
In-reply-to: <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
Message-ID: <874jv7rxb2.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:

> Hello,
>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Mittwoch, 9. November 2022 11:39
>> To: Philippe Gerum <rpm@xenomai.org>
>> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>; Xenomai
>> <xenomai@lists.linux.dev>; Richard Weinberger <richard@nod.at>
>> Subject: Re: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
>>=20
>> CAUTION: External E-Mail !
>>=20
>> On 09.11.22 11:06, Philippe Gerum wrote:
>> >
>> > Jan Kiszka <jan.kiszka@siemens.com> writes:
>> >
>> >> On 09.11.22 08:31, Johannes Kirchmair wrote:
>> >>> Hello all,
>> >>>
>> >>> I just recently found the time to test this patch in the context of =
our
>> rt_signals.
>> >>> As a matter of fact it works quite well for us.
>> >>>
>> >>> So is there any intent/possibility to bring this upstream?
>> >>>
>> >>> I also did some similar changes for arm64. As we also use imx8 board=
s.
>> >>> If there is interest in those, I could post them.
>> >>
>> >> Yes, please share. Then we can continue with proposing it for the lat=
est
>> >> dovetail port (6.1 now).
>> >>
>> >
>> > There is a slightly different approach which expresses the intent of
>> > that notification hook Dovetail-wise:
>> >
>> > - if the real-time core switches in-band upon notification, then the
>> >   in-band kernel code may assume that all regular fixups need to be
>> >   applied next. This is the common case for most traps.
>> >
>> > - if the real-time core stays on the out-of-band stage upon
>> >   notification, then the in-band kernel code should assume that all
>> >   required fixups were done from that stage already, returning asap fr=
om
>> >   the outer trap handler.
>> >
>> > This gives the same flexibility than by expecting the hook to return a
>> > continuation status, but makes sure that regular fixups cannot be
>> > bypassed when/if switching to in-band mode is required to handle the
>> > trap. Rationale: the regular in-band trap handlers know better about t=
he
>> > way to deal with those events from in-band context.
>> >
>
> I like that idea because as I was looking at the arm code, I was not sure=
 what would happen if we are out of band but=20
> indicate that the kernel should handle the exception. With your idea that=
=E2=80=99s not possible.
>
> Will have a look at my arm64 patch and try to adapt it.
>

Ok, so since the idea is generally agreed, I'll push the x86 and arm
support for this in a couple of days.

--=20
Philippe.
