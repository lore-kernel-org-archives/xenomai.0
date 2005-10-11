Message-ID: <b647ffbd0510102343w3828a0cs@domain.hid>
Date: Tue, 11 Oct 2005 08:43:23 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <434A601C.7000605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <b647ffbd0510100450n19552d5fq@domain.hid>
	<434A585B.40905@domain.hid>
	<b647ffbd0510100529v2c96d260r@domain.hid>
	<434A601C.7000605@domain.hid>
Subject: [Xenomai-core] Re: [syscall.c] rt_bind_queue/heap()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 10/10/05, Philippe Gerum <rpm@xenomai.org> wrote:
> Dmitry Adamushko wrote:
> >>As you noticed below, the point is that this feature should be active f=
or
> >>kernel-based code only; for user-space, we're toast: typical chicken-an=
d-egg
> >>problem since we need the registry to cross the space boundaries but th=
e
> >>registry requires a name to index the object first. So yes, we need to =
check for
> >>anonymous calls in every service taking a symbolic name in native/sysca=
lls.c,
> >>and return -EINVAL when applicable.
> >
> >
> > I thought that "libnative" would be a better place since this way we
> > would avoid the user mode -> kernel mode switch.
> >
> >
> >>...Or, we might auto-generate some dummy name in native/syscalls.c we w=
ould pass
> >>to the registry when this situation arises, so that anonymous creation =
and use
> >>from user-space would still be possible.
> >
> >
> > Yep, in this case a name would be a string =3D=3D object's address, thu=
s
> > it's unique.
> >
> > Ok, I'd probably vote for the 2-nd approach.
> >
>
> Definitely better since this keeps the semantics consistent across execut=
ion spaces.
>

Then we still have a difference in behaviour of the objectes depending
on where they are craeted. I mean, the NULL-named user-space objects
will be displayed under some, well, not-that-informative names (e.g.
0xc3264780) while the kernel-based ones will not have an entry in the
registry (they are really NULL-named).

So,

1) don't display such names in /proc;
2) make a common mechanism for both spaces.

rt_mutex_create()   // for other objects as well
{
...
- xnobject_copy_name(mutex->name,name);
+xnobject_create_name(mutex->name,name, object);
...
}

xnobject_create_name(dst,src, object)
{
      if (src)
            xnobject_copy_name(mutex->name,name);
      else
            snprintf(dst, XNOBJECT_NAME_LEN, "%p", object);
}

// the slightly ugly thing is that we need to be sure that dst is
always object->name so it's really of XNOBJECT_NAME_LEN size.

Then we don't need "*name =3D '\n';" in syscall.c:__rt_object_create().
But this bit should be removed in any case.

What do you think?

Frankly, I like this approach better. All objects get some name if
they are NULL-named by a user and the code changes are a bit more
graceful. To show them in /proc or not is still another question.

---
Best regards,
Dmitry





--
Best regards,
Dmitry Adamushko

