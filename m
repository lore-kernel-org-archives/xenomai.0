Message-ID: <48593233.7000102@domain.hid>
Date: Wed, 18 Jun 2008 18:05:07 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
References: <4859299A.2010802@domain.hid> <48592D6D.2010104@domain.hid>
In-Reply-To: <48592D6D.2010104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PowerPC] Registers Corruption at Context Switch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum a =E9crit :
> See arch/powerpc/switch_32.S, rthal_switch_threads(), for the part that=
 does the
> actual stack switching.
>
> Note that this code is obfuscated by the fact that we have to handle so=
-called
> "hybrid" switching, between Xenomai kernel threads (which do not rely o=
n a
> task_struct), and Linux tasks (Xenomai userland, Linux kthreads, or reg=
ular
> userland Linux). Fortunately, what is saved on the stack in any case is=
 easy to
> find out.
>  =20
Thx for the info.
Can you tell me why GPR registers would be saved there and FPU ones in=20
another function ?

Ben

