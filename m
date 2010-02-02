Message-ID: <4B68A8CA.1090607@domain.hid>
Date: Tue, 02 Feb 2010 23:35:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460D8F07F0@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460D8F07F0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_make_periodic_np initial start date
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> Is there a way to specify no initial delay when calling
> pthread_make_periodic_np?  If I pass a value directly obtained from
> clock_gettime, it will return a ETIMEDOUT error due to time passing
> before I make the call.  I could add a small delay to the value obtained
> from clock_gettime, but I would be concerned that due to other
> happenings in the system, the absolute date may still have passed by the
> time it gets around to calling pthread_make_periodic_np.
> 
> What I would be looking for I guess is what happens when I call
> rt_task_set_periodic with an idate parameter of TM_NOW.  Is there any
> way to simulate this behavior?

pthread_make_periodic_np is a legacy from RTLinux. You should be using
clock_nanosleep instead.

That said, pthread_make_periodic_np internally uses the same service as
rt_task_set_periodic, and TM_NOW is just 0. So, you can probably pass a
timespec with tv_sec and tv_nsec both 0.


-- 
					    Gilles.

