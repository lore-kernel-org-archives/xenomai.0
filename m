MIME-Version: 1.0
In-Reply-To: <CADvZd9Z8LSPRMAJWb1Tp91i4i9N5wLGMxb3_suaDyFRwRiJd-w@mail.gmail.com>
References: <CADvZd9Z8LSPRMAJWb1Tp91i4i9N5wLGMxb3_suaDyFRwRiJd-w@mail.gmail.com>
Date: Thu, 19 Mar 2015 11:44:36 -0700
Message-ID: <CAEMXjGzNnwnrZOG4AFPbgKrJUpdHiuuVRFOAoKNasy-eVJQ0yg@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RT-CAN question (was: CAN bus on beaglebone black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Thu, Mar 19, 2015 at 2:57 AM, Michael Haberler <haberlerm@gmail.com>
wrote:

> status:
>
> I have Steve Batazzo's driver running on the beaglebone, using a stock
> Xenomai kernel from Robert Nelson's repo (linux-image-3.8.13-xenomai-r71
> from http://repos.rcn-ee.net/debian/), current driver out of tree at
> https://github.com/mhaberler/rtcan-bb branch mah
>
> I also have a preliminary HAL driver for machinekit which talks to a
> Trinamic motor over RT-CAN just fine (beaglebone for now, x86 once I get a
> CAN PCI card).
>
> I'm working with Steve to get the driver polished and hope we can inject it
> into the Xenomai foodchain eventually, after which it will be eventually
> picked up by Robert's periodic builds, and the whole thing becomes an
> 'apt-get install' - affair. But we're not there yet.
>
>
> I have a few questions on RT-CAN (I guess really RTDM):
>
> - can the RTDM API (
> https://xenomai.org/documentation/trunk/html/api/group__userapi.html) be
> used from a normal Posix thread (non-RT) just alike? from the rtcansend*
> utilities src it looks like at least for setup, even if the send/receive
> ops are done in an RT thread.
>
> - socket-CAN and RT-CAN interworking: I assume this is an either-or affair,
> right? (background: for some jobs the RT-CAN features are overkill, and in
> that case something like the python-can binding would be convenient to use)
>
> - in case the above answers are 'yes' and 'no, it's either/or': anybody
> aware of Python bindings for RTDM?
>
> sorry for the noobish questions, climbing the learning curve
>
> - Michael
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>

I am thinking that if the RTDM version of the driver is overkill for what
you are doing, then it may be best to just use the regular Linux driver.
As I understand it from a quick and simple question I recently asked of the
list, if you're using the RTDM driver then its interrupt will be among the
few things able to pre-empt your high priority Xenomai task (assuming you
have any running at the time). So if you really don't need the CAN bus to
be "rt-safe" then it may in some cases be better to have it set up with the
regular Linux driver so that the i-pipe doesn't prioritize it over your RT
tasks. That could also depend on how often you have frames coming in and
whether or not you have danger of overrunning the hardware receive buffer
if the interrupt service routine is neglected while your RT task is still
running.

It could a bit tricky, though (modifications to the driver source), if you
wanted one CAN bus to be non-RT and one to be RT.


With the RTDM driver, I'm not sure if it uses a Xenomai system call to open
the socket (but I suspect that it may). If that's the case, then you can
open it from either a primary or secondary mode Xenomai thread, but maybe
not a regular Linux thread (i.e. a totally non-Xenomai application or a
thread opened with __real_pthread_create).

Unfortunately I don't have an answer on the Python bindings, but I can see
how that would be attractive since it's a lot easier to get up and running
than having to compile a C program. But since python is interpreted I think
you might have to be very careful if you intend to use it for a real-time
task with some strict deadlines. I suspect that it could mostly be OK
beyond initial setup of your program?
The RT socket CAN stuff in C code looks extremely similar to regular old
socket CAN, so if there exists already a socket CAN binding for python, I
suspect you could re-use it with only small modifications (including the
RTDM headers, making sure you have the right device name when you open your
socket, and replacing read/write calls with send/recv and the appropriate
argument lists).
