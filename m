Message-ID: <4B587D31.4070503@domain.hid>
Date: Thu, 21 Jan 2010 17:13:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Gophermail.2.0.1001210959431.7980@domain.hid>
In-Reply-To: <Gophermail.2.0.1001210959431.7980@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] using the RTAI skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gohlx002@domain.hid
Cc: xenomai@xenomai.org

gohlx002@domain.hid wrote:
> Hello all,
> 
> I'm doing some investigation on migrating my application from RTAI to 
> Xenomai. From the description of a Xenomai skin, it seems like I might be 
> able to use the RTAI skin to run my application "as is". Along this line, I 
> put together a small test application in RTAI that would be very 
> illustrative if I can get it to run in Xenomai. The first step is of course 
> compiling it which I haven't been able to do because of missing references 
> to all the RTAI functions (e.g. rt_task_init_schmod). If someone feels like 
> helping out, we could work through this whole process (from an RTAI app to 
> running on Xenomai) and turn this into another example to add to the 
> examples folder for future reference. Here's the application I'm trying to 
> compile (the Makefile I just adapted from the native examples folder and 
> changed the application name):

The RTAI skin is mostly kernel-space. User-space only supports a few 
things (like shared memory). In an case, to find what is supported, 
check src/skins/rtai in xenomai sources tree.

In the makefile, what is important is:

XENO_DESTDIR=/path/to/xenomai/installation/root
XENO_CONFIG=$(XENO_DESTDIR)/usr/local/bin/xeno-config)
XENO_RTAI_CPPFLAGS=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --cflags)
XENO_RTAI_LDFLAGS=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --ldflags) -lrtai

then add XENO_RTAI_CPPFLAGS to your program CPPFLAGS or CFLAGS, and
add XENO_RTAI_LDFLAGS to your program LDFLAGS.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

