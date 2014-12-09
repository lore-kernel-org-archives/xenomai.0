Date: Tue, 9 Dec 2014 21:55:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141209205508.GP30777@hermes.click-hack.org>
References: <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
 <20141209200820.GM30777@hermes.click-hack.org>
 <f69c049b31224616ba6bc009a84f8daf@EX132MBOX1A.de2.local>
 <20141209202403.GN30777@hermes.click-hack.org>
 <bd93d35340054a42bf93a42139954d1f@EX132MBOX1A.de2.local>
 <20141209203738.GO30777@hermes.click-hack.org>
 <61165410f8a5408a8b2ff2fac74fd503@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61165410f8a5408a8b2ff2fac74fd503@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 09, 2014 at 08:47:54PM +0000, Stoidner, Christoph wrote:
> >> >>
> >> >> >>  #ifndef DEFINE_SEMAPHORE
> >> >> >>  /* Legacy DECLARE_MUTEX vanished in 2.6.37 */
> >> >> >>  #define DEFINE_BINARY_SEMAPHORE(sem) DECLARE_MUTEX(sem)
> >> >> >> -#elif defined(CONFIG_PREEMPT_RT)
> >> >> >> -#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem, 1)
> >> >> >> +#elif defined(CONFIG_PREEMPT_RT_FULL)
> >> >> >> +#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)
> >> >> >>  #else
> >> >> >>  #define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)
> >> >> >>  #endif
> >> >>
> >> >> > Why that change? I mean in 2.6.37, the define was CONFIG_PREEMPT_RT
> >> >> > anwyay.
> >> >>
> >> >> If DEFINE_SEMAPHORE is not defined we are below 2.6.37. So for 2.6.37 and above CONFIG_PREEMPT_RT was checked.
> >>
> >> > Well, are not we in the "elif" case of the #ifndef DEFINE_SEMAPHORE,
> >> > so DEFINE_SEMAPHORE is defined, or am I missing something ?
> >>
> >> Let me explain that more in detail:
> >>
> >> DEFINE_SEMAPHORE is defined for linux >= 2.6.37
> >>
> >> So for linux 2.6.37 we are in
> >>
> >> #elif defined(CONFIG_PREEMPT_RT)
> >>
> >> Also in linux 3.0.0 we are in that elif. Since in 3.0.0 and above CONFIG_PREEMPT_RT
> >> was changed to CONFIG_PREEMPT_RT_FULL, so we have to use the latter one instead.
> 
> > Ok, but please the two ifdefs then, one for PREEMPT_RT and the other
> > for PREEMT_RT_FULL. This will avoid breaking is someone decides to
> > change the header and moves the chunks around.
> 
> Sorry, maybe I am a little bit confused but I do not understand
> what you mean. There is only one ifdef using CONFIG_PREEMPT_RT.
> This is required for compatibility to lower kernel versions to
> introduce newer CONFIG_PREEMPT_RT_FULL. All other code parts are
> using CONFIG_PREEMPT_RT_FULL afterwards.

This is what I asked in Xenomai code. But in wrappers.h, I would
prefer the code to not depend on the order of the definitions.

Currently, you have, at the beginning of the file

#if whatever
#ifdef CONFIG_PREEMPT_RT
#define CONFIG_PREEMPT_RT_FULL
#endif
#endif

And later:

#ifdef CONFIG_PREEMPT_RT_FULL

This works because if we are in the PREEMPT_RT case, the define at
the top of the file will get PREEMT_RT_FULL defined.

Now, if someone decides to move the ifdef from the top of the file
to the bottom of the file. The binary semaphore defines breaks.

Whereas if at the bottom of the file, you use:

#ifdef CONFIG_PREEMPT_RT
foo
#elif define CONFIG_PREEMPT_RT_FULL
foo

You no longer have this issue.

Beware of these ifdefs, breakage is easy and may long stay
unnoticed.

-- 
					    Gilles.

