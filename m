Message-ID: <485BC1B8.8040301@domain.hid>
Date: Fri, 20 Jun 2008 16:42:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4859299A.2010802@domain.hid> <48592D6D.2010104@domain.hid>
	<48593233.7000102@domain.hid>
In-Reply-To: <48593233.7000102@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PowerPC] Registers Corruption at Context Switch
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin ZORES <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Benjamin ZORES wrote:
> Philippe Gerum a =E9crit :
>> See arch/powerpc/switch_32.S, rthal_switch_threads(), for the part that =
does the
>> actual stack switching.
>>
>> Note that this code is obfuscated by the fact that we have to handle so-=
called
>> "hybrid" switching, between Xenomai kernel threads (which do not rely on=
 a
>> task_struct), and Linux tasks (Xenomai userland, Linux kthreads, or regu=
lar
>> userland Linux). Fortunately, what is saved on the stack in any case is =
easy to
>> find out.
>>  =20
> Thx for the info.
> Can you tell me why GPR registers would be saved there and FPU ones in=20
> another function ?
>=20

Because FPU management with Xenomai involves additional handling, e.g. FPU =
state
fixup during primary/secondary mode switch, Linux to Xenomai real-time
transitions. That support has to be provided independently from the pure ta=
sk
switching code.

--=20
Philippe.

