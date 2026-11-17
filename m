Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942993;
	b=xyypn0bXo/cZsA97Xl81Ir8s1wvZOwv+B2EvHux1jJtaEE3Hxn6DH3NXgo3TSfFi92Xo
	 o+P6gXmSZp719YpDQHoyq3ye3B2lZLNsdF6ttyJSyMHgfs1s2Jg2MnzI3CvPExcbxuzaH
	 xWtgtc3vCR9df3uaZkHZF2IRCHAsyxQ2yLKPs4JxpqXBOZnBPzjATi7WdtXG7s89XqO2e
	 4oSczbyrW/cQYCzv0Tz61UR/zBV6/CtfAkTQZNCzq/KZA74QLCjER/w1K+jfTTCOPlfg+
	 AA4ilUyAQivXdlloZnGg9kj3SwEWpvvymFWxK8cuDLPG+Tqfu1oQEjPFSfolER4WacA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942993;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=XLh+f9KUUbmBqOAyA9q845/ygmyL/jzUVG2A5HhG9X4=;
	b=0QsgtdVBGX3CZkFY+96KKQj6ORE1GL0z2WFpCvWlc7cJVSddgQzUNyWm12UK2uxz/ktc
	 4GUTKsTG61H9SsbpA/HqnYK1P5KFsOvNdH+qOXWx6xKilMbBqlwwLLPihh0mHRV8HwP5h
	 DLHZHu5JG05kx1NDQt7x3KEDMgwfFYVvXtBvyRR9NOngK5hhye2hANoeRX6feyJG5kz+D
	 q0P/sYpEfexJD3R8zW1D/TlmVKtDVPuD1smJB53DlwGPIR5iBcb7KQ602j6RWLjD1+kSP
	 c6J8zSs8lZC/n0QFxX8UOT9yR5gu2fhfv3osqLaln3KRKBTn78WT1uItimY9upESZlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=IVQG8X5W;
	arc=none smtp.remote-ip=185.136.65.228
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E3606A32F
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 19:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359E3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=IVQG8X5W
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202611171916226feda85b2f000207ab
        for <xenomai@lists.linux.dev>;
        Tue, 17 Nov 2026 20:16:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XLh+f9KUUbmBqOAyA9q845/ygmyL/jzUVG2A5HhG9X4=;
 b=IVQG8X5WE/tfnhbteOzzGeU4EeTFjxIwFWkit1Qm180JTmXjSEDrIkCbjym1L3uX7HErzD
 AY+ndURVCSX5Lh+3T2+Zo8qB9d8CYV/o8xSSPrw3Lz9yhFdVHWG6zOrrx1expWAvPt2e02oU
 K+MV/HwZrMYj7+VKxXrlnGqGkb49DggeYbfbRpmnJ1C11j1TEZcPx+frEl7Gi/C9P0bpti0J
 6l28v7c0JqfF1wS13jP1/BmLlLp0o5XS/ujNJgo47VsSC0H9BFiu/fbdbdb5HBlGyzwyO7MR
 f0j/O82PCoq5L0V6ZAWup32mKdSjRgXfvY4gxs9F8xFRGsqO/wxi1Uig==;
Message-ID: <72d9742fd8baa9ea9735d241af0b738be56e85bc.camel@siemens.com>
Subject: Re: [PATCH dovetail 0/5] riscv: dovetail: trap handling fixes
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Tue, 17 Nov 2026 20:16:22 +0100
In-Reply-To: <20261117123925.597027-1-tobias.schaffner@siemens.com>
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
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
> Hi all,
>=20
> this series fixes the riscv trap handling of Dovetail.
>=20
> Thanks to Jan for sharing his AI reviews on this which made me have
> a look at this.
>=20
> The bugs were verified by running a trap matrix test, which raises
> every kind of trap from an out-of-band EVL thread, with a more detailed
> oob_trap RV monitor from the Dovetail RV RFC enabled.

Where are those tests?

The problem with that approach (fixes first, tests later) is quite
simple: Once the fixes are in, interest in automating the necessary
testsuite is gone.

Solution: Tests have to arrive at the same time.

In case they were on the list already: Please add a reference here.

>=20
> Testing was done on v7.3 with EVL under QEMU riscv64: the trap matrix
> test, the libevl suite and kprobe tests hitting out-of-band syscalls,
> IRQ handlers and nested faults all pass with a clean kernel log and no
> monitor reaction. Reverting the fixes one at a time reproduces each
> bug except the last one.
>=20
> Thanks,
> Tobias
>=20
> Tobias Schaffner (5):
>   riscv: dovetail: do not notify traps again from do_trap()
>   riscv: dovetail: run kernel trap handlers the core did not demote for
>   riscv: dovetail: do not nest the unknown trap handler in software
>     checks
>   riscv: dovetail: keep hard irqs off for page faults handled
>     out-of-band
>   riscv: dovetail: read the CFI trap value from the saved registers
>=20
>  arch/riscv/kernel/traps.c | 60 +++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 28 deletions(-)
>=20
>=20
> base-commit: de6ccdbc1027fda48257c4033c90d57da3e676ea
> --=20
> 2.53.0
