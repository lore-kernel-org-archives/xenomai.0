From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1003181256580.1499@domain.hid>
References: <alpine.DEB.1.10.1003181256580.1499@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 14:38:12 +0100
Message-ID: <1268919492.27899.362.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with absolute timeout
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Thu, 2010-03-18 at 14:29 +0100, Kolja Waschk wrote:
> Hi,
> 
> Sorry for bothering the list with this probably silly problem, but I just don't have the right idea.
> 
> The POSIX skin sem_timedwait() call doesn't wait!? I expected the following test code to take 2 seconds until it finishes (and that holds true on a PC), but instead, it returns immediately. What am I doing wrong here?
> 
> 
> #include <errno.h>
> #include <sys/time.h>
> #include <semaphore.h>
> 
> int main()
> {
>      int r;
>      sem_t s;
>      struct timeval tv;
>      struct timespec ts;
> 
>      r = sem_init(&s, 0, 0);
>      if (r != 0) { perror("sem_init"); return errno; }
> 
>      r = gettimeofday(&tv, 0);
>      if (r != 0) { perror("gettimeofday"); return errno; }

gettimeofday() is not the right time base for a Xenomai call. Try
clock_gettime(CLOCK_MONOTONIC/CLOCK_REALTIME...). CLOCK_MONOTONIC is
faster if you don't require the returned time to be adjusted on the
linux time.

> 
>      // Same result with TIMEVAL_TO_TIMESPEC
>      ts.tv_sec = tv.tv_sec;
>      ts.tv_nsec = tv.tv_usec * 1000;
> 
>      ts.tv_sec += 2;
> 
>      r = sem_timedwait(&s, &ts);
>      if (r != 0) { perror("sem_timedwait"); return errno; }
> }
> 
> The result is always !0, errno = 110(ETIMEDOUT), immediately after starting.
> 
> /tmp # time ./totest 
> sem_timedwait: Connection timed out
> Command exited with non-zero status 110
> real	0m 0.00s
> user	0m 0.00s
> sys	0m 0.00s
> 
> 
> Test environment: Blackfin uClinux-dist 2009R1.1-RC4 (Xenomai 2.4.7, 2.6.28.10/I-Pipe 1.10.0)
> but also tried and failed with Xenomai 2.5-rc4 in Kernel 2.6.31.6.
> 
> Thanks for any hints!
> Kolja
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



