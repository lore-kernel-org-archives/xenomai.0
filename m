From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <509DA52866E38F47878413CF102D751FED236D783F@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FED236D7830@domain.hid>
	<4E5F6E41.1050606@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D7834@domain.hid>
	<4E5F753C.8070904@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D783D@poseidon.nexus-ag.com>
	<4E5F9FDB.5080702@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D783F@poseidon.nexus-ag.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Sep 2011 22:27:37 +0200
Message-ID: <1314908857.18201.28.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On Thu, 2011-09-01 at 17:25 +0200, Sambasiva Rao Manchili wrote:
> Hi,
> It is reduced piece which explains the problem.
> If it is much more then I will see what I can do.

User-space needs this, or something alike (not tested, not even
compiled actually):

diff --git a/src/skins/vxworks/taskLib.c b/src/skins/vxworks/taskLib.c
index f751788..70f33aa 100644
--- a/src/skins/vxworks/taskLib.c
+++ b/src/skins/vxworks/taskLib.c
@@ -267,10 +267,34 @@ STATUS taskDeleteForce(TASK_ID task_id)
 
 STATUS taskDelete(TASK_ID task_id)
 {
+	TASK_DESC desc;
+	pthread_t tid;
 	int err;
 
-	err =
-	    XENOMAI_SKINCALL1(__vxworks_muxid, __vxworks_task_delete, task_id);
+	err = XENOMAI_SKINCALL2(__vxworks_muxid,
+				__vxworks_taskinfo_get, task_id, &desc);
+	if (err) {
+		errno = abs(err);
+		return ERROR;
+	}
+
+	tid = (pthread_t)desc->td_opaque;
+	if (tid == pthread_self()) {
+		/* Silently migrate to avoid raising SIGXCPU. */
+		XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_LINUX_DOMAIN);
+		pthread_exit(NULL);
+	}
+
+	if (tid) {
+		err = pthread_cancel(tid);
+		if (err)
+			return -err;
+	}
+
+	err = XENOMAI_SKINCALL1(__vxworks_muxid, __vxworks_task_delete, task_id);
+	if (err == S_objLib_OBJ_ID_ERROR)
+		return OK; /* Used to be valid, but has exited. */
+
 	if (err) {
 		errno = abs(err);
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
> > The reason that I have not given this piece of code was because it is not written by me oflate but  was code that exists since several years which is running on VxWorks  on  different versions.
> > I just ported this with very very minimal effort to Linux over Xenomai.
> >
> 
> I do not ask you to send your code, I ask you to send a reduced, self-contained test case, which demonstrates the issue you have, for reasons explained on the page I directed you to.
> 
> --
>                                             Gilles.
> 
> 
> This email and any attachment may contain confidential information which is intended for use only by the addressee(s) named above. If you received this email by mistake, please notify the sender immediately, and delete the email from your system. You are prohibited from copying, disseminating or otherwise using the email or any attachment.
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.




