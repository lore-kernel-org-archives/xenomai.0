Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389C13FE5
	for <xenomai@lists.linux.dev>; Sat,  3 Feb 2024 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707002348; cv=none; b=UaL3h7nthOD+zib4upUB+vhrne3RokxAbDnwmGtcv1/99erd0zS1ic6ndha0CKc+HE9JfEIsjoq7eCb6LOyW44/muzCDWehOvvXkSmJHwxpc/7ksnHdwaACba0Lju9vuqFrwUeSzGWb0qTY03KlhZ5eH3JAMZKukSsaxavo/PN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707002348; c=relaxed/simple;
	bh=U23vddkEYMOMPg6uB/nHDaEuEw8PEJVx/66CTHu+Dsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2bsun1Y19BvspTu2AbJvXmyJ/bqjARWcMCqzjgklEMhSeMuQQzRL+9CBuN3wTD7jV9ztPSM840KacF9YHBiyUIOPsJWyHKhegCTwXEpCt+ITrVj/wOx5ceCjgkws88RSJK2LvvrW68czy2KmBOXT01wzazPYHta8p7rZ3eKVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gzCzVNMy; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gzCzVNMy"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202402032238429596c824ad01799cd3
        for <xenomai@lists.linux.dev>;
        Sat, 03 Feb 2024 23:38:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dMsPuutatDiRygbZvAV6LIKICJ8JInlGKy5vuZr4CCc=;
 b=gzCzVNMyvF3XWow/2IWpNqfx5tBbL0V4+/MXO/sBifeBrV089NDP/OrxdM19az9T8T1VhI
 ZptiUe0K8I70IUrSyRrxGIDmSg8TvX7tenZcF2W44tTm3aJVr6POmY97RttBBEdgirSSHQJW
 wjjAcH2CEwZZd9Am1phDkmGi1y8RA=;
Message-ID: <6ab00f96df765db93faf2c3da14737e1f796a6a1.camel@siemens.com>
Subject: Re: [PATCH v1 5/7] compat support: cobalt/posix/syscall: Use
 syscall_get_arguments()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Date: Sat, 03 Feb 2024 23:38:41 +0100
In-Reply-To: <CAFLxGvwH5i=u9_7ffN_uwctBHOANFDe3SFfoL9mxYbkpQJx8sg@mail.gmail.com>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
	 <20240122160105.2452024-6-clara.kowalsky@siemens.com>
	 <CAFLxGvwH5i=u9_7ffN_uwctBHOANFDe3SFfoL9mxYbkpQJx8sg@mail.gmail.com>
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
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

Hi Richard,

On Fri, 2024-02-02 at 18:03 +0100, Richard Weinberger wrote:
> On Mon, Jan 22, 2024 at 6:51=E2=80=AFPM Clara Kowalsky
> <clara.kowalsky@siemens.com> wrote:
> >=20
> > Use the generic implementation for fetching the syscall arguments.
> >=20
> > Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > ---
> >  kernel/cobalt/posix/syscall.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscal=
l.c
> > index 6e1f15ea5..1d37cb279 100644
> > --- a/kernel/cobalt/posix/syscall.c
> > +++ b/kernel/cobalt/posix/syscall.c
> > @@ -584,7 +584,7 @@ restart:
> >          */
> >=20
> >         p =3D current;
> > -       pipeline_get_syscall_args(p, regs, args);
> > +       syscall_get_arguments(p, regs, args);
>=20
> Hmm, how does this worth with Xenomai arm32 ABI, do you fixup regs
> somewhere else?
> It places XENO_ARM_SYSCALL into r7 and uses r0 for the cobalt syscall id.
> So we're wasting one argument and they need shifting.

This is just a cleanup - in case I recall correctly.

Re-read patch 2 carefully. We changed the register usage, basically
aligned it with the Xenomai arm64 ABI.

r7 =3D __xn_syscode(op)
r0 =3D first argument

No register wasting, no argument shifting necessary. No?

Best regards,
Florian

>=20
> --=20
> Thanks,
> //richard

