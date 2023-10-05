Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AC63A
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ELtovDpN"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202310050807537015d88cab70d729de
        for <xenomai@lists.linux.dev>;
        Thu, 05 Oct 2023 10:07:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fOgBS0GvN3jEkp7w7+1P5OiMDJI64Fkx4Nd6ODnnMww=;
 b=ELtovDpNtdLB6QWKNfGye52GtfMSg6AF6m3vE+IrEIs6Oc6LCngv6Dp7QepwJSz6GrkxRs
 CpDwq7/B+nl78Su7qAAg6QqRXUaqELUSyyDh5Hrme24+m2pRefB6L1Rl/VdtlsHDSIkrdN7e
 GyoMdLwWJclvNwh3QK2LKrFp9lJmc=;
Message-ID: <4fa78eef54fe310b9028ef7663cc6899a2afb6f2.camel@siemens.com>
Subject: Re: accept after select for RTNet/TCP
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
Date: Thu, 05 Oct 2023 10:07:53 +0200
In-Reply-To: <968364753.2878655.1696077736342.JavaMail.zimbra@wolfram.com>
References: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com>
	 <10067eb6a762f8f468b5f81db9f49b825f3ea96e.camel@siemens.com>
	 <1723160879.2522128.1695880477176.JavaMail.zimbra@wolfram.com>
	 <759339022.2543916.1695899840518.JavaMail.zimbra@wolfram.com>
	 <3429d1091991ec499009a88b080657d0a7640e8c.camel@siemens.com>
	 <968364753.2878655.1696077736342.JavaMail.zimbra@wolfram.com>
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

On Sat, 2023-09-30 at 07:42 -0500, Per Oberg wrote:
> ----- Den 29 sep 2023, p=C3=A5 kl 12:41, Florian Bezdeka florian.bezdeka@=
siemens.com skrev:
>=20
> > On Thu, 2023-09-28 at 06:17 -0500, Per Oberg wrote:
> > > ----- Den 28 sep 2023, p=C3=A5 kl 7:54, Per =C3=96berg pero@wolfram.c=
om skrev:
>=20
> > > > ----- Den 27 sep 2023, p=C3=A5 kl 22:21, Florian Bezdeka florian.be=
zdeka@siemens.com
> > > > skrev:
>=20
> > > > > Hi Per,
>=20
> > > > > On Wed, 2023-09-27 at 10:13 -0500, Per Oberg wrote:
> > > > > > Hi
>=20
> > > > > > I'm currently porting parts of an application that uses some TC=
P during startup
> > > > > > to Xenomai. I have a working example of a TCP server but i cann=
ot make the
> > > > > > "select" part work.
>=20
> > > > > > If I do
>=20
> > > > > > fd =3D __COBALT(accept(list_fd, (struct sockaddr *) &client_add=
r, &client_len)))
>=20
> > > > > The usage of __COBALT() should not be necessary, the Xenomai func=
tion
> > > > > wrapping will take care of redirecting the call to the cobalt wor=
ld.
> > > > > (Assuming you are using the LDFLAGS and CFLAGS delivered by xeno-
> > > > > config)
>=20
> > > > > That allows you to compile the same code - but with different fla=
gs -
> > > > > for both worlds without modifications.
>=20
> > > > > > without the select part it works. If I do a select before it re=
turns "Invalid
> > > > > > argument".
>=20
> > > > > I can remember that I saw something similar in the past. If I rec=
all
> > > > > correctly there was an ordering problem. It somehow crashed when =
the
> > > > > first connection request came in before the accept() call happene=
d, or
> > > > > something in this direction. The socket state was somehow "corrup=
ted".
>=20
> > > > > I should have it on one of my TODO lists... Unable to find it rig=
ht
> > > > > now.
>=20
> > > > > > The "select" part:
> > > > > > ------------------------------------
> > > > > > fd_set in_fds;
> > > > > > FD_ZERO(&in_fds);
> > > > > > FD_SET(list_fd, &in_fds);
> > > > > > int selRet =3D __COBALT(select(list_fd + 1, &in_fds, 0, 0, 0));
> > > > > > (FD_ISSET(list_fd, &in_fds))
> > > > > > {
> > > > > > printf("list_fd (%i) is in FDSET\n", list_fd);
> > > > > > }
> > > > > > ------------------------------------
>=20
> > > > > > The program works when compiled for regular linux.
> > > > > > Is select for TCP RTNet a no no ?
>=20
> > > > > select() should work as expected.
>=20
> > > > > Can you share a complete reproducer? That would simplify things a=
nd
> > > > > increases the chance that someone is able to look into it.
>=20
> > > > > Best regards,
> > > > > Florian
>=20
> > > > > > Best Regards
> > > > > > Per =C3=96berg
>=20
> > > > Hi Florian and thanks for answering
>=20
> > > > The explicit use __COBALT / __STD wrappers is for some of my code t=
hat sometimes
> > > > go on a real time socket and sometimes on a regular socket (dependi=
ng on the
> > > > destination). I think I found an issue when leaving it out for some=
 special
> > > > cases. (But it might have been the missing pselect that was the rea=
l issue)
>=20
> > > > That said, I also use it to ensure that there are no missing syscal=
ls when
> > > > debugging. E.g. I think I recall that pselect was missing in the im=
plementation
> > > > and that became apparent when putting __COBALT in front of it.
>=20
> > > > My issue is 100% reproducible (afaik) so no timing issues show up f=
or me in the
> > > > regard.
>=20
> > > > I can certainly share the code. My example is an adapted version of=
 a TCP
> > > > Client/Server demo. I will put it on github if that would work?
>=20
> > > > A few other notes that came up during the porting:
>=20
> > > > 1. It seems like accept does not like beeing called with null point=
ers to client
> > > > address
>=20
> > That might be a bug, or a RT simplification. Would have to look into it
> > in more details. Jan, any idea?
>=20
>=20
> > > > 2. Accept returns the same socket number as the listen socket, and =
thus closes
> > > > the socket when the connection closes. I guessed that this was a si=
mplification
> > > > deemed ok for real time. This effectively makes the TCP server sing=
le client
> > > > because SOCK_REUSE is not supported, right?
>=20
> > I'm not familiar with that code yet. But yes, might be a simplification
> > for RT. Jan, any thoughts?
>=20
>=20
> > > > Best Regards
> > > > Per =C3=96berg
>=20
> > > The example code is now available on
>=20
> > > https://github.com/droberg/XenomaiTCP
>=20
> > Thanks! I found
> > https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/34 meanwhile.
> > So we would be happy to take patches filling this gap. Are you
> > interested in working on that?
>=20
> Please elaborate. My kernel hacking experience is not great but I'd like =
to get=C2=A0
> more experience. Perhaps this is a good way of getting my hands dirty.=
=20
>=20
> Are there any ideas right now for what needs to be done, especially in te=
rms=C2=A0
> of testing and conformance? I would need to get started with smaller piec=
es=C2=A0
> to be able to get up and running properly.

A possible first step would be extending the smokey testsuite. Try
adding a simple client/server application sending some data around.

You already found some corner cases, testing them as well and fixing
the issues would be part of the journey. You would basically start in
user-land (from user perspective) and might end up in fixing
cobalt/rtdm infrastructure.

>=20
> > > Best Regards
> > > Per =C3=96berg
>=20
>=20
> Best Regards=20
> Per =C3=96berg

