Message-ID: <4CD59C5F.6030808@domain.hid>
Date: Sat, 06 Nov 2010 19:20:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>	<4CD55D61.7050208@domain.hid>
	<AANLkTinw+H2shS4SpxhTS7GNOZptjR8xLpcwpzDtKDmi@domain.hid>
In-Reply-To: <AANLkTinw+H2shS4SpxhTS7GNOZptjR8xLpcwpzDtKDmi@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] detect mode switches to primary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

Peter Pastor wrote:
> Hey Gilles,
> 
> Sorry for all the confusion. I hope my little example pseudo code of the
> boarder line thread makes things clear.
> 
> thread_loop()
> {
> 
> // access memory that is shared with a real-time thread (that does not
> mode switch)
> // calling pthread_mutex_lock causes the current thread to switch to
> primary mode (in case it is not already in primary mode)
> 
>   pthread_mutex_lock( &mutex1 );
> 
> // access shared memory, that is copy memory and nothing else !!
> 
>   pthread_mutex_unlock( &mutex1 );
> 
> // Now, I want the rest of the code to run in secondary mode !!
> // therefore I could simply do a printf or...
> 
> #ifdef __XENO__
>   pthread_set_mode_np(PTHREAD_PRIMARY, 0);
> #endif

This is not needed, the thread will swtich to secondary mode when needed.

> 
> // The thread switched to secondary mode.
> // Now, I process the data and e.g. display it using openGL or read from
> the command line. I want this part of the code to run in secondary mode !!
> 
> // I am using the posix skin (/usr/xenomai/bin/xeno-config --skin posix
> --cflags --ldflags) because I want to be able to compile the code in
> xenomai and ensure real-time capabilities and also compile on a linux
> only system for testing.
> 
> // However, the openGL code or libreadline for example might do a posix
> function call and cause the thread switch back to primary mode which I
> don't want !!! ...and want to detect.

No, dynamic libraries will not call xenomai posix skin functions,
unless, when making the .so, you passed the --wrap flag. Once the .so is
made, --wrap has no effect.

> 
> }
> 
> 
> My current approach to detect whether there was an unwanted mode switch
> from secondary to primary in the non-real-time part of the thread is to
> detect mode switches from primary to secondary using
> pthread_set_mode_np(0, PTHREAD_WARNSW) and signal(SIGXCPU,
> warn_upon_switch)... and do the following
> 
> 
> thread_loop()
> {
> 
> // to check there was an unwanted mode switches to primary mode (in the
> for example openGL code) I simply do a printf
> // and check whether this raises the SIGXCPU signal. If so, the thread
> was running in primary mode, otherwise, the thread was running in
> secondary mode (which is want I want)
> // If the thread switched back and force inside the openGL code, I
> should have noticed it since switching from primary to secondary is
> captured by the SIGXCPU (is it?)
> 
> // here is the code...
> 
> #ifdef __XENO__
>   printf("test\n");  // in case the thread is running in PRIMARY mode,
> this will raise a SIGXCPU signal and we conclude that there was an
> unwanted mode swicht from secondary to primary mode in the openGL code.
>   pthread_set_mode_np(0,PTHREAD_PRIMARY); // this is unnecessary !!!
> ...since calling pthread_mutex_lock switches the thread to primary mode
> automatically.
> #endif
> 
>   pthread_mutex_lock( &mutex1 );
> // access shared memory, that is copy memory and nothing else !!
>   pthread_mutex_unlock( &mutex1 );
> 
> // switch back to SECONDARY mode
> #ifdef __XENO__
>   pthread_set_mode_np(PTHREAD_PRIMARY, 0);
> #endif
> 
> // do non-real-time processing (e.g. openGL stuff, libreadline...).
> 
> }
> 
> The question is, is there a better way to detect this unwanted mode
> switches from secondary to primary mode ?

There is no such thing as unwanted mode switches from secondary mode to
primary mode.


-- 
                                                                Gilles.

