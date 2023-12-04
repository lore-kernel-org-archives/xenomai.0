Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055815395
	for <xenomai@lists.linux.dev>; Mon,  4 Dec 2023 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cv6LHfO9"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231204060020107e1d6a8cde02bd6e
        for <xenomai@lists.linux.dev>;
        Mon, 04 Dec 2023 07:00:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UBt1xG0Bj16ICRnZgFZGshSOjyJ/bvTsesVzWwRqyHA=;
 b=cv6LHfO9W4rFJ4S+xyQ6T5R8Dy82cZOPp2ll3LKnKKkJjaUHvcJnwzjPBXMeASz+6Y9HWT
 FZL4Qy0kJ7vPIF0UQc0XsSAdbwhYLVn7q7ce8ZpkEIB6c2rhKki46tHk6DKpe/x9Uka3meHY
 JgpkFUaF4a6qiwiaHkbxnYy3b6LXE=;
Message-ID: <acfd97356e832f0160e16f135ddfc13a3e726906.camel@siemens.com>
Subject: Re: [PATCH v2,1/1] lib/psos/task.c: fix build with gcc >= 12
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 04 Dec 2023 07:00:19 +0100
In-Reply-To: <20231203221711.339018-1-fontaine.fabrice@gmail.com>
References: <20231203221711.339018-1-fontaine.fabrice@gmail.com>
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

Hi Fabrice,

On Sun, 2023-12-03 at 23:17 +0100, Fabrice Fontaine wrote:
> Fix the following build failure with gcc >=3D 12:
>=20

I'm on gcc 13 here and didn't spot this problem (so far). Is it really
gcc 12 that matters or some configure / compiler flag that makes the
difference?

> task.c: In function 't_start':
> task.c:398:16: error: 'ret' may be used uninitialized [-Werror=3Dmaybe-un=
initialized]
>   398 |         return ret;
>       |                ^~~
> task.c:364:13: note: 'ret' was declared here
>   364 |         int ret;
>       |             ^~~
> task.c: In function 't_resume':
> task.c:444:16: error: 'ret' may be used uninitialized [-Werror=3Dmaybe-un=
initialized]
>   444 |         return ret;
>       |                ^~~
> task.c:428:13: note: 'ret' was declared here
>   428 |         int ret;
>       |             ^~~
>=20
> Fixes:
>  - http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1=
f73a6ed8a

The Fixes: tag I know from kernel development is different and normally
points to git commits that introduced a regression. Not sure if we
(should) follow this convention in Xenomai as well.

I like the reference to your problem, but maybe we should change the
"syntax" a bit.

Btw: When following the URL I see Xenomai 3.0.10, that might explain
why I did not see the problem yet. This information is important for
Jan as well because this patch is then not targeting next but the
stable branch.

If that "analysis" is right there must be a difference between next and
the stable 3.0 branch that matters. Maybe we can get closer to next?

Best regards,
Florian

>=20
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
> Changes v1 -> v2 (after review of Jan Kiszka):
>  - Replace SUCCESS by ERR_OBJDEL
>=20
>  lib/psos/task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index f678be61d..cc7e5c9c4 100644
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -362,7 +362,7 @@ u_long t_start(u_long tid,
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret;
> +	int ret =3D ERR_OBJDEL;
> =20
>  	CANCEL_DEFER(svc);
> =20
> @@ -426,7 +426,7 @@ u_long t_resume(u_long tid)
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret;
> +	int ret =3D ERR_OBJDEL;
> =20
>  	CANCEL_DEFER(svc);
> =20
> --=20
> 2.42.0

