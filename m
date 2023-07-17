Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15FA927
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:46:27 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230717094625f70c6fde2c2da41dc7
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jul 2023 11:46:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hvLRa6G578ez19hq6pcbqNMwgIxOXp9cMcNAsqRMMbA=;
 b=ebhxnJ2lSFUntvCXhYrNlLxkKyvldHdtbTh7Lju3QaX4QNfJ8IJiFpQ5oaXv5uEatre1Rb
 CI1c0nROBXAwl6G/pA/hA8YOuO+5FFmUAZz5rFCAwnb168yX0zLKrCxMPH7AWA5p8we89Ykp
 pDt8ndMy9Vy12Qvnw3eHfFh6Ret4M=;
Message-ID: <fc4a4f7c128f2ddbf625c5d575ec8a85a217fcd7.camel@siemens.com>
Subject: Re: Missing asm/fpu/internal.h
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Tam=E1s_Pa=E1l?= <paal.tam@gmail.com>, 
	xenomai@lists.linux.dev
Date: Mon, 17 Jul 2023 11:46:24 +0200
In-Reply-To: <CAH0t8y3bbjFi8J2RekiYyiEWjfgfThR8ZYWa5JQE2jCM4jOVkg@mail.gmail.com>
References: 
	<CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
	 <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
	 <CAH0t8y3bbjFi8J2RekiYyiEWjfgfThR8ZYWa5JQE2jCM4jOVkg@mail.gmail.com>
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

On Mon, 2023-07-17 at 11:36 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > Dear All,
> >=20
> > I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1.
> > It works fine. I would like to upgrade to a more recent kernel, but I
> > run into a kernel compilation error very early:
> >=20
> >=20
> > In file included from ./include/asm-generic/xenomai/ Xenomai 3.2.x supp=
orts Linux up to 5.15. If you want to update to newer
> > Linux versions you have to use Xenomai from master branch. There is no
> > 3.3 release yet, but we're working on it. We already discussed that
> > "missing release" in our community call some days ago. There are some
> > features pending that we would like to integrate. So: stay tuned.
> >=20
> > Florian
>=20
> Thank you!
> Which kernel do you recommend to start working with. 6.1, or 6.4? Is
> the current master in a "working shape", or should I wait for a
> release?

6.1 is a LTS (Long Term Support) release, so it will stay for some
time, Xenomai support included.

6.4 is just a normal release and will vanish once 6.5. is out. We're
testing that in combination with latest Xenomai already (to make sure
we stay compatible) but we do not plan to support that specific release
over the long run.

Florian

>=20
> Thank you very much!
> Tamas
>=20
> Florian Bezdeka <florian.bezdeka@siemens.com> ezt =C3=ADrta (id=C5=91pont=
: 2023.
> j=C3=BAl. 17., H, 11:15):
> >=20
> > On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> > > Dear All,
> > >=20
> > > I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1=
.
> > > It works fine. I would like to upgrade to a more recent kernel, but I
> > > run into a kernel compilation error very early:
> > >=20
> > >=20
> > > In file included from ./include/asm-generic/xenomai/syscall.h:26,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from
> > > ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./include/xenomai/pipeline/pipeline.h=
:12,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./include/xenomai/cobalt/kernel/lock.=
h:26,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./include/xenomai/cobalt/kernel/sched=
.h:23,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from ./arch/x86/include/dovetail/irq.h:12,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from kernel/irq/pipeline.c:17:
> > > ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal error:
> > > asm/fpu/internal.h: No such file or directory
> > > =C2=A0=C2=A0=C2=A044 | #include <asm/fpu/internal.h>
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|          ^~~~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeline.o] Erro=
r 1
> > > make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error 2
> > > make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
> > >=20
> > >=20
> > > I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2.3 in all
> > > combinations, with the same result.
> > > In kernel version 5.15 the arch/x86/include/asm/fpu directory contain=
s
> > > an internal.h, but I cannot find this file from 5.19 and above. I
> > > believe this is the cause of the error.
> > >=20
> > > Please help me. What am I doing wrong?
> >=20
> > Xenomai 3.2.x supports Linux up to 5.15. If you want to update to newer
> > Linux versions you have to use Xenomai from master branch. There is no
> > 3.3 release yet, but we're working on it. We already discussed that
> > "missing release" in our community call some days ago. There are some
> > features pending that we would like to integrate. So: stay tuned.
> >=20
> > Florian
> >=20
> > >=20
> > > Thank you,
> > > Tamas
> > >=20
> >=20
>=20

