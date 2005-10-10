Message-ID: <b647ffbd0510100450n19552d5fq@domain.hid>
Date: Mon, 10 Oct 2005 13:50:25 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

> > One more thing. I had a discussion with Steven Seeger regarding the use
> > of NULL-named objects from the user space. I cc'ed you but probably you
> > were too buzy at that time. The problem is that one may create
> > successfully a NULL-named object but then there is no way to use it
> > since all further calls give an error (some funny stuff there indeed :)
> >
> > So a simple fix would look like:
> >
> > for all rt_OBJECT_create() calls in libnative:
> >
> > int rt_mutex_create(RT_MUTEX *mutex, const char *name)
> > {
> >
> > + if (!name)
> > + return -E_SOMETHING; // E_INVAL?
> >
> > return XENOMAI_SKINCALL2(__xeno_muxid,
> > __xeno_mutex_create,
> > mutex,
> > name);
> > }
> >
> > What do you think? Or are there any reasons to keep it as is now?
> >

> The reason is to allow anonymous objects to be created, so that the descr=
iptor
> could only be shared by tasks belonging to the same address space if they
> happen
> to all have access to the descriptor's memory. Kind of semi-private objec=
t if
> you want. The fact that such an object is non-bindable should not make it
> unusable actually.

Well, but it's unusable (from the user space app.) indeed. I have
checked it with a simple example and the original overview is enclosed
below as is.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have cc:'ed Philippe since the code backtrace would be of interest
mainly for him :)

Here is a misbehaviour of the native skin and, well, partially your's :)
The problem is that it allows you creating of an object with a NULL
name, but such an object will not get a record in the registry when
created from the user-mode! This said, one can use NULL-named objects
only from the kernel-mode when there is a direct access to the real
RT_MUTEX structure.

Look,

rt_mutex_create()
{
...
   if (name && *name)
        {
        err =3D rt_registry_enter(mutex->name,mutex,&mutex->handle,&__mutex=
_pnode);

and in our case, name =3D=3D "\0".

So when a creation is completed, mutex->handle =3D=3D 0!

Then, goes more fun

syscall.c::__rt_mutex_delete() or __rt_mutex_lock()
{
...
 mutex =3D (RT_MUTEX *)rt_registry_fetch(ph.opaque);

// we know that ph.opaque =3D=3D 0, so guess what would be returned? Heh,
a handle of the current task! :)


void *rt_registry_fetch (rt_handle_t handle)

{
...
    if (handle =3D=3D RT_REGISTRY_SELF)=09// RT_REGISTRY_SELF =3D=3D 0. Wha=
t a
coincidence! :)
=09{
=09if (!xnpod_primary_p())=09// not our case if we are in the primiry mode
            {
            objaddr =3D NULL;
            goto unlock_and_exit;
            }

=09// that's our case

        if (xnpod_current_thread()->magic =3D=3D RTAI_SKIN_MAGIC)
            {
            objaddr =3D rtai_current_task();=09<=3D=3D=3D (*)
            goto unlock_and_exit;
            }
        }
...

So rt_registry_fetch() returns a valid handle but of the current task
and not of a mutex.

Then __rt_mutex_delete() procedes (mutex !=3D NULL) and calls
rt_mutex_delete() which, in turn, calls

  mutex =3D rtai_h2obj_validate(mutex,RTAI_MUTEX_MAGIC,RT_MUTEX);

    if (!mutex)
        {
        err =3D rtai_handle_error(mutex,RTAI_MUTEX_MAGIC,RT_MUTEX);
        goto unlock_and_exit;
        }

Since this object is not of RTAI_MUTEX_MAGIC type, the EINVAL error occurs.

So to sum it up.

You have been able to create all your objects but haven't been able to
use them properly. Probably, you are not checking a result of
rt_mutex_lock() otherwise you would be able to get EINVAL error even
yesterday.

Why you can't do it today? Since you have been able to create the
NULL-named objects (that leads to allocating some memory from the
heap) but rt_mutex_delete() failed all the time (ok, I know, who cares
about the proper error checking when deleting :) - the memory was not
freed. So all your heap has gone by today. You haven't reloaded
modules, have you?

So it must be fixed. There must be an explicit prohibition on creating
NULL-named objects from the user-mode.

--
Best regards,
Dmitry Adamushko

