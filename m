Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947931;
	b=Dvrn04VteKtIBoxfPruYIxF+tHYbqdAnWL3Rc10Y3nPx3Ku2H590rh4Uvmtm/Hhj080/
	 ClyP5edSM+llCh4aL4NjyeNgzar3YiZadgbLIDn7OVFhyGSvSXKlOAjyYBY/2kLfBZSBf
	 mVLXCpxRUGCy7MX98h0WQaOQj3up9dTP0DR5q7nhLjqoAQa4ar534jVV94DoxUzrP/Obi
	 bbdC1OEKPBEd8z4Fize5NooTRWRVvym+oYX5lINJPesOZZtPV1eXRSLt0Mgm7r+pJeD34
	 784sbasgvVAtIzxKhztBcUjW4G4K+JKSQotm8O9RiYk5st+h47jYQ97YoTS69rUHhEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947931;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=dJFq2FiBxCgrTzPWzrx7Apx7Tfa1ZrDVmKq7LLmvh04=;
	b=WvOqqc9wR8JnAC8yB/0HDyew0q5TR0XWn4QdVh/n1eWFVeY3xn1bq4uLdYamzabU7IXM
	 bB0d/H4dskMtD+nGt2adyNIFRHffzdkNiUyWGJL/95ULvEy1+N0an0OuD4FUvne9E+Tmv
	 zKw/CPiKGEjRqj5GEcAL1IiJTVWBClEbk6blTciJhRF/u922RBfgQCnPl9xLOE0c/cSJJ
	 v/kRPmjT1QjkBorChxbAYKbu11SG8fCNUSOGwFrDkGGpJx5q2wYe+sEMBy+wPnyEtVhA8
	 Ci4mOZ5vwmUy8GNKco9YLGaTQwBd+jT0PT7QkiUgBpRq8itPotEmSJZri7IOsKEsYmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Ue2w5laA;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A358606A31C
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 20:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A358606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Ue2w5laA
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202611172038395c0c1365230002078d
        for <xenomai@lists.linux.dev>;
        Tue, 17 Nov 2026 21:38:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dJFq2FiBxCgrTzPWzrx7Apx7Tfa1ZrDVmKq7LLmvh04=;
 b=Ue2w5laAdGbqsXVl9Y2mBtpaNCs3m5dRDd8h70+PL3tZQMnzjjg8RocSHkE2cR0ddqqqzR
 UqDzabQ8ird11GTJ8SbsLE0PWuU8vx6CeZxneSf6DsoA1avW9GjpgChWurRJpi8/mnUd0ZO9
 O02IJEoCdZlJ8MFB3a6RYK4onsR13zJ/l51MbU9ISiQ9BEBOg2HlbhzpMr4MDyvciSRlAoMb
 pgq6WIpZ3LDjvG3pIXnTkBaqUJbFtLLG/0NeldUhG99blT1w4eYjxcMYxLWUuT78ErYKKjfd
 gML/Mhyo3IszDwfOmbHneFXnOfwEdj2zJSEDVetBUn5kAa/j9ERv6Wbw==;
Message-ID: <6fca88474f2e6ae11638f75e85aee0b211690fc2.camel@siemens.com>
Subject: Re: [PATCH dovetail 3/5] riscv: dovetail: do not nest the unknown
 trap handler in software checks
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Tue, 17 Nov 2026 21:38:34 +0100
In-Reply-To: <20261117123925.597027-4-tobias.schaffner@siemens.com>
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
	 <20261117123925.597027-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-11-17 at 13:39 +0100, Tobias Schaffner wrote:
> do_trap_software_check() hands a user mode trap which is no CFI
> violation to the whole do_trap_unknown() handler, which enters from
> user mode and notifies the companion core again on the same frame.
> The nested mark_trap_exit() unwinds the trap before the outer handler
> is done.

If I get this right it's about nesting of those traps, or
trap_entry/exit() calls.

That problem should be solved by the series posted by Jan.

But: We shouldn't inform the co-kernel twice for the same problem. I
guess we don't once the nesting is probably solved. Isn't it?

>=20
> Call do_trap_error() as do_trap_unknown() would.
>=20
> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/kernel/traps.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index a8e37ec27cc2..dddb30711440 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -473,7 +473,8 @@ asmlinkage __visible __trap_section void do_trap_soft=
ware_check(struct pt_regs *
>  =09=09if (mark_trap_entry(regs)) {
>  =09=09=09/* not a cfi violation, then merge into flow of unknown trap ha=
ndler */
>  =09=09=09if (!handle_user_cfi_violation(regs))
> -=09=09=09=09do_trap_unknown(regs);
> +=09=09=09=09do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->epc,
> +=09=09=09=09=09      "Oops - unknown exception");
> =20
>  =09=09=09mark_trap_exit(regs);
>  =09=09}
> --=20
> 2.53.0
