Message-ID: <2ff1a98a0805140831w6c9b2c2ble3cefec79dce1081@domain.hid>
Date: Wed, 14 May 2008 17:31:05 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0805140817v45065492qe292b872584950cf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200805112104.56166.karl-trampe@domain.hid> <48276703.2020005@domain.hid>
	<20080514144900.216230@domain.hid> <482AFF6C.20903@domain.hid>
	<2ff1a98a0805140817v45065492qe292b872584950cf@domain.hid>
Subject: Re: [Xenomai-help] [RTnet-users] Ideas how to measure delays with
	RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

On Wed, May 14, 2008 at 5:17 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> On Wed, May 14, 2008 at 5:04 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>  >
>  > Karl Reichert wrote:
>  >  > Jan Kiszka wrote:
>  >  >> Karl Reichert wrote:
>  >  >>> Hello,
>  >  >>>
>  >  >>> I have two stations running RTnet, one as a master and one as a slave. I
>  >  >> want
>  >  >>> to measure the time, which a message, sent from master to slave, takes.
>  >  >> But,
>  >  >>> I don't want the time of the transmission only, but the complete time of
>  >  >> all
>  >  >>> software layers this data is processed through.
>  >  >>>
>  >  >>> _______________     _______________
>  >  >>> |           A                 |     |               D                 |
>  >  >>> |______________|    |______________|
>  >  >>> |           B                 |     |               C                 |
>  >  >>> |______________|    |______________|
>  >  >>> |   RTnet (Master)    |     |    RTnet (Slave)        |
>  >  >>> |______________|    |______________|
>  >  >>>             |                                 |
>  >  >>>             |______________|
>  >  >>>
>  >  >>> So, I create the data, that should be send, in Layer A (Master) and send
>  >  >> it
>  >  >>> over RTnet to Layer D (Slave).
>  >  >>>
>  >  >>> I want to take the time when the data leaves A and when it arrives D
>  >  >> with
>  >  >>> rtdm_clock_read(). If I have the offset between master and slave, I can
>  >  >>> calculate the time it took to pass A, B, both RTnet stacks, C and D.
>  >  >>>
>  >  >>> As RTnet keeps track of the offset in it's stack, I want to use this
>  >  >> value. Is
>  >  >>> it possible via the API? I didn't found anything. Or do I have to
>  >  >> manipulate
>  >  >>> the stack to pass the offset to the higher layers (C and D)?
>  >  >> If RTmac/TDMA is in use, you can obtain the clock offset via
>  >  >> RTMAC_RTIOC_TIMEOFFSET from the RTDM device "TDMA<x>" (where "<x>"
>  >  >> corresponds to "rteth<x>").
>  >  >>
>  >  >> Jan
>  >  >>
>  >  >
>  >  > When I try to compile my application (xenomai native skin, user task), I get an error, saying rtdm_driver.h (which contains the prototype for rtdm_clock_read()) is for kernel mode tasks only.
>  >
>  >  So you are in userland, obviously...
>  >
>  >
>  >  >
>  >  > How can I get a timestamp in a xenomai native user task? Is there sth equivalent to rtdm_clock_read()? Or do I have to write a kernel task?
>  >
>  >  Nope, there is rt_timer_read & Co. for native user-mode applications.
>  >
>  >  I was about to remark that everything can be found in the API docs - but
>  >  it can't! Any volunteer to add the missing functions from native/timer.h
>  >  to the docs? Maybe there is just something broken for doxygen. TIA!
>
>  The problem is that __KERNEL__ is in the list of PREDEFINED macros,
>  and the comments in native/timer.h are in the !__KERNEL__ section.

Other headers do #if (defined(__KERNEL__) || defined(__XENO_SIM__)) &&
!defined(DOXYGEN_CPP)
Maybe we should use the same construction in native/timer.h ?

-- 
 Gilles

