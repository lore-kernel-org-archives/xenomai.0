Message-Id: <200711101125.lAABP0rI027268@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Sat, 10 Nov 2007 12:25:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <18216.16434.853914.993008@domain.hid>
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


> [...]
> As soon as you compile your application with the flags returned by
> xeno-config --posix-cflags and xeno-config --posix-ldflags, it really
> becomes an RT application where all threads are real-time threads. The
> only way to create a non real-time thread in such an application is by
> calling __real_pthread_create.
> 
> 					    Gilles Chanteperdrix.


Hi all,

What is the (default) priority of RT pthreads in comparison with native
rt_task ?

Thanks in advance 

Patrick


