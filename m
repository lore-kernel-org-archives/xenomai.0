Date: Tue, 12 Mar 2013 10:29:38 +0100
From: =?utf-8?q?Petr_Cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20130312102938.B04FB5F2@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] =?utf-8?q?mutex_problem?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Gilles_Chanteperdrix?= <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

> Od: "Gilles Chanteperdrix"=20
> Komu: Petr Cervenka=20
> Datum: 11.03.2013 14:05
> P=C5=99edm=C4=9Bt: Re: [Xenomai] mutex problem
>
> CC: "Xenomai" <xenomai@xenomai.org>
>On 03/11/2013 11:35 AM, Petr Cervenka wrote:
>
>> The problem with mutexes is still present. I'm really desperate now.
>> Does anyone know, how the mutex could "stay locked" when every
>> "acquire" is sooner or later followed by "release" and both functions
>> always return 0 (success) code? Every advice is appreciated.
>
>
>Could you provide us with a simple test case which would allow us to
>reproduce the problem?
>
>Other than that, you can try forcing the path through the kernel for
>every mutex call, enable the I-pipe tracer, and trigger a trace as soon
>as you detect that the mutex is not free after a release.
>

Sadly, I'm not able to reproduce it with simple test.
Maybe I was not clear, the mutex stays not locked after "release". But I =
think it is locked by something else because the seldom strange behavior.=
 Example of it follows:
Imagine threads A and B
A acquires lock
A releases lock
B acquires lock
B releases lock
B tries to acquire lock, but the mutex is already locked and the owner is=
 A!

Also the inicialization order of threads/mutexes/... transfered the probl=
em to another mutex (and threads). Owner is the same thread as before (hi=
 priority, short time period).

PS: Meanwhile I found another mutex, which was deleted immediately after =
creation, but commonly used later.

Petr

