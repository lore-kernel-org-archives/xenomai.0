Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4391C2B
	for <xenomai@lists.linux.dev>; Sat, 30 Sep 2023 12:42:25 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id CDBC06044;
	Sat, 30 Sep 2023 07:42:17 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com CDBC06044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1696077737; bh=HmydHPtFZLf6Wyo7DHhT0v4b/uOswpN2AZdNc6i7ojc=;
	h=Date:From:To:In-Reply-To:References:From;
	b=1im6SHN33mpYUPU5odEGDd2TkNVMJrr13fi6Mq6GFazO6/lOdAeLmnBR80WkflsLr
	 w7kTfP6u3pNJy8qmv+EVnLAWGXiUbOv2Lcrmy+GeaNQRqDPMQYQT2ZhzaCEfGZpY3W
	 f21iWmCsrqpzUm4hvLCKfXjNghgH03tKMf6HyLm8=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id AA49430004E;
	Sat, 30 Sep 2023 07:42:17 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id 66F97100671;
	Sat, 30 Sep 2023 07:42:17 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 0FA451006C2;
	Sat, 30 Sep 2023 07:42:16 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 0FA451006C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1696077737;
	bh=HmydHPtFZLf6Wyo7DHhT0v4b/uOswpN2AZdNc6i7ojc=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=HOXpHJOaojPLZ2HAWsa2QZUY7cCUdY2mKOA+1TYl3J5YH7fDzOEgnZ5uLSbd71yw7
	 ZD6l8lTQIlRFHlesjxlJSiYfL23bY3lx0YPQqJhQgKEiZ63BOiZspwzluYCtirMwHL
	 ZQpYnCGH9sMVNtG1qPVOV/RwyQEynXIdhE8e9kuH1n17yeoOwsVsmA7JFjF2ciNkKK
	 EUWUztdIVuOlwVVIgzaBSQ71og5hZJW7H9RYv+57gVfSm7b47Y8FHoBzWvwPpXqglk
	 SYXlcn1Tme1R/4ZFSxN2dv5QqRw+eVGotx2rnQoSp8woWUKWwt3hXcMt2ZSs9WVfpW
	 jp5VeqdEM8rSA==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BHeIVwO7Kpph; Sat, 30 Sep 2023 07:42:16 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 83A28100671;
	Sat, 30 Sep 2023 07:42:16 -0500 (CDT)
Date: Sat, 30 Sep 2023 07:42:16 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Message-ID: <968364753.2878655.1696077736342.JavaMail.zimbra@wolfram.com>
In-Reply-To: <3429d1091991ec499009a88b080657d0a7640e8c.camel@siemens.com>
References: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com> <10067eb6a762f8f468b5f81db9f49b825f3ea96e.camel@siemens.com> <1723160879.2522128.1695880477176.JavaMail.zimbra@wolfram.com> <759339022.2543916.1695899840518.JavaMail.zimbra@wolfram.com> <3429d1091991ec499009a88b080657d0a7640e8c.camel@siemens.com>
Subject: Re: accept after select for RTNet/TCP
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [46.59.13.250]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC116 (Linux)/9.0.0_GA_4478)
Thread-Topic: accept after select for RTNet/TCP
Thread-Index: jPKbEgFhS626qNsKxMD8ZyoZNbsUhA==


----- Den 29 sep 2023, p=C3=A5 kl 12:41, Florian Bezdeka florian.bezdeka@si=
emens.com skrev:

> On Thu, 2023-09-28 at 06:17 -0500, Per Oberg wrote:
> > ----- Den 28 sep 2023, p=C3=A5 kl 7:54, Per =C3=96berg pero@wolfram.com=
 skrev:

> > > ----- Den 27 sep 2023, p=C3=A5 kl 22:21, Florian Bezdeka florian.bezd=
eka@siemens.com
> > > skrev:

> > > > Hi Per,

> > > > On Wed, 2023-09-27 at 10:13 -0500, Per Oberg wrote:
> > > > > Hi

> > > > > I'm currently porting parts of an application that uses some TCP =
during startup
> > > > > to Xenomai. I have a working example of a TCP server but i cannot=
 make the
> > > > > "select" part work.

> > > > > If I do

> > > > > fd =3D __COBALT(accept(list_fd, (struct sockaddr *) &client_addr,=
 &client_len)))

> > > > The usage of __COBALT() should not be necessary, the Xenomai functi=
on
> > > > wrapping will take care of redirecting the call to the cobalt world=
.
> > > > (Assuming you are using the LDFLAGS and CFLAGS delivered by xeno-
> > > > config)

> > > > That allows you to compile the same code - but with different flags=
 -
> > > > for both worlds without modifications.

> > > > > without the select part it works. If I do a select before it retu=
rns "Invalid
> > > > > argument".

> > > > I can remember that I saw something similar in the past. If I recal=
l
> > > > correctly there was an ordering problem. It somehow crashed when th=
e
> > > > first connection request came in before the accept() call happened,=
 or
> > > > something in this direction. The socket state was somehow "corrupte=
d".

> > > > I should have it on one of my TODO lists... Unable to find it right
> > > > now.

> > > > > The "select" part:
> > > > > ------------------------------------
> > > > > fd_set in_fds;
> > > > > FD_ZERO(&in_fds);
> > > > > FD_SET(list_fd, &in_fds);
> > > > > int selRet =3D __COBALT(select(list_fd + 1, &in_fds, 0, 0, 0));
> > > > > (FD_ISSET(list_fd, &in_fds))
> > > > > {
> > > > > printf("list_fd (%i) is in FDSET\n", list_fd);
> > > > > }
> > > > > ------------------------------------

> > > > > The program works when compiled for regular linux.
> > > > > Is select for TCP RTNet a no no ?

> > > > select() should work as expected.

> > > > Can you share a complete reproducer? That would simplify things and
> > > > increases the chance that someone is able to look into it.

> > > > Best regards,
> > > > Florian

> > > > > Best Regards
> > > > > Per =C3=96berg

> > > Hi Florian and thanks for answering

> > > The explicit use __COBALT / __STD wrappers is for some of my code tha=
t sometimes
> > > go on a real time socket and sometimes on a regular socket (depending=
 on the
> > > destination). I think I found an issue when leaving it out for some s=
pecial
> > > cases. (But it might have been the missing pselect that was the real =
issue)

> > > That said, I also use it to ensure that there are no missing syscalls=
 when
> > > debugging. E.g. I think I recall that pselect was missing in the impl=
ementation
> > > and that became apparent when putting __COBALT in front of it.

> > > My issue is 100% reproducible (afaik) so no timing issues show up for=
 me in the
> > > regard.

> > > I can certainly share the code. My example is an adapted version of a=
 TCP
> > > Client/Server demo. I will put it on github if that would work?

> > > A few other notes that came up during the porting:

> > > 1. It seems like accept does not like beeing called with null pointer=
s to client
> > > address

> That might be a bug, or a RT simplification. Would have to look into it
> in more details. Jan, any idea?


> > > 2. Accept returns the same socket number as the listen socket, and th=
us closes
> > > the socket when the connection closes. I guessed that this was a simp=
lification
> > > deemed ok for real time. This effectively makes the TCP server single=
 client
> > > because SOCK_REUSE is not supported, right?

> I'm not familiar with that code yet. But yes, might be a simplification
> for RT. Jan, any thoughts?


> > > Best Regards
> > > Per =C3=96berg

> > The example code is now available on

> > https://github.com/droberg/XenomaiTCP

> Thanks! I found
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/34 meanwhile.
> So we would be happy to take patches filling this gap. Are you
> interested in working on that?

Please elaborate. My kernel hacking experience is not great but I'd like to=
 get more experience. Perhaps this is a good way of getting my hands dirty.=
=20

Are there any ideas right now for what needs to be done, especially in term=
s of testing and conformance? I would need to get started with smaller piec=
es to be able to get up and running properly.

> > Best Regards
> > Per =C3=96berg


Best Regards=20
Per =C3=96berg
