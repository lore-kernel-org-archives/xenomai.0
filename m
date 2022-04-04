Date: Mon, 4 Apr 2022 14:17:47 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <169724307.214985.1649074667197.JavaMail.zimbra@nod.at>
In-Reply-To: <70be73c4-2b97-7a92-014d-5655a489a0b2@siemens.com>
References: <20220330201614.31083-1-richard@nod.at>
 <70be73c4-2b97-7a92-014d-5655a489a0b2@siemens.com>
Subject: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX
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
> Gesendet: Montag, 4. April 2022 13:21:45
> Betreff: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX

> On 30.03.22 22:16, Richard Weinberger via Xenomai wrote:
>> Starting with Xenomai 3, RT_MUTEX is based on libcobalt's pthread mutex
>> implementation.
>> POSIX requires that pthread_mutex_lock() shall not return EINTR,
>> this requirement breaks rt_task_unblock() if a RT_TASK blocks on
>> a RT_MUTEX.
>>=20
>> To restore the functionality provide a new function,
>> pthread_mutex_lock_eintr_np().
>> It can get interrupted and will return EINTR to the caller.
>>=20
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  include/cobalt/pthread.h |  2 ++
>>  lib/alchemy/mutex.c      |  2 +-
>>  lib/cobalt/mutex.c       | 14 ++++++++++++--
>>  3 files changed, 15 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/include/cobalt/pthread.h b/include/cobalt/pthread.h
>> index 3e9bd47053bc..2994c2467219 100644
>> --- a/include/cobalt/pthread.h
>> +++ b/include/cobalt/pthread.h
>> @@ -62,6 +62,8 @@ COBALT_DECL(int, pthread_mutex_destroy(pthread_mutex_t
>> *mutex));
>> =20
>>  COBALT_DECL(int, pthread_mutex_lock(pthread_mutex_t *mutex));
>> =20
>> +COBALT_DECL(int, pthread_mutex_lock_eintr_np(pthread_mutex_t *mutex));
>> +
>>  COBALT_DECL(int, pthread_mutex_timedlock(pthread_mutex_t *mutex,
>>  =09=09=09=09=09 const struct timespec *to));
>> =20
>> diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
>> index f8933858647a..bb97395142aa 100644
>> --- a/lib/alchemy/mutex.c
>> +++ b/lib/alchemy/mutex.c
>> @@ -327,7 +327,7 @@ int rt_mutex_acquire_timed(RT_MUTEX *mutex,
>> =20
>>  =09/* Slow path. */
>>  =09if (abs_timeout =3D=3D NULL) {
>> -=09=09ret =3D -__RT(pthread_mutex_lock(&mcb->lock));
>> +=09=09ret =3D -__RT(pthread_mutex_lock_eintr_np(&mcb->lock));
>=20
> This won't build for mercury, will it?

Uff yes. Just tried building with --with-core=3Dmercury and it failed. ;-\

So, when mercury is enabled, alchemy will use NPTL.
This means rt_task_unblock() cannot work on mercury because
pthread_mutex_lock() will not return EINTR either.

Fixing the build for mercury should be easy by adding an ifdef CONFIG_XENO_=
MERCURY.
But I'm not sure how to fix unblocking for the mercury case.

Thanks,
//richard

