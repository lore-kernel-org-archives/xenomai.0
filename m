Received: from relay-ext.wolfram.com (relay.wolfram.com [140.177.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DD286B1
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 11:17:27 +0000 (UTC)
Received: from relay-10-128.wolfram.com (relay.wolfram.com [10.128.2.101])
	by relay-ext.wolfram.com (Postfix) with ESMTPS id C5F1C5BF6;
	Thu, 28 Sep 2023 06:17:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay-ext.wolfram.com C5F1C5BF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wolfram.com; s=relay;
	t=1695899840; bh=fM+US27NIHg+W3c64EZ2kQqO30mJLPmZUWzjt4O3N28=;
	h=Date:From:To:Cc:In-Reply-To:References:From;
	b=EpYSeOyyuYRq6hk3t0YqSfrgIsFQc3vT8Wnkuudi1Hb70YWoTQi74Ji5a76C5gANu
	 fbiPSL6Dm2cs3BquKDAqbCKbT6362H1eGPUF+242ovtT69RJHkcWsBm1ReklCjbZ17
	 qrCG67PZfNsLJ2OH8ukufvDMtDjEVqkY97elM574=
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by relay-10-128.wolfram.com (Postfix) with ESMTPS id C1D5830004E;
	Thu, 28 Sep 2023 06:17:20 -0500 (CDT)
Received: from wrimail03.wolfram.com (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTPS id BD785100673;
	Thu, 28 Sep 2023 06:17:20 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 9FF661006C6;
	Thu, 28 Sep 2023 06:17:20 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 wrimail03.wolfram.com 9FF661006C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfram.com;
	s=E3ED0494-3FFA-11EB-8895-C5FFDA13CE33; t=1695899840;
	bh=fM+US27NIHg+W3c64EZ2kQqO30mJLPmZUWzjt4O3N28=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=epZbzMgu4FAjZu+FkFo2OvlBWmAnVli7KRMLjpNdVItiTUzMY/JEbaodV9vgI1T8F
	 C3ySKA/ZvXRKlF9xmDiA8B2rz5spMhFvnHBuf92If75vqB2tWGmZh+4xSUZBO+QVVI
	 Urz0ejqiGsw/8wX9V31Ze1QKuHePAV27U+Me5AOcohRVc9eLNs408bjJBFnkfR+qIX
	 fYpIn9WGYCrjX25AeXKLhYMJCnYj4yLG2o7aWx4mTjEmwT1FLyGHGP0amV5gbq235U
	 s+BtQjsM9INTSdgbwWM1vixI+atVgsPG3UB97vSrX+6fn51yD4qatAdtJ1vHaPSZqw
	 n7f1iGFeGm9Pw==
Received: from wrimail03.wolfram.com ([127.0.0.1])
	by localhost (wrimail03.wolfram.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g65CMolNX2Y3; Thu, 28 Sep 2023 06:17:20 -0500 (CDT)
Received: from wrimail03.wolfram.com (wrimail03.wolfram.com [10.128.1.208])
	by wrimail03.wolfram.com (Postfix) with ESMTP id 861A5100673;
	Thu, 28 Sep 2023 06:17:20 -0500 (CDT)
Date: Thu, 28 Sep 2023 06:17:20 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <759339022.2543916.1695899840518.JavaMail.zimbra@wolfram.com>
In-Reply-To: <1723160879.2522128.1695880477176.JavaMail.zimbra@wolfram.com>
References: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com> <10067eb6a762f8f468b5f81db9f49b825f3ea96e.camel@siemens.com> <1723160879.2522128.1695880477176.JavaMail.zimbra@wolfram.com>
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
Thread-Index: 77SNzzavjkaG6o0qW0y02w+u/DuBs7BuGmzH


----- Den 28 sep 2023, p=C3=A5 kl 7:54, Per =C3=96berg pero@wolfram.com skr=
ev:

> ----- Den 27 sep 2023, p=C3=A5 kl 22:21, Florian Bezdeka florian.bezdeka@=
siemens.com
> skrev:

> > Hi Per,

> > On Wed, 2023-09-27 at 10:13 -0500, Per Oberg wrote:
> > > Hi

> >> I'm currently porting parts of an application that uses some TCP durin=
g startup
> >> to Xenomai. I have a working example of a TCP server but i cannot make=
 the
> > > "select" part work.

> > > If I do

> > > fd =3D __COBALT(accept(list_fd, (struct sockaddr *) &client_addr, &cl=
ient_len)))

> > The usage of __COBALT() should not be necessary, the Xenomai function
> > wrapping will take care of redirecting the call to the cobalt world.
> > (Assuming you are using the LDFLAGS and CFLAGS delivered by xeno-
> > config)

> > That allows you to compile the same code - but with different flags -
> > for both worlds without modifications.

> >> without the select part it works. If I do a select before it returns "=
Invalid
> > > argument".

> > I can remember that I saw something similar in the past. If I recall
> > correctly there was an ordering problem. It somehow crashed when the
> > first connection request came in before the accept() call happened, or
> > something in this direction. The socket state was somehow "corrupted".

> > I should have it on one of my TODO lists... Unable to find it right
> > now.

> > > The "select" part:
> > > ------------------------------------
> > > fd_set in_fds;
> > > FD_ZERO(&in_fds);
> > > FD_SET(list_fd, &in_fds);
> > > int selRet =3D __COBALT(select(list_fd + 1, &in_fds, 0, 0, 0));
> > > (FD_ISSET(list_fd, &in_fds))
> > > {
> > > printf("list_fd (%i) is in FDSET\n", list_fd);
> > > }
> > > ------------------------------------

> > > The program works when compiled for regular linux.
> > > Is select for TCP RTNet a no no ?

> > select() should work as expected.

> > Can you share a complete reproducer? That would simplify things and
> > increases the chance that someone is able to look into it.

> > Best regards,
> > Florian

> > > Best Regards
> > > Per =C3=96berg

> Hi Florian and thanks for answering

> The explicit use __COBALT / __STD wrappers is for some of my code that so=
metimes
> go on a real time socket and sometimes on a regular socket (depending on =
the
> destination). I think I found an issue when leaving it out for some speci=
al
> cases. (But it might have been the missing pselect that was the real issu=
e)

> That said, I also use it to ensure that there are no missing syscalls whe=
n
> debugging. E.g. I think I recall that pselect was missing in the implemen=
tation
> and that became apparent when putting __COBALT in front of it.

> My issue is 100% reproducible (afaik) so no timing issues show up for me =
in the
> regard.

> I can certainly share the code. My example is an adapted version of a TCP
> Client/Server demo. I will put it on github if that would work?

> A few other notes that came up during the porting:

> 1. It seems like accept does not like beeing called with null pointers to=
 client
> address

> 2. Accept returns the same socket number as the listen socket, and thus c=
loses
> the socket when the connection closes. I guessed that this was a simplifi=
cation
> deemed ok for real time. This effectively makes the TCP server single cli=
ent
> because SOCK_REUSE is not supported, right?

> Best Regards
> Per =C3=96berg

The example code is now available on=20

https://github.com/droberg/XenomaiTCP

Best Regards
Per =C3=96berg
