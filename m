Message-ID: <440F5F23.7000703@domain.hid>
Date: Wed, 08 Mar 2006 16:48:03 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai vs. RTLinux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Xenomai developers and users,

Our company is looking at the possibility of porting our hardware-in-the-loop (HWIL) simulations from RTLinuxFree to a new real-time operating system.  We are currently considering Xenomai and RTLinuxPro as possible options.  I am personally biased towards free software, but our customers do not necessarily share this bias.  I am attempting to put together a presentation comparing the advantages and disadvantages of the two systems  as they would be used in our HWIL simulations.  Any comments you have would be appreciated.

We are currently using RTLinuxFree-3.2-pre3 running on Fedora Core 1 (2.4.22 linux kernel) for our in-house HWIL simulations on rack-mounted x86 PC hardware.  We have been satisfied with the functionality of RTLinuxFree over the past few years, although we have been disappointed by the lack of maintenance and development that has occurred since the primary developers focused their efforts on developing RTLinuxPro.  Because there is no RTLinuxFree release that supports the 2.6 kernel, even more than two years after it's release, it looks like we will be forced to abandon this platform, or be stuck with the almost unsupported Fedora Core 1 for the foreseeable future.

Over the past week or so, I have installed Xenomai (2.1-rc3 and 2.1-rc4) and written a couple of test applications.  My experience was very good.  I will send an email with some feedback shortly.

I wrote some simple test programs to compare the scheduling jitter and interrupt latency for RTLinuxFree, Xenomai-kernel-space, and Xenomai-user-space applications.  My tests are not rigorous by any means, but it seems that the worst-case measurements are pretty similar.  Xenomai *may* be slightly better from the limited data I have taken.  Does anyone care to share their own observations?

The worst-case scheduling latency for the xenomai user-space application was only a few microseconds worse than the kernel-space version.  Is this what you would expect?

I did not do a very thorough test with my interrupt handler, but the results seemed similar to what I described above for the scheduler.  Is there a big penalty in terms of worst-case latency for user-space interrupt handlers that I may not have seen?  I'm just looking for any major problems that I might encounter if we port our real-time applications to user-space.

Is RTLinuxPro's PSDD (user-space) development environment similar to xenomai's user-space real-time threads?  Any known advantages/disadvantages to either system?

We currently use C and FORTRAN in our RTLinuxFree modules, and would like to be able to add C++ and FORTRAN as well.  Are there any problems you see with using these languages in xenomai user-space real-time programs?

Is there planned support for native AMD x86_64 support?  We have several of these machines on our desktops and would like to upgrade our HWIL machines as well.

We are also concerned about "future-proofing" as someone else put it the other day.  I hope that xenomai will not suffer the fate of RTLinuxFree in a few years.  Of course, I understand there are no guarantees.  Do you see any advantages to xenomai over RTLinuxPro in this respect?

Another issue is technical support and documentation.  The xenomai documentation seems good enough to me, although it sounds like RTLinuxPro is quite a bit more substantial.  It also looks like the developers on this list are very responsive and helpful, but I don't know how that compares to what we would get from FSMLabs.  Any input on these topics?

It appears that xenomai is released under the LGPL and can be used with proprietary applications.  Although our simulations are just for internal use, and I would always advocate releasing free software, I was wondering if xenomai is subject to the RTLinux patent, or if it uses a different process.

My first impression of xenomai is very positive.  I like the clean API, and the user-space real-time would make life *much* nicer for me.  I'm glad there is a such nice piece of free software available for real-time programming under GNU/Linux.  Thanks!

Thank you for taking the time to read these questions and comments.  Any comments or testimonies regarding xenomai or RTLinuxPro would be appreciated.

Thanks again,

Jeff Webb

