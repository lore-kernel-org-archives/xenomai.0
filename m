Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDF3ED101
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182622; cv=none; b=BBX9Onee1xVCUUSAx8fF78EZ9FFHfEXxgthrOn0MGT6SzPTwKbekoUpmJ88Ls+R8P7aTAkcN4ZEsn057lFI3XlwHgsfUJ6Y3tnq09slbyM508lEaPAmPYd3Bi8KlbXbj8w4QMxGWmSCMvKbild/kwDEvYnweA4rqZrmvhzHTzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182622; c=relaxed/simple;
	bh=uVj207mOE+TE4GaD6td693eWJ5mEpdIsbizB7m4fTnU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dhdJNvV/nG1MNv9mRInIvkVe+2dhAG9DsoElqvRBOwYMw4RFlOxJl4t/J0rqd/saydo5WWVPpih/0ZlJ8Gl35Rm2DQfkdnYZXBDpCZbn0098wj0Jk3cCo1G+8BPi+Cloihdl87mTHiNQBYzO2oqP8jIkIpynJLxm4XtKNP+uMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Xh3WOYHu; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xh3WOYHu"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260414160330db45ae7dc80002073f
        for <xenomai@lists.linux.dev>;
        Tue, 14 Apr 2026 18:03:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=02JOah/MYTN0lOA3n4h9ytqVlx7/mYyq8mxVbJdO05A=;
 b=Xh3WOYHuBh7xgPbet5OHBejZHH4zrOBp76F/AHhgtmyTWWzhTiFldhSZ4SRW1C511pkoEz
 9tOD1x8aLOkDX8H43Tc4lR6gW99DnBGoRz1dfbJZLK5aaRM5qA7Nds/7uLSpzg4DgF//bBCA
 u8fL9Q4cqJzYtjMz8IUdwpAoF6E7eCteEd4ursVtaueRWQMKxBq5z1NGrWCswAXUj5nW3GDu
 Bw+JVdcDnHZ2UJ2A3z1BCYIyfjwH4uCc9YVHPTsmzMlhVJLj7EqzsgwBSQK4vhXJ+7We/eaH
 VWQd5ZOkUw/JC7IjpdLJDoVKtllD/ZEHEQIKrqZ1BXp9vE6SBZ5cQrrA==;
Message-ID: <5a8c53d0507a1f8e0816ea6a1f6a02ab2fea1c58.camel@siemens.com>
Subject: Re: [PATCH] cobalt/posix/syscall: Account for changes in kernel 7.0
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Tue, 14 Apr 2026 18:03:29 +0200
In-Reply-To: <ed1ca8c0-93ec-457f-8615-aad03b06f6ef@siemens.com>
References: <ed1ca8c0-93ec-457f-8615-aad03b06f6ef@siemens.com>
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

On Tue, 2026-04-14 at 17:35 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> With 7.0, we no longer have a access to trace print function that takes
> the string size directly. [__]trace_puts will now always invoke strlen
> on the passed string. We therefore need to terminate our string
> properly, even if a larger one was passed.
>=20
> We could keep the micro-optimized variant for older kernels, but as that
> is phasing out and the gain is likely minimal (the string is still in L1
> cache after copy_from_user), simply switch all versions to the same
> pattern.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/posix/syscall.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.=
c
> index a26da154c4..bc1825676f 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -46,6 +46,12 @@
>  #include "../debug.h"
>  #include <trace/events/cobalt-posix.h>
> =20
> +#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(7,0,0)
> +#include <linux/trace_printk.h>
> +#else
> +#include <linux/kernel.h>
> +#endif
> +
>  /* Syscall must run into the Linux domain. */
>  #define __xn_exec_lostage    0x1
>  /* Syscall must run into the Xenomai domain. */
> @@ -194,12 +200,13 @@ static COBALT_SYSCALL(ftrace_puts, current,
>  	char buf[256];
>  	unsigned len;
> =20
> -	len =3D cobalt_strncpy_from_user(buf, str, sizeof(buf));
> +	len =3D cobalt_strncpy_from_user(buf, str, sizeof(buf) - 1);
>  	if (len < 0)
>  		return -EFAULT;
> =20
>  #ifdef CONFIG_TRACING
> -	__trace_puts(_THIS_IP_, buf, len);
> +	buf[sizeof(buf) - 1] =3D 0;

Shouldn't we terminate at buf[len]?

buf[len+1] to buf[sizeof(buf)-1] might be garbage, no?

> +	trace_puts(buf);
>  #endif
> =20
>  	return 0;
> --=20
> 2.47.3
