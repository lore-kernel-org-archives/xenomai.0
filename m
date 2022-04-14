Date: Thu, 14 Apr 2022 14:58:39 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <2065449276.254073.1649941119506.JavaMail.zimbra@nod.at>
In-Reply-To: <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
References: <20220413215819.22954-1-richard@nod.at>
 <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
Subject: Re: [PATCH v2 0/9] Revive alchemy, pSOS and VxWorks tests
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> An: "richard" <richard@nod.at>, "xenomai" <xenomai@xenomai.org>
> Gesendet: Donnerstag, 14. April 2022 13:18:59
> Betreff: Re: [PATCH v2 0/9] Revive alchemy, pSOS and VxWorks tests

> On 13.04.22 23:58, Richard Weinberger via Xenomai wrote:
>> This patch series is a first attempt to integrate the currently abandone=
d
>> alchemy, pSOS and VxWorks tests into Xenomai's test suite.
>> Since each test assumes running as own process a test driver is needed
>> which executes each tests separately.
>> The driver makes use of the smokey framework.
>>=20
>> Test results on a x86 VM (5.15.19, Xenomai master as of today):
>> - Alchemy:
>>   test2 fails:
>> =09[8] at task-2.c:71
>> =09[1] at task-2.c:24
>> =09[9] at task-2.c:79
>> =09[4] at task-2.c:43
>> =09[10] at task-2.c:87
>> =09[5] at task-2.c:48
>> =09[11] at task-2.c:92
>> =09[2] at task-2.c:29
>> =09[6] at task-2.c:52
>> =09   0"022.972| BUG in __traceobj_check_abort(): [FGND] wrong return st=
atus:
>> =09=09      task-2.c:55 =3D> EINVAL (want OK)

task-2 seems suffers from modern gcc, changes to safety and count are dead =
stores.

This makes the test pass here:

diff --git a/testsuite/alchemytests/task-2.c b/testsuite/alchemytests/task-=
2.c
index e751ddd34..9d5281c75 100644
--- a/testsuite/alchemytests/task-2.c
+++ b/testsuite/alchemytests/task-2.c
@@ -28,8 +28,10 @@ static void background_task(void *arg)
=20
        traceobj_mark(&trobj, 2);
=20
-       while (--safety > 0)
+       while (--safety > 0) {
+               compiler_barrier();
                count++;
+       }
=20
        traceobj_exit(&trobj);
 }

...same does marking both variables as volatile.

Thanks,
//richard

