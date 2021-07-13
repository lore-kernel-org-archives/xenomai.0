Subject: Re: [PATCH] cobalt: Sort out virtual vs. real pids
References: <af9a744d-9617-ed83-6391-edd5fd9ff26d@siemens.com>
 <c4980c02-5264-811b-f0e0-fb3d336599c2@siemens.com>
 <PR3PR02MB620290F360DCB995056445A1D1189@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <9d2a0368-c341-e9aa-3d3e-b3b84dea75b8@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e042adcb-c947-2b1b-ec7f-176bb8f8af93@siemens.com>
Date: Tue, 13 Jul 2021 11:35:31 +0200
MIME-Version: 1.0
In-Reply-To: <9d2a0368-c341-e9aa-3d3e-b3b84dea75b8@siemens.com>
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
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: Xenomai <xenomai@xenomai.org>

On 13.07.21 10:51, Jan Kiszka via Xenomai wrote:
> On 12.07.21 09:18, MONTET Julien wrote:
>> Hi Jan,
>>
>> Thanks for your suggestions.
>> I tried them last weekend, but it didn't work as expected (compilation
>> with modifications is ok). The code still hangs
>> on=A0rt_task_set_periodic/rt_task_wait_period.
>>
>> There are still few other ways to try such as installing directly the
>> Xenomai library on the target and use "volume" on Docker (no
>> cross-compilation... even if it worked on ARM).
>> Maybe the issue doesn't come from the pid/vpid, I am not 100% sure.
>> In any case, I am going to do some other tests this week.
>>
>=20
> Got this reproduced (after fighting the usual fight of "Which config
> switches does docker need? And which NOT?"). Seems the periodic timer is
> not starting at all. Debugging...
>=20
> BTW, you have a bug in your test, though that is not affecting the
> outcome: PTHREAD_EXPLICIT_SCHED needs to be set in order to lift the
> scheduling class. And then you also need --cap-add SYS_NICE for docker ru=
n.
>=20

Found it:

diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index d7c55df8f1..2f3ea1dec4 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -624,7 +624,7 @@ int __cobalt_thread_create(unsigned long pth, int polic=
y,
 		return ret;
 	}
=20
-	if (!thread_hash(&hkey, thread, task_pid_vnr(p))) {
+	if (!thread_hash(&hkey, thread, task_pid_nr(p))) {
 		ret =3D -EAGAIN;
 		goto fail;
 	}
@@ -682,7 +682,7 @@ cobalt_thread_shadow(struct cobalt_local_hkey *hkey,
 		return ERR_PTR(ret);
 	}
=20
-	if (!thread_hash(hkey, thread, task_pid_vnr(current))) {
+	if (!thread_hash(hkey, thread, task_pid_nr(current))) {
 		ret =3D -EAGAIN;
 		goto fail;
 	}

Means, the threads were internally hashed under their vpid, rather than=20
the global pid as it would be correct (for global lookups).

Will send a proper patch update soon.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

