Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6510E8
	for <xenomai@lists.linux.dev>; Sun, 21 May 2023 10:07:26 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023052110071801d490376c8c4f126c
        for <xenomai@lists.linux.dev>;
        Sun, 21 May 2023 12:07:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1kq/9d64rweePkQqwVxUAwD9BhhhIk4sHt4cI83aMGY=;
 b=UFPUtjKdeRlNekVNMIUtSCJYB0h0o3XeYRvTb1O0Ku108fLwKEjfGbEQp/a6hNcsAOPWBN
 6gXgDyzuF4GGezn4F9YQwN5qIZZLZI5TXl/XjiScvugMwcYelzrcKKrRZ/PdwJSQJjS8F9hu
 DdpxwLKKVv2RmVuVPUhfeeC+zYUCw=;
Message-ID: <3603f7e94608b074bdafe486f6b212201a8389d1.camel@siemens.com>
Subject: Re: [PATCH 0/3] y2038: Part three - support for select()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Sun, 21 May 2023 12:07:17 +0200
In-Reply-To: <7e217082-c9a3-b834-6c8f-41a456e5933c@siemens.com>
References: 
	<20230516-florian-y2038-part-three-v1-0-b140278b26c6@siemens.com>
	 <7e217082-c9a3-b834-6c8f-41a456e5933c@siemens.com>
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

On Wed, 2023-05-17 at 13:01 +0200, Jan Kiszka wrote:
> On 17.05.23 11:34, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > I'm trying to bring the remaining patches from my y2038 queue into Xeno=
mai=20
> > next/master branches. The full queue [1] holds ~7 patches. I'm trying t=
o=20
> > split that up to keep reviewing efforts low.
> >=20
> > This series brings y2038 support for select().
> >=20
> > select() is somehow special. Linux does not support a y2038 safe
> > implementation for select() itself. If the application needs y2038
> > support the application has to use something like the pselect() service=
.
> >=20
> > To make select() y2038 safe glibc wrapps select() and wires it to the=
=20
> > pselect() Linux service.
> >=20
> > Xenomai (cobalt) does not provide pselect() yet and it's not easy to=
=20
> > implement that. The reasons:
> >=20
> >   - The underlying xnsynch infrastructure is not prepared for waiting f=
or a
> >     combination of file descriptors and signals. (Let me know if I
> >     overlooked something!)
> >=20
> >   - Implementing pselect() would require up to 6 parameters that need t=
o
> >     be forwarded to the kernel. Xenomais current limit is 5.
> >=20
> > To get select() y2038 safe a "pselect64() like" service service is bein=
g
> > added. The signal part is skipped.
> >=20
> > The wrapper for __select64() will be added later and will convert=20
> > struct timeval to struct timespec64 in user space. This way select()=
=20
> > provided by libcobalt gets y2038 support but pselect() is still not=20
> > supported.
> >=20
> > Best regards,
> > Florian
> >=20
> > [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y203=
8
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > Florian Bezdeka (3):
> >       y2038: cobalt/posix/select: Refactor __cobalt_select()
> >       y2038: cobalt/posix/select: Adding pselect64
> >       y2038: testsuite/smokey/y2038: Adding tests for pselect64
> >=20
> >  include/cobalt/uapi/syscall.h                      |  1 +
> >  .../cobalt/include/asm-generic/xenomai/syscall.h   | 22 +++++
> >  kernel/cobalt/posix/clock.h                        |  6 +-
> >  kernel/cobalt/posix/io.c                           | 94 ++++++++++++++=
--------
> >  kernel/cobalt/posix/io.h                           |  8 +-
> >  kernel/cobalt/posix/syscall32.c                    | 24 +++++-
> >  kernel/cobalt/trace/cobalt-posix.h                 |  3 +-
> >  testsuite/smokey/y2038/syscall-tests.c             | 70 ++++++++++++++=
++
> >  8 files changed, 190 insertions(+), 38 deletions(-)
> > ---
> > base-commit: a74abe52269f191654b449357bd9aaa57f2cd75c
> > change-id: 20230516-florian-y2038-part-three-3093da9fecf8
> >=20
> > Best regards,
>=20
> Thanks, applied.

Hi Jan,

some testing over the weekend discovered a simple problem. The timeout
write back is skipped by accident. The fix is quite easy but I think we
should add a test to smokey as well. The testsuite did not report this
problem.=C2=A0

Should I resend or should I fix it on top of next? Asking because this
series has already been applied to next...

Best regards,
Florian

>=20
> Jan
>=20

