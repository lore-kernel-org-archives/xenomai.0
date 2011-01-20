Message-ID: <4D384CC9.2040303@domain.hid>
Date: Thu, 20 Jan 2011 15:55:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101200922440.1211@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org, Pierre.QUELIN@solystic.com

Kolja Waschk wrote:
> Hi,
> 
>> pthread_cond_wait (). it returns EPERM when the application is started with gdb.
> 
> I also stumbled over this
> 
> (see https://mail.gna.org/public/xenomai-help/2010-12/msg00080.html)
> 
> and so far have not found a solution. 

The issue is probably that pthread_cond_wait ends-up trying to relock
the mutex which is already locked while being restarted when handling
gdb signals. The way to debug this issue is simply to follow the path of
pthread_cond_wait when running under gdb, adding printks along the way.
This is far from being a problem for which no solution can be found.

Now, since I never got this issue, I assumed it must be specific to the
kernel or glibc you were using (you are using uclinux on blackfin with
linuxthreads, which is a very specific setup). We now have an other
occurrence of this issue, so it must be generic.

The thing is, I am unable to reproduce it. So, I am going to describe
the way I test this:

I launch cond-torture-posix inside gdb (gdbserver actually)
in gdb, type "handle SIG34 pass nostop noprint"
then "run"
And the program runs without troubles.

So, could you describe me exactly the procedure you are following wich
allows to reproduce this issue?


> In my application, there's a tight loop
> calling pthread_cond_wait and I have to issue usleep(100) in case of EPERM, to
> avoid total lockup when running with gdbserver. It is absolutely no issue
> without gdbserver though.

As already explained too, when a service returns an error, if you call
the same service again, you will get the same error, and if this service
is a primary mode service, you are guaranteed to lock-up, because you
essentially create an infinite loop in primary mode. If you fail to take
care of the errors returned by OS services, then your application is at
fault. In other words, the lockup is not due to the pthread_cond_wait
bug, it is due to your application bad coding style.

-- 
                                                                Gilles.

