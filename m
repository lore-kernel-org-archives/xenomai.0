Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5EC378822
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227050; cv=none; b=Q6+EvohcXwu0DPaZcED+xLk0yKl3sdXuhMnYXJgHDAlVdt2J0EAHln8ProOxcdi73cEqETNaGHDgdfTZ0TkxmbkGDIpk/kxAex/xq5Ggo+smY0odfo32d34V4jXaI2Kl3gARKTOM2YwL1P4zqT4dLzsWnbnmXdW3pESI24P0Aes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227050; c=relaxed/simple;
	bh=i526ASp2oiUiz1jC+BAORkFs4fSFbJSTN/LSBWGm6yY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U8ecRMgamBqCqmDxila9u23zT7xOKoch7xGwPCWl0heVOadBCPZfPVi4sGTj4hZfz3PxSf2X8zN92M+H05aRmYLmxT9wUHJGnwKO0J34n0lNiD1p8lvJ2vYLqu0riD9/eKkmwduGgEHTszG8z1HuUsKPE2TuFli0DaClt9Meo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=l5uhBfml; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="l5uhBfml"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260508075713e9c7b75b540002071a
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 09:57:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wNMmwZIw6Z0U2aBY8sOGoB9zO5vH9fZBPmAjj07ecb4=;
 b=l5uhBfmlIvsHPMU/s12cNPSW+fcfP+kaqa0CKzs2unldijpn0gsuuRv0+yfFxk24oHW7Ko
 FxBK3XDPgC//97EJUkPX4GuIU+DOLt/kLRNPnxX3qks7Iv+4qQ+fU7gYJ3Qffw1DKc+4DBtt
 udtfeQXQetKplDnpPxr9fvtvkRsLonYsGu6AFLK26UvKZG+hSa5JODoSDNCuoU/iRwf+zfHS
 e91ygjwYzNx4RSFWxlmFo7wmd3RivqlSttcijgZTu2QRzcMsZodFx5VIgMJRkKGCUVpTCJn3
 IRWsani4NQt2a/4CjwVLmA3aRL0d73ZRFvRW0B/pcvg18NQ3H7+0y3NQ==;
Message-ID: <89fd996a355fbaefcb8d43f078107bd727a5ebf8.camel@siemens.com>
Subject: Re: [PATCH] testsuite/smokey/psostests: Avoid timeouts in over
 virtual environments
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Fri, 08 May 2026 09:57:12 +0200
In-Reply-To: <a256fa26-71db-46a8-88bd-c4df74d28363@siemens.com>
References: <a256fa26-71db-46a8-88bd-c4df74d28363@siemens.com>
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

On Mon, 2026-05-04 at 09:33 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This was seen over QEMU:
>=20
> 2026-05-03T09:42:36 [2] at mq-3.c:31
> 2026-05-03T09:42:36    0\"071.079| BUG in __traceobj_assert_failed(): [TS=
KA] trace assertion failed:
> 2026-05-03T09:42:36               mq-3.c:32 =3D> \"ret =3D=3D 0\"
> 2026-05-03T09:42:36 [1] at mq-3.c:27
> 2026-05-03T09:42:36 test psostests_mq3 failed: 256
>=20
> It's most likely that we ran into a timeout here due to QEMU not being
> able to deliver the messages to all receivers in time. Just wait
> infinitely in such cases to avoid spurious testsuite errors.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Was not worth to bother the AI in this case.
>=20
>  testsuite/smokey/psostests/mq-3.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/testsuite/smokey/psostests/mq-3.c b/testsuite/smokey/psostes=
ts/mq-3.c
> index 1171a70544..4b6f2dcf35 100644
> --- a/testsuite/smokey/psostests/mq-3.c
> +++ b/testsuite/smokey/psostests/mq-3.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
>  #include <copperplate/traceobj.h>
>  #include <psos/psos.h>
> =20
> @@ -12,6 +14,8 @@ static int tseq[] =3D {
> =20
>  static u_long tidA, tidB, qid;
> =20
> +static bool on_vm;
> +
>  static void task_A(u_long a0, u_long a1, u_long a2, u_long a3)
>  {
>  	u_long msgbuf[4];
> @@ -27,7 +31,7 @@ static void task_A(u_long a0, u_long a1, u_long a2, u_l=
ong a3)
>  	traceobj_mark(&trobj, 1);
> =20
>  	for (n =3D 0; n < 3; n++) {
> -		ret =3D q_receive(qid, Q_WAIT, 10, msgbuf);
> +		ret =3D q_receive(qid, Q_WAIT, on_vm ? 0 : 10, msgbuf);
>  		traceobj_mark(&trobj, 2);
>  		traceobj_assert(&trobj, ret =3D=3D SUCCESS);
>  		traceobj_assert(&trobj, msgbuf[0] =3D=3D n + 1);
> @@ -56,7 +60,7 @@ static void task_B(u_long a0, u_long a1, u_long a2, u_l=
ong a3)
>  	traceobj_mark(&trobj, 4);
> =20
>  	for (n =3D 0; n < 3; n++) {
> -		ret =3D q_receive(qid, Q_WAIT, 10, msgbuf);
> +		ret =3D q_receive(qid, Q_WAIT, on_vm ? 0 : 10, msgbuf);
>  		traceobj_mark(&trobj, 5);
>  		traceobj_assert(&trobj, ret =3D=3D SUCCESS);
>  		traceobj_assert(&trobj, msgbuf[0] =3D=3D n + 1);
> @@ -75,6 +79,8 @@ int main(int argc, char *const argv[])
>  	u_long args[] =3D { 1, 2, 3, 4 }, msgbuf[4], count;
>  	int ret, n;
> =20
> +	on_vm =3D argc > 1 && strcmp(argv[1], "--vm") =3D=3D 0;
> +

That is the synchronization point to the other thread / patch. I'm quite
sure this never worked as expected. Looking at psostest.c, --vm is never
set.

The answer to the question in the other thread is probably: Yes, there
were issues with this test on VMs.

Let me try to fix the cmdline argument forwarding.

>  	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
> =20
>  	ret =3D q_create("QUEUE", Q_NOLIMIT, 0, &qid);
> --=20
> 2.47.3
