Message-ID: <4C72D8C7.6000303@domain.hid>
Date: Mon, 23 Aug 2010 22:23:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik6qbZkrFyWYC4HQten+EcfHLboiSN2eRtTTqnQ@mail.gmail.com>
In-Reply-To: <AANLkTik6qbZkrFyWYC4HQten+EcfHLboiSN2eRtTTqnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] periodical task in posix skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

ramon costa wrote:
> Hi,
> 
> I have developed a very simple task in native code and it works fine
> (included in native.tar.gz). This
> simple task generates a square waveform through the parallel port ( and also
> the speaker).
> 
> Currently I'm trying to transform this code into the POSIX skin (Makefile
> and .c included in posix,tar.gz).
> Unfortunatelly It does not work, although the parallel port shows a square
> waveform its period is not the desired
> one (0.1ms), its period is very small. This makes the system to freeze.
> 
> It seems that pthread_wait_np is not working properly, or may be I'm not
> using pthread_make_periodic_np
> properly. I used it in the following way :
> 
>         #define PERIOD 100000
> 
>         clock_gettime      ( CLOCK_REALTIME, &now);
>         pthread_make_periodic_np (pthread_self(), &now, (struct timespec
> *)PERIOD);

Well, the reason why this does not work is obvious, I am even amazed
that it does not cause a segmentation fault, but you could check
pthread_make_periodic_np return value to have a clue.

> I also have tried
> 
>        struct timespec period;
>        period.tv_sec=0;
>        period.tv_nsec=PERIOD;
> 
>         clock_gettime      ( CLOCK_REALTIME, &now);
>         pthread_make_periodic_np (pthread_self(), &now,&period);
> 
> Although both compile and execute, non of them works fine to me. Any clue ?

Here I have no clue, more exactly, I would need to see the whole code to
see what is going wrong. But again, checking pthread_make_periodic_np
return value, and looking at the documentation would help. My guess
would be that at the time of pthread_make_periodic_np, "now" is a date
in the past.

And pthread_make_periodic_np/pthread_wait_np are supposed to help
porting code from RTLinux, they should not be used in new programs. You
should be using clock_gettime with the TIMER_ABSTIME flag.

-- 
					    Gilles.

