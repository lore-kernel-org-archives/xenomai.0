MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18229.41721.596293.289103@domain.hid>
Date: Sat, 10 Nov 2007 13:24:25 +0100
In-Reply-To: <200711101125.lAABP0rI027268@domain.hid>
References: <18216.16434.853914.993008@domain.hid>
	<200711101125.lAABP0rI027268@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

Patrick wrote:
 > 
 > > [...]
 > > As soon as you compile your application with the flags returned by
 > > xeno-config --posix-cflags and xeno-config --posix-ldflags, it really
 > > becomes an RT application where all threads are real-time threads. The
 > > only way to create a non real-time thread in such an application is by
 > > calling __real_pthread_create.
 > > 
 > > 					    Gilles Chanteperdrix.
 > 
 > 
 > Hi all,
 > 
 > What is the (default) priority of RT pthreads in comparison with native
 > rt_task ?

The default scheduling of RT pthreads is SCHED_OTHER, which means that
their priority is 0. This makes them suitable mostly for non real-time
duties. native rt_task have no default priority, since passing a
priority to rt_task_create is mandatory, but you can create them with a
null priority as well if you like.

-- 


					    Gilles Chanteperdrix.

