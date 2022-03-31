Date: Thu, 31 Mar 2022 10:36:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <637249774.202758.1648715778757.JavaMail.zimbra@nod.at>
In-Reply-To: <74b8e93cc14b656f6d97bff5d6ef2c2dd606f64b.camel@siemens.com>
References: <20220330201614.31083-1-richard@nod.at>
 <74b8e93cc14b656f6d97bff5d6ef2c2dd606f64b.camel@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>

----- Urspr=C3=BCngliche Mail -----
> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
> I can't say much about the alchemy skin. Never used that myself. Have
> you checked the history if such a change was / could be intentional?
> CCing Jan...

Well, an application that relies on rt_task_unblock() now no longer works
with Xenomai 3. It used to work with 2.6.

In 2019 this was briefly discussed:
https://www.mail-archive.com/xenomai@xenomai.org/msg15990.html

Finally I found some cycles to work on that.

With my changes at least the application works again and the tests
on the customer side pass.
=20
> The following comments are more or less implementation details...
>=20
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
>=20
> COBALT_DECL should only be necessary for functions that live in the
> libc namespace and that need to be "intercepted" / affected by wrapping
> at linker level.
>=20
> Your function looks libcobalt specific and as such should probably not
> live in the pthread_mutex_ namespace and generating the wrappers seems
> unnecessary.

Ok!

[...]

>> +COBALT_IMPL(int, pthread_mutex_lock_eintr_np, (pthread_mutex_t *mutex))
>> +{
>> +=09return __pthread_mutex_lock(mutex, true);
>> +}
>=20
> Same as above. Looks libcobalt specific and the wrapping part seems
> unnecessary.

Ok.

Thanks,
//richard

