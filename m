Message-ID: <434FD878.4090908@domain.hid>
Date: Fri, 14 Oct 2005 18:10:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Partial roadmap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org


This is a partial roadmap for the project, composed of the currently
undergoing efforts, and other developments which are already planned
to start before Q2 2006. This roadmap will likely be complemented by
other tasks over time, this is just a somewhat sketchy vision of the
next major steps for which we do have an immediate plan and the
resources to achieve them.

Issues related to the usual debugging and extension of existing
features or skins are not covered here, Dmitry, Gilles, Jan and the
Uni-Hannover crew are usually taking care of these depending on the
code in question, with the help from other contributors; let's just
consider those issues as implicit, usual business for now. In any
case, the Xenomai-core list is open for discussing the matter and
filling the gaps in the roadmap.

o Web site.

	- Bruno is working on this. His basic idea of the contents is
	about being clear, simple and informational. Crafting a
	useful and lively site is something of a daunting and tireless
	task, so if you feel helping, just drop him a mail.
	ETA: October 20 (initial version).

o Xenomai 2.0 release

	ETA: October 22.

	It's a bit early to define a timeframe for 2.1, we first need
	to wait for the feedback we get with 2.0. Between both
	releases, updates (2.0.1 and so on) will be made on a regular
	basis.

o Automated benchmarking.

	- We are still considering the best way to do that; actually,
	my take is that we would just need to bootstrap the thing and
	flesh it out over time, writing one or two significant
	benchmark tests to start with, choosing a tool to plot the
	collected data and push the results to some web page for
	public consumption on a regular basis, but so far, we did not
	manage to spark this. It's still in the short-term plan,
	though, because we currently have neither metrics nor data to
	check for basics, and we deeply need both of them now.
	ETA: Q4 2005.

o Build system revamping.

	- In order to allow binding the Xenomai core statically
	to the Linux kernel while keeping the ability to have it as
	loadable modules, we would need to refactor a number of
	things in the existing build system. We are going to do
	exactely that, which should make the use of Xenomai in
	embedded setups more straightforward and efficient.
	ETA: Q4 2005.

	- Heikki has a plan to merge the ppc32 and ppc64 trees so that
	we would track the same refactoring effort than the PPC kernel
	folks are undertaking.
	ETA: unspecified.

o Architecture ports.

	- Analog Devices (http://www.analog.com/) have just offered
	the project two Blackfin boards (bf533 and bf537) running
	uClinux, so that we can first port Adeos over this
	architecture, then the Xenomai core of course.
	ETA: Adeos port, Q4 2005. Xenomai port, Q1 2006.

	- An ARM port is finally underway (yes, really, for sure, no
	kidding, I swear it!). For now, what we have is an almost
	working Adeos/I-pipe patch, on an Integrator CP board running
	an ARM1136 core. Stelian Pop will tell you more as the work
	progresses.
	ETA: Q1 2006.

o Kernel ports.

	- We are going to backport Xenomai over 2.4, initially
	targeting the PPC architecture. I do believe that Xenomai
	will progress faster by confronting itself to low-end
	hardware, which implies that we should also support the kernel
	architecture which is running most of such hardware, and will
	likely keep on doing so for a long time. For this task, we
	will make good use of the boards the Denx's people will give
	us access to. This task depends on the build system revamping
	to be achieved.
	ETA: Q1 2006.

o Scalability.

	- Gilles is going to work on improving the scalability of the
	timer management code, so that a large number of outstanding
	timers would be more efficiently supported. This is
	particularly important when it comes to port telecom-oriented
	applications from traditional RTOS to Xenomai: those
	applications could just create an insane number of concurrent
	timers the way they are usually implemented.
	ETA: Q1 2006.

-- 

Philippe.

