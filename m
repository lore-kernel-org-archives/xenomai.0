From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Tue, 9 Dec 2014 20:47:54 +0000
Message-ID: <61165410f8a5408a8b2ff2fac74fd503@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
 <20141209200820.GM30777@hermes.click-hack.org>
 <f69c049b31224616ba6bc009a84f8daf@EX132MBOX1A.de2.local>
 <20141209202403.GN30777@hermes.click-hack.org>
 <bd93d35340054a42bf93a42139954d1f@EX132MBOX1A.de2.local>,
 <20141209203738.GO30777@hermes.click-hack.org>
In-Reply-To: <20141209203738.GO30777@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>> >>=0A=
>> >> >>  #ifndef DEFINE_SEMAPHORE=0A=
>> >> >>  /* Legacy DECLARE_MUTEX vanished in 2.6.37 */=0A=
>> >> >>  #define DEFINE_BINARY_SEMAPHORE(sem) DECLARE_MUTEX(sem)=0A=
>> >> >> -#elif defined(CONFIG_PREEMPT_RT)=0A=
>> >> >> -#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem, 1)=0A=
>> >> >> +#elif defined(CONFIG_PREEMPT_RT_FULL)=0A=
>> >> >> +#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)=0A=
>> >> >>  #else=0A=
>> >> >>  #define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)=0A=
>> >> >>  #endif=0A=
>> >>=0A=
>> >> > Why that change? I mean in 2.6.37, the define was CONFIG_PREEMPT_RT=
=0A=
>> >> > anwyay.=0A=
>> >>=0A=
>> >> If DEFINE_SEMAPHORE is not defined we are below 2.6.37. So for 2.6.37=
 and above CONFIG_PREEMPT_RT was checked.=0A=
>>=0A=
>> > Well, are not we in the "elif" case of the #ifndef DEFINE_SEMAPHORE,=
=0A=
>> > so DEFINE_SEMAPHORE is defined, or am I missing something ?=0A=
>>=0A=
>> Let me explain that more in detail:=0A=
>>=0A=
>> DEFINE_SEMAPHORE is defined for linux >=3D 2.6.37=0A=
>>=0A=
>> So for linux 2.6.37 we are in=0A=
>>=0A=
>> #elif defined(CONFIG_PREEMPT_RT)=0A=
>>=0A=
>> Also in linux 3.0.0 we are in that elif. Since in 3.0.0 and above CONFIG=
_PREEMPT_RT=0A=
>> was changed to CONFIG_PREEMPT_RT_FULL, so we have to use the latter one =
instead.=0A=
=0A=
> Ok, but please the two ifdefs then, one for PREEMPT_RT and the other=0A=
> for PREEMT_RT_FULL. This will avoid breaking is someone decides to=0A=
> change the header and moves the chunks around.=0A=
=0A=
Sorry, maybe I am a little bit confused but I do not understand what you me=
an. There is only one =0A=
ifdef using CONFIG_PREEMPT_RT. This is required for compatibility to lower =
kernel versions=0A=
to introduce newer CONFIG_PREEMPT_RT_FULL. All other code parts are using =
=0A=
CONFIG_PREEMPT_RT_FULL afterwards.=0A=
=0A=
> Also, I believe the hunk is still wrong, it replaces:=0A=
> #define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem, 1)=0A=
> with:=0A=
> #define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)=0A=
=0A=
Your are right, that's true! In newer kernel version DEFINE_SEMAPHORE does =
accept only=0A=
one argument. But I am not sure why and in which version. So I will check h=
ow to do here.=0A=
=0A=
Regards,=0A=
Christoph=0A=

