Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1A23CF
	for <xenomai@lists.linux.dev>; Sun,  3 Jul 2022 14:04:26 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4F887FF803;
	Sun,  3 Jul 2022 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1656857059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdmYSNxXIiAzOmfZWJYtsag1m5K9vLlh2/nPMXBBzIg=;
	b=WBSS79ic9jVTKWZ+eZ8VhjXHcfiV04upWaRLlz6pnMBbXXpk3begL7p4U+qQp0+Sjts8+t
	SOkh2AKdE/m5Ujl//gYJxPzdIW9X7JSLdG486m/jbnN5JyAM+7tYu+v7LQwqPClbE89a46
	D8B+7nFXWr6RFBQrRMqOnsCwixr1MjoJAuGuNhLdFOUc7a7O0gCHJHwXXa8j12KmFlbFwD
	421z5LfuDj/guUGEBwdfULCFJLs2sol8jxFpuSE3snWDym9CQ1ok1f8fsFK4L1fnoWHhwH
	rkltK1J3eVF9kvDdw/NOzF9U+OuXdK1RfXXgN2d06CdH9h5TLYf74kpmeKQG8w==
References: <a8c7f093-4b5d-fbf8-cb4d-01d64d0c2746@siemens.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] arm64: dovetail: Fix cast-function-type warning
Date: Sun, 03 Jul 2022 16:01:58 +0200
In-reply-to: <a8c7f093-4b5d-fbf8-cb4d-01d64d0c2746@siemens.com>
Message-ID: <871qv2uwbh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Resolves
>
> ../arch/arm64/kernel/entry-common.c: In function =E2=80=98do_interrupt_ha=
ndler=E2=80=99:
> ../arch/arm64/kernel/entry-common.c:434:13: warning: cast between incompa=
tible function types from =E2=80=98int (*)(struct pt_regs *)=E2=80=99 to =
=E2=80=98void (*)(struct pt_regs *)=E2=80=99 [-Wcast-function-type]
>   434 |   handler =3D (void (*)(struct pt_regs *))handle_irq_pipelined;
>       |             ^
>
> which is harmless in this context.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/kernel/entry-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-c=
ommon.c
> index 9e7f424aa00b..525e13be728f 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -431,7 +431,7 @@ static bool do_interrupt_handler(struct pt_regs *regs,
>  	struct pt_regs *old_regs =3D set_irq_regs(regs); /* need this for FIQs =
*/
>=20=20
>  	if (handler =3D=3D handle_arch_irq)
> -		handler =3D (void (*)(struct pt_regs *))handle_irq_pipelined;
> +		handler =3D (typeof(handler))(void (*)(void))handle_irq_pipelined;
>=20=20
>  	__do_interrupt_handler(regs, handler);

Merged, thanks (fixing up the subject line, this helps me dispatching the
changes when flattening the tree).

--=20
Philippe.
