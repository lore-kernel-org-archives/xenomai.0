From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
References: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
	<C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
Date: Wed, 04 Nov 2009 07:52:57 +0100
Message-Id: <20091104065257.A164B3F6C1@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] bring down the system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor <pastor@domain.hid>

Dear Stefan Schaal,

In message <C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid> you wrote:
> Sorry, I attached the wrong C-program in the previous posting .... =20
> here is the corrected version:

I'm not sure what exactly you are trying to test, but I think you
should invest a little more time in your test cases.

>   attached is a little C program that spawns off a task which runs a =20
> heavy tiny math job. Despite my 8 processor machine, taking this one =20

Does it? Not for me.

> void
> run_task(void *dummy)
> {
>    int i;
>    double foo =3D 1.0;
>=20
>    for (i=3D1; i<=3D100000000; ++i)
>      foo =3D foo*1.1;
>=20
>    return;
> }

On x86, this code compiles for me into this:

        .text
        .p2align 4,,15
.globl run_task
        .type   run_task, @function
run_task:
        pushl   %ebp
        movl    %esp, %ebp
        popl    %ebp
        ret
        .size   run_task, .-run_task
        .ident  "GCC: (GNU) 4.4.1 20090725 (Red Hat 4.4.1-2)"
        .section        .note.GNU-stack,"",@progbits

Similar on ARM and Power.

As you can see, the compiler completely optimizes away your "tiny math
job". So what should be loading your CPU?

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
"Nature is very un-American.  Nature never hurries."
- William George Jordan

