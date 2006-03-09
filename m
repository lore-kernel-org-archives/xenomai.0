From: "Christopher Stone" <chris@domain.hid>
Subject: RE: [Xenomai-help] Xenomai vs. RTLinux
Date: Wed, 8 Mar 2006 19:44:31 -0500
Message-ID: <006f01c64312$a28ab730$a10a10ac@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <440F5F23.7000703@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Jeff Webb' <jeff.webb@domain.hid>, xenomai@xenomai.org


> -----Original Message-----
> From: Jeff Webb [mailto:jeff.webb@domain.hid]
> Sent: March 8, 2006 5:48 PM
> To: xenomai@xenomai.org
> Subject: [Xenomai-help] Xenomai vs. RTLinux
> 
> Xenomai developers and users,
> 
> Our company is looking at the possibility of porting our hardware-in-the-
> loop (HWIL) simulations from RTLinuxFree to a new real-time operating
> system.  We are currently considering Xenomai and RTLinuxPro as possible
> options.  I am personally biased towards free software, but our customers
> do not necessarily share this bias.  I am attempting to put together a
> presentation comparing the advantages and disadvantages of the two systems
> as they would be used in our HWIL simulations.  Any comments you have
> would be appreciated.
> 
> We are currently using RTLinuxFree-3.2-pre3 running on Fedora Core 1
> (2.4.22 linux kernel) for our in-house HWIL simulations on rack-mounted
> x86 PC hardware.  We have been satisfied with the functionality of
> RTLinuxFree over the past few years, although we have been disappointed by
> the lack of maintenance and development that has occurred since the
> primary developers focused their efforts on developing RTLinuxPro.
> Because there is no RTLinuxFree release that supports the 2.6 kernel, even
> more than two years after it's release, it looks like we will be forced to
> abandon this platform, or be stuck with the almost unsupported Fedora Core
> 1 for the foreseeable future.
> 
> Over the past week or so, I have installed Xenomai (2.1-rc3 and 2.1-rc4)
> and written a couple of test applications.  My experience was very good.
> I will send an email with some feedback shortly.
> 
> I wrote some simple test programs to compare the scheduling jitter and
> interrupt latency for RTLinuxFree, Xenomai-kernel-space, and Xenomai-user-
> space applications.  My tests are not rigorous by any means, but it seems
> that the worst-case measurements are pretty similar.  Xenomai *may* be
> slightly better from the limited data I have taken.  Does anyone care to
> share their own observations?
> 
> The worst-case scheduling latency for the xenomai user-space application
> was only a few microseconds worse than the kernel-space version.  Is this
> what you would expect?
> 
> I did not do a very thorough test with my interrupt handler, but the
> results seemed similar to what I described above for the scheduler.  Is
> there a big penalty in terms of worst-case latency for user-space
> interrupt handlers that I may not have seen?  I'm just looking for any
> major problems that I might encounter if we port our real-time
> applications to user-space.
> 
> Is RTLinuxPro's PSDD (user-space) development environment similar to
> xenomai's user-space real-time threads?  Any known
> advantages/disadvantages to either system?
> 
> We currently use C and FORTRAN in our RTLinuxFree modules, and would like
> to be able to add C++ and FORTRAN as well.  Are there any problems you see
> with using these languages in xenomai user-space real-time programs?

[Christopher Stone] I am currently working on an Xenomai application (XLM -
http://www.openembedded.biz/content/view/36/27 ) that is completely written
in C++ and have not run in to any difficulties. There is a project called
xeno-- at https://gna.org/projects/xenomm to support C++ although it is not
very complete yet. 

> 
> Is there planned support for native AMD x86_64 support?  We have several
> of these machines on our desktops and would like to upgrade our HWIL
> machines as well.

[Christopher Stone] I definitely plan to add AMD x86_64 support for my XLM
project. I have a dual core AMD X2 chip I want to test XLM on. I don't have
specific dates when it will be available yet.

> 
> We are also concerned about "future-proofing" as someone else put it the
> other day.  I hope that xenomai will not suffer the fate of RTLinuxFree in
> a few years.  Of course, I understand there are no guarantees.  Do you see
> any advantages to xenomai over RTLinuxPro in this respect?

[Christopher Stone] I think the fact that RTLinuxPro is maintained by a
small company, with extremely limited resources when compared to the free
software community, is an almost debilitating disadvantage. How long can
FSMlabs really survive as a company in the face of the mounting competition
from better alternatives like Xenomai?  If FSMlabs goes bankrupt, you would
be left with nothing but uncertainty. With Xenomai, there is nothing to go
bankrupt, so the risk is nil. As long as the source code for Xenomai is
free, you will always be able to find an affordable independent consultant
to maintain it. This is one of the true ironies of the free software
movement. With free software you actually have less uncertainty, because you
are in control of the source code, not some guy who will do who knows what
with your future when his company begins to sink.

Another advantage of Xenomai is that there is no vendor lock-in. With
RTLinuxPro vendor lock in comes in two forms. You can only get your support
and consulting from one place, and the API is specific to RTLinuxPro. 

I guarantee you that the rates that FSMlabs charges for support and
consultancy are much higher than the rates you can get for Xenomai support
and consultancy from any of a growing number of companies. That is because
the Xenomai companies are small, have very little overhead, and have a
distinct advantage in the wages they pay. I would guess that FSMlabs
consultancy rate is twice my rate.

Vendor specific API's are like drugs, once you get hooked on them, it is
difficult to incur the cost of kicking the habit. With Xenomai you can use
any of a number of skins, but, would be wise to consider the POSIX skin. By
using the industry standard POSIX API your code remains portable and more
future proof. 

> 
> Another issue is technical support and documentation.  The xenomai
> documentation seems good enough to me, although it sounds like RTLinuxPro
> is quite a bit more substantial.  It also looks like the developers on
> this list are very responsive and helpful, but I don't know how that
> compares to what we would get from FSMLabs.  Any input on these topics?
> 
> It appears that xenomai is released under the LGPL and can be used with
> proprietary applications.  Although our simulations are just for internal
> use, and I would always advocate releasing free software, I was wondering
> if xenomai is subject to the RTLinux patent, or if it uses a different
> process.

[Christopher Stone] Xenomai uses a different process that was specifically
designed to circumvent the FSMlabs patent. I think that RTAI and Xenomai are
prime examples of how robust and "future proof" the free software community
is. RTAI was stung badly by the FSMlabs patent. However, instead of running
away, the community responded by developing a new process, and the community
is as strong as it ever was.

> 
> My first impression of xenomai is very positive.  I like the clean API,
> and the user-space real-time would make life *much* nicer for me.  I'm
> glad there is a such nice piece of free software available for real-time
> programming under GNU/Linux.  Thanks!
> 
> Thank you for taking the time to read these questions and comments.  Any
> comments or testimonies regarding xenomai or RTLinuxPro would be
> appreciated.
> 
> Thanks again,
> 
> Jeff Webb
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 




