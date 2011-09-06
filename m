From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Tue, 6 Sep 2011 13:13:38 +0200
Message-ID: <509DA52866E38F47878413CF102D751FED236D78BB@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FED236D7830@domain.hid>
	<4E5F6E41.1050606@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D7834@domain.hid>
	<4E5F753C.8070904@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D783D@poseidon.nexus-ag.com>
	<4E5F9FDB.5080702@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D783F@poseidon.nexus-ag.com>
	<1314908857.18201.28.camel@domain.hid> <1314909331.18201.35.camel@domain.hid>
In-Reply-To: <1314909331.18201.35.camel@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>


Philippe,
There is one correction in the following patch. Though you told me uncompil=
ed / untested, I just want to give a try and found minor compilation issue =
which I want to bring to your notice.

- tid =3D (pthread_t)desc->td_opaque;
+ tid =3D (pthread_t)desc.td_opaque;

After this correction compilation went well. I also tested with  our ported=
 software. It works as expected with taskDelete from Xenomai.

One more observation that I remember now:-
In legacy VxWorks code we create Queues of size 1000  to store each message=
 of size 384bytes while we have memory on our Boards upto 4GB, but with Xen=
omai I **have to** reduce the queue size drastically otherwise msgQCreate f=
ails(though we have memory) with error code S_memLib_NOT_ENOUGH_MEMORY.

Samba.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Thursday, 01. September, 2011 22:36
To: Sambasiva Rao Manchili
Cc: Xenomai-help@domain.hid
Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?

On Thu, 2011-09-01 at 22:27 +0200, Philippe Gerum wrote:
> On Thu, 2011-09-01 at 17:25 +0200, Sambasiva Rao Manchili wrote:
> > Hi,
> > It is reduced piece which explains the problem.
> > If it is much more then I will see what I can do.
>
> User-space needs this, or something alike (not tested, not even
> compiled actually):

Keep in mind that the following hack bypasses the safe lock mechanism total=
ly, a complete and sane fix would need a bit more thought, and maybe an ABI=
 breakage. Normally we should not throw pthread_cancel() at a task denying =
deletion from within a taskSafe() section, unless we pair this with proper =
cancellation deferral.

>
> diff --git a/src/skins/vxworks/taskLib.c b/src/skins/vxworks/taskLib.c
> index f751788..70f33aa 100644
> --- a/src/skins/vxworks/taskLib.c
> +++ b/src/skins/vxworks/taskLib.c
> @@ -267,10 +267,34 @@ STATUS taskDeleteForce(TASK_ID task_id)
>
>  STATUS taskDelete(TASK_ID task_id)
>  {
> +     TASK_DESC desc;
> +     pthread_t tid;
>       int err;
>
> -     err =3D
> -         XENOMAI_SKINCALL1(__vxworks_muxid, __vxworks_task_delete, task_=
id);
> +     err =3D XENOMAI_SKINCALL2(__vxworks_muxid,
> +                             __vxworks_taskinfo_get, task_id, &desc);
> +     if (err) {
> +             errno =3D abs(err);
> +             return ERROR;
> +     }
> +
> +     tid =3D (pthread_t)desc->td_opaque;
> +     if (tid =3D=3D pthread_self()) {
> +             /* Silently migrate to avoid raising SIGXCPU. */
> +             XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
> +             pthread_exit(NULL);
> +     }
> +
> +     if (tid) {
> +             err =3D pthread_cancel(tid);
> +             if (err)
> +                     return -err;
> +     }
> +
> +     err =3D XENOMAI_SKINCALL1(__vxworks_muxid, __vxworks_task_delete, t=
ask_id);
> +     if (err =3D=3D S_objLib_OBJ_ID_ERROR)
> +             return OK; /* Used to be valid, but has exited. */
> +
>       if (err) {
>               errno =3D abs(err);
>               return ERROR;
>
> > Samba.
> >
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> > Sent: Thursday, 01. September, 2011 17:08
> > To: Sambasiva Rao Manchili
> > Cc: Xenomai-help@domain.hid
> > Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?
> >
> > On 09/01/2011 04:51 PM, Sambasiva Rao Manchili wrote:
> > >  Hi,
> > > The reason that I have not given this piece of code was because it is=
 not written by me oflate but  was code that exists since several years whi=
ch is running on VxWorks  on  different versions.
> > > I just ported this with very very minimal effort to Linux over Xenoma=
i.
> > >
> >
> > I do not ask you to send your code, I ask you to send a reduced, self-c=
ontained test case, which demonstrates the issue you have, for reasons expl=
ained on the page I directed you to.
> >
> > --
> >                                             Gilles.
> >
> >
> > This email and any attachment may contain confidential information whic=
h is intended for use only by the addressee(s) named above. If you received=
 this email by mistake, please notify the sender immediately, and delete th=
e email from your system. You are prohibited from copying, disseminating or=
 otherwise using the email or any attachment.
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>

--
Philippe.




This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.


