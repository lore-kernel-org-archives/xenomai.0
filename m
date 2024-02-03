Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2213AD9
	for <xenomai@lists.linux.dev>; Sat,  3 Feb 2024 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707000552; cv=none; b=U//qcALe/F0v1EI7stR054bmIt+JXKFxHSJUmJTzU7B8rPRFHwuqIKeEyw8UB+OYpkHFsJu/7kvZUiNFWNsK9Jk6i/bxWGMeGzHIf3c4QETL0vY1eko2rTKj+T5QxiDeuZcYf1bqyMUYGahMABoF4ZcQ/4/8mnl70mIGaw9GzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707000552; c=relaxed/simple;
	bh=YQws3zPyQFdgbLecyCVH7bnlRUA5UlIPdQdjIV6xXgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmysdITGHIAxQqLe/ASP63t8yvaAKhXhJO4+czWzgRhmDWsFW1JnjeiZFBsqeAwULueKkZEkO3yxd7ZGbO0OlgA48Yfmcm+lFiyfgwKSTAWdMtmAzn7nQHpLZEZU43corp1E84gglarhYAIoJvERhU199bcKuqkSsX1I9xgjh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LpkLRq7/; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LpkLRq7/"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240203223857a22261ad781e665ce5
        for <xenomai@lists.linux.dev>;
        Sat, 03 Feb 2024 23:38:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WXYU1b/KvD+GoKyh0MMrR2iPHtfxr92/2FJ+SVUnY6Y=;
 b=LpkLRq7/r8L4GgcJ5Cl46HWdcXkCk8VGfTJqJSGiFT5zgGx836n4+8cEdA9n7khmAszPW3
 DZiN3RdTNmweWvJz2yvUP+M2uJC4W5eIltYdHmyPPBRnz+zf78rzhPrO4ly+TKnFxeXXDGwk
 t/0t38MawYmm5lzut9PEpDORcKVVQ=;
Message-ID: <c3969282e89c3614958404f8be0f6f064acea9da.camel@siemens.com>
Subject: Re: [PATCH v1 0/7] Add 32-bit compat support for arm64 to xenomai
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Date: Sat, 03 Feb 2024 23:38:56 +0100
In-Reply-To: <CAFLxGvw+oSFroW3rY9FD9hnDKUbZ5E7w4is9Z1QCbODar5b6qQ@mail.gmail.com>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
	 <CAFLxGvw+oSFroW3rY9FD9hnDKUbZ5E7w4is9Z1QCbODar5b6qQ@mail.gmail.com>
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

On Fri, 2024-02-02 at 18:13 +0100, Richard Weinberger wrote:
> On Mon, Jan 22, 2024 at 6:55=E2=80=AFPM Clara Kowalsky
> <clara.kowalsky@siemens.com> wrote:
> >=20
> > Hi all,
> >=20
> > this series adds the 32-bit compat support for arm64 to xenomai 3.
> > It allows us to run arm(hf) applications on arm64 kernels.
> >=20
> > Best regards,
> > Clara Kowalsky
> >=20
> > Clara Kowalsky (7):
> >   compat support: cobalt: Move 32-bit compat files to generic
> >   compat support: cobalt/arm: Refactor registers
> >   compat support: cobalt/arm64: Add compat support and clean-up
> >   compat support: cobalt/arm64: Update ABI revision level
> >   compat support: cobalt/posix/syscall: Use syscall_get_arguments()
> >   compat support: lib/cobalt: Fix VFP detection for arm on arm64
> >   compat support: cobalt/arm64: Enable compat support for arm64
> >=20
> >  .../arch/arm/include/asm/xenomai/syscall.h    |   4 +-
> >  .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
> >  kernel/cobalt/arch/arm64/Kconfig              |   2 +-
> >  .../arch/arm64/include/asm/xenomai/syscall.h  |  10 +-
> >  .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
> >  .../arm64/include/asm/xenomai/uapi/features.h |   2 +-
> >  .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
> >  .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
> >  .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
> >  kernel/cobalt/posix/syscall.c                 |  16 +--
> >  kernel/cobalt/posix/syscall.h                 |   2 +-
> >  kernel/cobalt/trace/cobalt-posix.h            |   4 +-
> >  lib/cobalt/arch/arm/features.c                |   5 +
> >  .../arch/arm/include/asm/xenomai/syscall.h    |  65 ++++++-----
> >  14 files changed, 143 insertions(+), 173 deletions(-)
> >  delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscal=
l32.h
> >  delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall3=
2.h
> >  rename kernel/cobalt/{arch/x86/include/asm =3D> include/asm-generic}/x=
enomai/syscall32-table.h (94%)
>=20
> Do you changes really need to fixes on the dovtail side?
> I needed this one:

We had to fix one thing in Dovetail:

https://lore.kernel.org/xenomai/871qd4kxjp.fsf@xenomai.org/T/#t

That was applied to all affected branches already. With that applied
the Xenomai testsuite can successfully run the compat case.

I think the reason why we don't need this is in patch 2. We aligned the
Xenomai arm64 and arm(hf/32) ABI.

>=20
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 6f8fa0ed55fa..ef9c75296c0d 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -86,6 +86,12 @@ static void el0_svc_common(struct pt_regs *regs,
> int scno, int sc_nr,
>        int ret;
>=20
>        regs->orig_x0 =3D regs->regs[0];
> +
> +       if (scno =3D=3D 0x000F0042 && is_compat_task()) {
> +               scno =3D regs->regs[0] | __OOB_SYSCALL_BIT;
> +       }
> +
>        regs->syscallno =3D scno;
>=20
> So, basically what arm32 does in the entry code.
>=20
> --=20
> Thanks,
> //richard

