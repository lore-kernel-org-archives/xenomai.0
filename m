Subject: Re: [PATCH v2] cobalt: Sort out virtual vs. real pids
References: <1bce3d58-97b8-c217-dbb7-e11fc2a1d56c@siemens.com>
 <30cbfc5d-6ff0-8b9b-1c3a-19213636fe94@siemens.com>
 <PR3PR02MB62022D1DAE6588BDA63079F8D1E49@PR3PR02MB6202.eurprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1a4ef307-1c92-02bb-c982-010b443a3345@siemens.com>
Date: Thu, 22 Jul 2021 16:15:12 +0200
MIME-Version: 1.0
In-Reply-To: <PR3PR02MB62022D1DAE6588BDA63079F8D1E49@PR3PR02MB6202.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: MONTET Julien <julien.montet@reseau.eseo.fr>, Xenomai <xenomai@xenomai.org>
Cc: Marco Barletta <barlettamarco8@gmail.com>

On 22.07.21 14:07, MONTET Julien wrote:
> Hi,
>=20
> I tested all of your patches last week, and it did not change anything.=A0
> Compiling the Xenomai libraries directly on Docker didn't solve the issue.
>=20
> The Xenomai timer seems to work,=A0I can loop on it and print the time
> (but it was also working before).
>=20
> Unfortunately I am still stuck on=A0rt_task_wait_period(...).
>=20

That might be becaues I was looking at Marco's test case so as he shared=20
his...

I starred at the code again, and this on top may help (and also fix=20
signaling by udd):

diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 2f3ea1dec4..6a79fecb5c 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -176,11 +176,11 @@ struct cobalt_thread *cobalt_thread_find(pid_t pid) /=
* nklocked, IRQs off */
 }
 EXPORT_SYMBOL_GPL(cobalt_thread_find);
=20
-struct cobalt_thread *cobalt_thread_find_local(pid_t pid) /* nklocked, IRQ=
s off */
+struct cobalt_thread *cobalt_thread_find_local(pid_t vpid) /* nklocked, IR=
Qs off */
 {
 	struct cobalt_thread *thread;
=20
-	thread =3D cobalt_thread_find(pid);
+	thread =3D cobalt_thread_find(cobalt_vpid2pid_nr(vpid));
 	if (thread =3D=3D NULL || thread->hkey.mm !=3D current->mm)
 		return NULL;
=20
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index 51be372a7a..66e3a88223 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -146,7 +146,7 @@ int cobalt_thread_setschedprio(unsigned long pth,
=20
 struct cobalt_thread *cobalt_thread_find(pid_t pid);
=20
-struct cobalt_thread *cobalt_thread_find_local(pid_t pid);
+struct cobalt_thread *cobalt_thread_find_local(pid_t vpid);
=20
 struct cobalt_thread *cobalt_thread_lookup(unsigned long pth);
=20

> In any case, I will keep you informed if I achieve to implement this or
> find my issue.
> Do not hesitate to suggest debugging tools/methods, I will be pleased to
> give you feedback on the results.
>=20

BTW, there is the bad news that threadobj_stat() uses /proc to retrieve
thread statistics. That will remain broken over pid namespaces until we
virtualize /proc as well. That affects rt_task_inquire and the registry=20
service /wrt tasks.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

