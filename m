Message-ID: <513F1CF6.8010306@xenomai.org>
Date: Tue, 12 Mar 2013 13:17:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20130312102938.B04FB5F2@centrum.cz>
In-Reply-To: <20130312102938.B04FB5F2@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] mutex problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 03/12/2013 10:29 AM, Petr Cervenka wrote:

>> Od: "Gilles Chanteperdrix" Komu: Petr Cervenka Datum: 11.03.2013
>> 14:05 P=C5=99edm=C4=9Bt: Re: [Xenomai] mutex problem
>>=20
>> CC: "Xenomai" <xenomai@xenomai.org> On 03/11/2013 11:35 AM, Petr
>> Cervenka wrote:
>>=20
>>> The problem with mutexes is still present. I'm really desperate
>>> now. Does anyone know, how the mutex could "stay locked" when
>>> every "acquire" is sooner or later followed by "release" and both
>>> functions always return 0 (success) code? Every advice is
>>> appreciated.
>>=20
>>=20
>> Could you provide us with a simple test case which would allow us
>> to reproduce the problem?
>>=20
>> Other than that, you can try forcing the path through the kernel
>> for every mutex call, enable the I-pipe tracer, and trigger a trace
>> as soon as you detect that the mutex is not free after a release.
>>=20
>=20
> Sadly, I'm not able to reproduce it with simple test.


That is a rather good news.

> Maybe I was not
> clear, the mutex stays not locked after "release".


The thing is, Xenomai only modifies the mutex memory during the mutex
services, so, if the problem happens between the time the mutex is
released and the time the next acquistion is done, then something else
than xenomai services changes the content of the mutex memory. There are
two possible culprits:
- your application
- the kernel-side of Xenomai.

You could try recompiling without CONFIG_XENO_FASTSYNCH and see if you
still get the issue. If you still get it, the issue definitely comes
from Xenomai kernel side.

 But I think it is
> locked by something else because the seldom strange behavior. Example
> of it follows: Imagine threads A and B A acquires lock A releases
> lock B acquires lock B releases lock B tries to acquire lock, but the
> mutex is already locked and the owner is A!
>=20
> Also the inicialization order of threads/mutexes/... transfered the
> problem to another mutex (and threads). Owner is the same thread as
> before (hi priority, short time period).


This makes think about a memory issue. Is it possible to recompile your
application without xenomai and run it with valgrind?

>=20
> PS: Meanwhile I found another mutex, which was deleted immediately
> after creation, but commonly used later.


Well, yes, that could cause such issues. Could you try setting
mutex->fastlock to NULL in rt_mutex_delete?

--=20
                                                                Gilles.


