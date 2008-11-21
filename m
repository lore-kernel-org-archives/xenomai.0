Message-ID: <4926203E.4080707@domain.hid>
Date: Fri, 21 Nov 2008 03:43:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <c024fefc0811200055r309fbedar73531c856f27565a@domain.hid>	<3f7e4e30c68612bf269e955922cf6f82.squirrel@domain.hid>
	<c024fefc0811201603k4f99f2aap28645594b0167198@domain.hid>
In-Reply-To: <c024fefc0811201603k4f99f2aap28645594b0167198@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interprocess Mutex
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <me@domain.hid>
Cc: xenomai@xenomai.org

Adrian Boeing wrote:
> Hi Gilles, thanks for the reply.
> 
> In my test (pseudo) code with rt_mutex:
> (without bind):
> int main() {

   err = rt_task_shadow(...);

>  err = rt_mutex_create(&mutex_desc,0);
>  err =  rt_mutex_acquire(&mutex_desc,TM_INFINITE); //fails with -1!
> }
> (with bind):
> int main() {


   err = rt_task_shadow(...);

>  err = rt_mutex_create(&Kmutex_desc,"bob");
>  err = rt_mutex_bind(&mutex_desc,"bob",TM_INFINITE);
>  err =  rt_mutex_acquire(&mutex_desc,TM_INFINITE); //fails with -1!
> }
> 
> Both of these fail to acquire the mutex with "EPERM" :: (this service
> was called from a context which cannot be given the ownership of the mutex).
> 
> Is there something special I need to do in order to do this in user space?
>

Those Xenomai syscalls are only available to Xenomai threads; rt_task_shadow()
turns a regular Linux pthread into a Xenomai-enabled RT thread. rt_task_shadow()
has to be called once when you don't want to spawn a new RT task using the
rt_task_create() interface, but promote the current Linux pthread to the Xenomai
real-time domain. In short, it associates a Xenomai task control block to the
underlying Linux task, so that both Xenomai and Linux schedulers can handle it.

> Thanks,
> -Adrian
> 
> On Thu, Nov 20, 2008 at 9:48 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
> 
>     Adrian Boeing wrote:
>     > Hi,
>     >
>     > Is it possible to create an inter-process mutex between kernel
>     space and
>     > user space?
>     > If so, how is this done with the native API?
>     >
>     > The system has one real-time kernel process which communicates
>     with other
>     > processes via shared memory.
> 
>     See rt_mutex_bind:
>     http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__mutex.html#g39b3a0e7f6f6ee41b8068ed59e25d1d1
>     or, for the posix skin, pthread_mutexattr_setpshared:
>     http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__posix__mutex.html#g73bd8697b91e0ee9a63c30052ac9f72f
>     Note that for sharing a mutex with the posix skin, the pthread_mutex_t
>     structure needs to reside on a shared memory.
> 
>     --
>                        Gilles.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

