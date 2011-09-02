From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Fri, 2 Sep 2011 09:29:04 +0200
Message-ID: <509DA52866E38F47878413CF102D751FED236D784C@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FED236D7830@domain.hid>
	<4E5F6E41.1050606@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D7834@domain.hid>
	<4E5F753C.8070904@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D783D@poseidon.nexus-ag.com>
	<4E5F9FDB.5080702@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D783F@poseidon.nexus-ag.com>
	<1314908857.18201.28.camel@domain.hid>
In-Reply-To: <1314908857.18201.28.camel@domain.hid>
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

Thank you Philippe for your time.
Right now I did a workaround with a flag  after deleting a task and checkin=
g this flag before doing any operation by task that was deleted. It works f=
or me.
I could not believe  taskDelete did not work till yesterday.

I hope with next version of Xenomail release the tested patch for taskDelet=
e will be available and for now I live with my workaround.

Overall porting of VxWorks code, Integration and testing since three months=
. I faced only two issues for which I got blocked.
1. semTake with specific timeout value failed in Xenomai.  As a workaround =
I just removed this semTake and semGive , which is also OK to an extent in =
this area of code.
2. taskDelete

Some of the vxworks functions that are not supported, I ported  to native l=
inux methods.

Thank you one and all for your support.
Samba.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]
Sent: Thursday, 01. September, 2011 22:28
To: Sambasiva Rao Manchili
Cc: Gilles Chanteperdrix; Xenomai-help@domain.hid
Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?

On Thu, 2011-09-01 at 17:25 +0200, Sambasiva Rao Manchili wrote:
> Hi,
> It is reduced piece which explains the problem.
> If it is much more then I will see what I can do.

User-space needs this, or something alike (not tested, not even compiled ac=
tually):

diff --git a/src/skins/vxworks/taskLib.c b/src/skins/vxworks/taskLib.c inde=
x f751788..70f33aa 100644
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -267,10 +267,34 @@ STATUS taskDeleteForce(TASK_ID task_id)

 STATUS taskDelete(TASK_ID task_id)
 {
+       TASK_DESC desc;
+       pthread_t tid;
        int err;

-       err =3D
-           XENOMAI_SKINCALL1(__vxworks_muxid, __vxworks_task_delete, task_=
id);
+       err =3D XENOMAI_SKINCALL2(__vxworks_muxid,
+                               __vxworks_taskinfo_get, task_id, &desc);
+       if (err) {
+               errno =3D abs(err);
+               return ERROR;
+       }
+
+       tid =3D (pthread_t)desc->td_opaque;
+       if (tid =3D=3D pthread_self()) {
+               /* Silently migrate to avoid raising SIGXCPU. */
+               XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
+               pthread_exit(NULL);
+       }
+
+       if (tid) {
+               err =3D pthread_cancel(tid);
+               if (err)
+                       return -err;
+       }
+
+       err =3D XENOMAI_SKINCALL1(__vxworks_muxid, __vxworks_task_delete, t=
ask_id);
+       if (err =3D=3D S_objLib_OBJ_ID_ERROR)
+               return OK; /* Used to be valid, but has exited. */
+
        if (err) {
                errno =3D abs(err);
                return ERROR;

> Samba.
>
> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Thursday, 01. September, 2011 17:08
> To: Sambasiva Rao Manchili
> Cc: Xenomai-help@domain.hid
> Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?
>
> On 09/01/2011 04:51 PM, Sambasiva Rao Manchili wrote:
> >  Hi,
> > The reason that I have not given this piece of code was because it is n=
ot written by me oflate but  was code that exists since several years which=
 is running on VxWorks  on  different versions.
> > I just ported this with very very minimal effort to Linux over Xenomai.
> >
>
> I do not ask you to send your code, I ask you to send a reduced, self-con=
tained test case, which demonstrates the issue you have, for reasons explai=
ned on the page I directed you to.
>
> --
>                                             Gilles.
>
>
> This email and any attachment may contain confidential information which =
is intended for use only by the addressee(s) named above. If you received t=
his email by mistake, please notify the sender immediately, and delete the =
email from your system. You are prohibited from copying, disseminating or o=
therwise using the email or any attachment.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--
Philippe.





This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.


