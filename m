Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886261A589
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 20:21:39 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230927202136206a1dcb579e29b09c
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 22:21:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zjjzvASdw8EI6UYyHf9DtMkxRxqUBIVXMjjm19+aiUQ=;
 b=jjSUOBNKCkB1XAmkYqQHKonCxyyjYUc77qbq0Eppi3HIHSBU1+m3lVwHXZ94zjMn1WA7rv
 F5lanA2oaJNLuV5DClkkXyjrJi/+8NlP9yNeWKbRQtiH7SIV82JPqqFrfuoZ7n3odDG26wMk
 PtAVYoRwNUYshGloYNQH+KxX4ELGY=;
Message-ID: <10067eb6a762f8f468b5f81db9f49b825f3ea96e.camel@siemens.com>
Subject: Re: accept after select for RTNet/TCP
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Per Oberg <pero@wolfram.com>, xenomai@lists.linux.dev
Date: Wed, 27 Sep 2023 22:21:27 +0200
In-Reply-To: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com>
References: <1477790382.2402907.1695827633513.JavaMail.zimbra@wolfram.com>
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

Hi Per,

On Wed, 2023-09-27 at 10:13 -0500, Per Oberg wrote:
> Hi=20
>=20
> I'm currently porting parts of an application that uses some TCP during s=
tartup to Xenomai. I have a working example of a TCP server but i cannot ma=
ke the "select" part work.
>=20
> If I do=20
>=20
> fd =3D __COBALT(accept(list_fd, (struct sockaddr *) &client_addr, &client=
_len)))

The usage of __COBALT() should not be necessary, the Xenomai function
wrapping will take care of redirecting the call to the cobalt world.
(Assuming you are using the LDFLAGS and CFLAGS delivered by xeno-
config)

That allows you to compile the same code - but with different flags -
for both worlds without modifications.

>=20
> without the select part it works. If I do a select before it returns  "In=
valid argument".=20

I can remember that I saw something similar in the past. If I recall
correctly there was an ordering problem. It somehow crashed when the
first connection request came in before the accept() call happened, or
something in this direction. The socket state was somehow "corrupted".

I should have it on one of my TODO lists... Unable to find it right
now.

> The "select" part:
> ------------------------------------
> fd_set in_fds;
> FD_ZERO(&in_fds);
> FD_SET(list_fd, &in_fds);
> int selRet =3D __COBALT(select(list_fd + 1, &in_fds, 0, 0, 0));
> (FD_ISSET(list_fd, &in_fds))
> {
>   printf("list_fd (%i)  is in FDSET\n", list_fd);
> }
> ------------------------------------
>=20
> The program works when compiled for regular linux.
> Is select for TCP RTNet a no no ?
>=20

select() should work as expected.

Can you share a complete reproducer? That would simplify things and
increases the chance that someone is able to look into it.

Best regards,
Florian

>=20
> Best Regards
> Per =C3=96berg=20
>=20
>=20

