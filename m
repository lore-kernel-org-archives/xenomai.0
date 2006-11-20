Message-ID: <45617576.8040509@domain.hid>
Date: Mon, 20 Nov 2006 10:29:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] MPC5200 OOPS time
References: <DD39B5C3F4963040ADC9768BE7E430CB015D4834@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D4834@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Hi,
> 
> 
> Gilles Chanteperdrix wrote:
> 
>>You should set the threads stack size with pthread_attr_setstacksize
>>(as other pthread_attr_set* functions, it should be used on a
>>previously initialized pthread_attr_t structure), ulimit -s only set
>>the stack size of the main thread, at least on some architectures.   
> 
> 
> pthread_attr_setstacksize() doesn't work for us. The system still does
> allocate the default linux stack size. Whereas ulimit -s sets the stack
> size for all created threads correctly.

pthread_attr_setstacksize does not work for the main thread, but works
for other threads on all architectures where I tested it, could you
check the return value ?

> 
> Can this confirm somebody with an mpc5200B based board (e.g. icecube,
> lite5200) ?
> 
> 
>>This is probably unrelated to the errors you see, but:
>>- passing the pthread_mutex_t by value is not supposed to work; once
>>a pthread_mutex_t is initialized with pthread_mutex_init, you should
>>pass the address of the very same pthread_mutex_t to other functions
>>of the API.  
> 
> 
> Hmm, this is mystique to me. pthread_mutex_t is a structure returned by
> value from within MutexCreate(). Passing structures back by value
> doesn't do harm to them. Also the pthread_mutex function seem to operate
> normally.

It works with Xenomai posix skin, because the structure simply holds a
pointer to the real structure used by the kernel, but this is so for
quite unobvious reasons (namely because sizeof(pthread_mutex_t) is to
small, and because it allows pthread_mutex_t to be shared between kernel
and user-space). But an implementation of the POSIX API could decide to
put the mutex lock count in the pthread_mutex_t structure, or to put the
pthread_mutex_t in a linked list, in these two cases, copying the
pthread_mutex_t would be wrong.


-- 
                                                 Gilles Chanteperdrix

