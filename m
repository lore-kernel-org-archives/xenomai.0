Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288F846E
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 09:15:19 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202307170915162bf77c4f1ddd8c6a81
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jul 2023 11:15:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1Z0dD1AIb9t68hTDdF9+Df7HFxh4rwMS/usGYJVa9PI=;
 b=MAR8FpodUwbIKIgpEaeMkNN62G4Rw8i1jbY9fpJ1DGa5ksFB+1NBpa2P2c7A52+jzrdQTK
 hgh5m6e8HGvOb7n3zyGqOm7HsMiXL7x0ws0bKxeGjRM8BgjauNlXUzME1c1iVDCVmyiAs40T
 31pTy9EJhwnTqoorMRGDGM+O+HjQc=;
Message-ID: <2e134bee306f59f28c098d5415b387a758d4a38c.camel@siemens.com>
Subject: Re: Missing asm/fpu/internal.h
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Tam=E1s_Pa=E1l?= <paal.tam@gmail.com>, 
	xenomai@lists.linux.dev
Date: Mon, 17 Jul 2023 11:15:16 +0200
In-Reply-To: <CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
References: 
	<CAH0t8y1U_A8ggJG3mjikhsk+soJYm-du0NcxAApbe=UFWXwm5Q@mail.gmail.com>
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

On Mon, 2023-07-17 at 11:05 +0200, Tam=C3=A1s Pa=C3=A1l wrote:
> Dear All,
>=20
> I am using the 5.15 dovetail based kernel together with Xenomai 3.2.1.
> It works fine. I would like to upgrade to a more recent kernel, but I
> run into a kernel compilation error very early:
>=20
>=20
> In file included from ./include/asm-generic/xenomai/syscall.h:26,
>                  from
> ./arch/x86/xenomai/dovetail/include/asm/xenomai/syscall.h:24,
>                  from ./include/xenomai/pipeline/pipeline.h:12,
>                  from ./include/xenomai/cobalt/kernel/lock.h:26,
>                  from ./include/xenomai/cobalt/kernel/sched.h:23,
>                  from ./arch/x86/include/dovetail/irq.h:12,
>                  from kernel/irq/pipeline.c:17:
> ./arch/x86/xenomai/include/asm/xenomai/wrappers.h:44:10: fatal error:
> asm/fpu/internal.h: No such file or directory
>    44 | #include <asm/fpu/internal.h>
>       |          ^~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:252: kernel/irq/pipeline.o] Error 1
> make[2]: *** [scripts/Makefile.build:494: kernel/irq] Error 2
> make[1]: *** [scripts/Makefile.build:494: kernel] Error 2
>=20
>=20
> I have been tried kernel 5.19, 6.1, 6.4, Xenomai 3.2.1, 3.2.3 in all
> combinations, with the same result.
> In kernel version 5.15 the arch/x86/include/asm/fpu directory contains
> an internal.h, but I cannot find this file from 5.19 and above. I
> believe this is the cause of the error.
>=20
> Please help me. What am I doing wrong?

Xenomai 3.2.x supports Linux up to 5.15. If you want to update to newer
Linux versions you have to use Xenomai from master branch. There is no
3.3 release yet, but we're working on it. We already discussed that
"missing release" in our community call some days ago. There are some
features pending that we would like to integrate. So: stay tuned.

Florian

>=20
> Thank you,
> Tamas
>=20

