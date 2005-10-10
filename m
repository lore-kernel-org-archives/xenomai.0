Message-ID: <b647ffbd0510100529v2c96d260r@domain.hid>
Date: Mon, 10 Oct 2005 14:29:59 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <434A585B.40905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <b647ffbd0510100450n19552d5fq@domain.hid>
	<434A585B.40905@domain.hid>
Subject: [Xenomai-core] Re: [syscall.c] rt_bind_queue/heap()
Reply-To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> As you noticed below, the point is that this feature should be active for
> kernel-based code only; for user-space, we're toast: typical chicken-and-=
egg
> problem since we need the registry to cross the space boundaries but the
> registry requires a name to index the object first. So yes, we need to ch=
eck for
> anonymous calls in every service taking a symbolic name in native/syscall=
s.c,
> and return -EINVAL when applicable.

I thought that "libnative" would be a better place since this way we
would avoid the user mode -> kernel mode switch.

> ...Or, we might auto-generate some dummy name in native/syscalls.c we wou=
ld pass
> to the registry when this situation arises, so that anonymous creation an=
d use
> from user-space would still be possible.

Yep, in this case a name would be a string =3D=3D object's address, thus
it's unique.

Ok, I'd probably vote for the 2-nd approach.


> --
>
> Philippe.

---
Best regards,
Dmitry

