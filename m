Message-ID: <455DE97D.6020701@domain.hid>
Date: Fri, 17 Nov 2006 17:55:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] MPC5200 OOPS time
References: <DD39B5C3F4963040ADC9768BE7E430CB015D480C@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D480C@is-hdq-exchange.marel.net>
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
> attached you find a test program that will badly crash here on our
> ELDK4.0 based MPC5200 board.
>  
> It will create a bunch of tasks, which itself will allocate different
> amount of memory, clock_nanosleep() afterwards and return the allocated
> memory back to the system pool.
> If one gives a reasonable high number as command line argument (number
> of tasks to spawn), you will certainly starve the system memory pretty
> soon.
>  
> There are several (probably unrelated) issues you can trigger with this:
>  
> 1.) Without setting an ulimit -s, just using the standard linux stack
> space and calling it with

You should set the threads stack size with pthread_attr_setstacksize (as
other pthread_attr_set* functions, it should be used on a previously
initialized pthread_attr_t structure), ulimit -s only set the stack size
of the main thread, at least on some architectures.

This is probably unrelated to the errors you see, but:
- passing the pthread_mutex_t by value is not supposed to work; once a
pthread_mutex_t is initialized with pthread_mutex_init, you should pass
the address of the very same pthread_mutex_t to other functions of the API.
- pthread_t, on the other hand is an identifier, and may be passed by
value; if you look at functions taking pthread_t as argument, they all
take the argument by value, except pthread_create. So allocating some
space for these identifiers is useless.

Now, about the errors you see, it would be nice if you could separate
the two issues: could you try hitting ctrl-C when running your program
with stacks small enough so that there is enough room.

-- 
                                                 Gilles Chanteperdrix

