Date: Fri, 28 Aug 2015 01:49:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150827234940.GE20679@hermes.click-hack.org>
References: <55DF83E0.1060006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55DF83E0.1060006@gmail.com>
Subject: Re: [Xenomai] timer_create( ) invalid argument
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantinos Chalas <konchalas@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Aug 27, 2015 at 11:40:48PM +0200, Konstantinos Chalas wrote:
> Hello,
> 
> I have been trying to port some code from the Linux Kernel to the Cobalt
> Kernel, with no success.
> 
> When trying to call timer_create( ), i am getting the error timer_create:
> Invalid argument
> 
> I made the code snippet as small as possible.
> 
> #include <time.h>
> #include <signal.h>
> #include <stdio.h>
> 
> void timerfunction(union sigval handler)
> {
>         printf("timerfunction hello\n");
> }
> 
> int main(int argc, char** argv)
> {
>         timer_t t;
> 
>         struct sigevent se;
> 
>         se.sigev_value.sival_ptr = 0;
>         se.sigev_signo = 0;
>         se.sigev_notify =  SIGEV_THREAD_ID;
> 
>         se.sigev_notify_attributes = 0;
>         se.sigev_notify_function = timerfunction;
> 
>         if (timer_create(CLOCK_REALTIME, &se, &t) != 0) {
>                 perror("timer_create");
>         }
>         return 0;
> }

I never tried using SIGEV_THREAD_ID with Xenomai, but I would expect
a valid thread id to be required when doing this.

-- 
					    Gilles.
https://click-hack.org

