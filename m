Date: Tue, 9 Dec 2014 21:08:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141209200820.GM30777@hermes.click-hack.org>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>
 <20141207135204.GT10014@hermes.click-hack.org>
 <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
 <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acbe2f0f37f447bea2205fcafd963830@EX132MBOX1A.de2.local>
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

On Tue, Dec 09, 2014 at 08:06:03PM +0000, Stoidner, Christoph wrote:
> 
> Hi Gilles,
> 
> >> Well, then you need to replace #ifdef CONFIG_PREEMPT_RT with
> >> CONFIG_PREEMPT_RT_FULL, and test the kernel version in wrappers.h to
> >> define CONFIG_PREEMPT_RT_FULL if CONFIG_PREEMPT_RT is dedined for
> >> old kernels.
> 
> >I have applied both changes and try if this solves the my problem. If it works I will publish the patch here.
> 
> below you can find the patch. It solves the problem concerning "sleeping function called from invalid context" when using PREEMPT RT. Would it be reasonable to apply that change to GIT repository?

Yes, of course.

>  #ifndef DEFINE_SEMAPHORE
>  /* Legacy DECLARE_MUTEX vanished in 2.6.37 */
>  #define DEFINE_BINARY_SEMAPHORE(sem) DECLARE_MUTEX(sem)
> -#elif defined(CONFIG_PREEMPT_RT)
> -#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem, 1)
> +#elif defined(CONFIG_PREEMPT_RT_FULL)
> +#define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)
>  #else
>  #define DEFINE_BINARY_SEMAPHORE(sem) DEFINE_SEMAPHORE(sem)
>  #endif

Why that change? I mean in 2.6.37, the define was CONFIG_PREEMPT_RT
anwyay.

-- 
					    Gilles.

