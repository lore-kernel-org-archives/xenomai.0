From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17230.48169.133915.162045@domain.hid>
Date: Thu, 13 Oct 2005 21:57:29 +0200
Subject: Re: [Xenomai-core] Future of fusion
In-Reply-To: <Pine.LNX.4.64.0510131131490.5110@domain.hid>
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<434E19AD.4030500@domain.hid>
	<Pine.LNX.4.64.0510131033300.5110@domain.hid>
	<17230.8141.436906.810841@domain.hid>
	<Pine.LNX.4.64.0510131049420.5110@domain.hid>
	<434E2510.9060502@domain.hid>
	<Pine.LNX.4.64.0510131131490.5110@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
Cc: xenomai@xenomai.org

Herman Bruyninckx wrote:
 > The question is: how is the following problem solved? Where the problem is
 > as follows: using Posix threads in realtime requires another library than
 > the standard NPTL library that Linux uses (at least, I think you require
 > another library), but how do you make sure to link to the correct library?

First, Xenomai user-space POSIX library uses the same data structure
definitionss as Linux threading libraries (whether linuxthread or
NPTL). This way, including Xenomai specific headers is not mandatory for
using its POSIX library. Another advantage: Xenomai implementation of
POSIX functions may decide to delegate control to the real ones without
having to touch the user structures.

Of course, if you do not include Xenomai headers, you will not get
declarations of some functions specific to Xenomai, some of these
functions are non portable (such as pthread_make_periodic_np and
pthread_wait_np, which are still the easiest solution to get periodic
tasks in primary mode), other are not yet in all distributions, such as
the message queues API.

Second, Xenomai build a user-space library made for use with the --wrap
option of the GNU linker. Xenomai implementation of the pthread_create
function is called __wrap_pthread_create, and when linking with Xenomai
library, ld replace any call to pthread_create in the user code by
__wrap_pthread_create, so that at run time, Xenomai implementation of
this function gets called.

This solution avoids the unexpected segmentation faults. Users mistake
result either in linker errors (because of the use of a function of
Xenomai which does not exist in Linux threading library without the
--wrap parameters, or conversely because the --wrap option was passed
while trying to link with one of Linux threading libraries). In the
worst case, a user program may run as standard Linux POSIX threads
application if he forgot the --wrap options, but this is easy to see,
since /proc/xenomai/sched shows no real-time thread. Do not get me
wrong, passing the correct arguments to the compiler is as easy as with
any other skin; it is just a matter of calling xeno-config
--posix-cflags andd xeno-config --posix-ldflags. Some examples are
included in skins/posix/demos.

The current implementaion of Xenomai user-space POSIX skin also allow
Linux POSIX threads libraries functions to remain accessible aside
Xenomai calls; for example, you may still create Linux POSIX threads by
calling __real_pthread_create. Actually, now that I think about it,
being able to access easily Linux calls aside Xenomai ones was a
requirement among the most important in our view.


  > Or is NPTL realtime safe? 

the "accuracy" example in skins/posix/demos should help you get an
opinion on that point.

-- 


					    Gilles Chanteperdrix.

