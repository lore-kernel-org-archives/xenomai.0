Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F26399
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 10:41:24 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230929104115392c564ccb1a0516a5
        for <xenomai@lists.linux.dev>;
        Fri, 29 Sep 2023 12:41:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DdjXnX/5LnVgGlMIUM8glxuGWNimHn5GEcm++aO9AFE=;
 b=qRKKxRXr4hZ+kwcsCKr3Sp/u+tiSOwPjJ3YLmMpBWCSdX+qZDos83HjSezQgFZW7jR5/kP
 //oGfeV9CGcQ7HZ3nFvVxaSxBUba98SE8uWMNmhRKhfxc2n5RGHcVfQATvD89EbsBG6wvD4k
 YUv+FKwklF0CAE/owuYoybhYkd1RY=;
Message-ID: <3429d1091991ec499009a88b080657d0a7640e8c.camel@siemens.com>
Subject: Re: accept after select for RTNet/TCP
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Fri, 29 Sep 2023 12:41:15 +0200
In-Reply-To: <759339022.2543916.1695899840518.JavaMail.zimbra@wolfram.com>
References: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com>
	 <10067eb6a762f8f468b5f81db9f49b825f3ea96e.camel@siemens.com>
	 <1723160879.2522128.1695880477176.JavaMail.zimbra@wolfram.com>
	 <759339022.2543916.1695899840518.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2023-09-28 at 06:17 -0500, Per Oberg wrote:
> ----- Den 28 sep 2023, p=C3=A5 kl 7:54, Per =C3=96berg pero@wolfram.com s=
krev:
>=20
> > ----- Den 27 sep 2023, p=C3=A5 kl 22:21, Florian Bezdeka florian.bezdek=
a@siemens.com
> > skrev:
>=20
> > > Hi Per,
>=20
> > > On Wed, 2023-09-27 at 10:13 -0500, Per Oberg wrote:
> > > > Hi
>=20
> > > > I'm currently porting parts of an application that uses some TCP du=
ring startup
> > > > to Xenomai. I have a working example of a TCP server but i cannot m=
ake the
> > > > "select" part work.
>=20
> > > > If I do
>=20
> > > > fd =3D __COBALT(accept(list_fd, (struct sockaddr *) &client_addr, &=
client_len)))
>=20
> > > The usage of __COBALT() should not be necessary, the Xenomai function
> > > wrapping will take care of redirecting the call to the cobalt world.
> > > (Assuming you are using the LDFLAGS and CFLAGS delivered by xeno-
> > > config)
>=20
> > > That allows you to compile the same code - but with different flags -
> > > for both worlds without modifications.
>=20
> > > > without the select part it works. If I do a select before it return=
s "Invalid
> > > > argument".
>=20
> > > I can remember that I saw something similar in the past. If I recall
> > > correctly there was an ordering problem. It somehow crashed when the
> > > first connection request came in before the accept() call happened, o=
r
> > > something in this direction. The socket state was somehow "corrupted"=
.
>=20
> > > I should have it on one of my TODO lists... Unable to find it right
> > > now.
>=20
> > > > The "select" part:
> > > > ------------------------------------
> > > > fd_set in_fds;
> > > > FD_ZERO(&in_fds);
> > > > FD_SET(list_fd, &in_fds);
> > > > int selRet =3D __COBALT(select(list_fd + 1, &in_fds, 0, 0, 0));
> > > > (FD_ISSET(list_fd, &in_fds))
> > > > {
> > > > printf("list_fd (%i) is in FDSET\n", list_fd);
> > > > }
> > > > ------------------------------------
>=20
> > > > The program works when compiled for regular linux.
> > > > Is select for TCP RTNet a no no ?
>=20
> > > select() should work as expected.
>=20
> > > Can you share a complete reproducer? That would simplify things and
> > > increases the chance that someone is able to look into it.
>=20
> > > Best regards,
> > > Florian
>=20
> > > > Best Regards
> > > > Per =C3=96berg
>=20
> > Hi Florian and thanks for answering
>=20
> > The explicit use __COBALT / __STD wrappers is for some of my code that =
sometimes
> > go on a real time socket and sometimes on a regular socket (depending o=
n the
> > destination). I think I found an issue when leaving it out for some spe=
cial
> > cases. (But it might have been the missing pselect that was the real is=
sue)
>=20
> > That said, I also use it to ensure that there are no missing syscalls w=
hen
> > debugging. E.g. I think I recall that pselect was missing in the implem=
entation
> > and that became apparent when putting __COBALT in front of it.
>=20
> > My issue is 100% reproducible (afaik) so no timing issues show up for m=
e in the
> > regard.
>=20
> > I can certainly share the code. My example is an adapted version of a T=
CP
> > Client/Server demo. I will put it on github if that would work?
>=20
> > A few other notes that came up during the porting:
>=20
> > 1. It seems like accept does not like beeing called with null pointers =
to client
> > address

That might be a bug, or a RT simplification. Would have to look into it
in more details. Jan, any idea?

>=20
> > 2. Accept returns the same socket number as the listen socket, and thus=
 closes
> > the socket when the connection closes. I guessed that this was a simpli=
fication
> > deemed ok for real time. This effectively makes the TCP server single c=
lient
> > because SOCK_REUSE is not supported, right?

I'm not familiar with that code yet. But yes, might be a simplification
for RT. Jan, any thoughts?

>=20
> > Best Regards
> > Per =C3=96berg
>=20
> The example code is now available on=20
>=20
> https://github.com/droberg/XenomaiTCP

Thanks! I found
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/34 meanwhile.
So we would be happy to take patches filling this gap. Are you
interested in working on that?

>=20
> Best Regards
> Per =C3=96berg

