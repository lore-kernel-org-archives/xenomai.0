Message-ID: <434996C1.5020004@domain.hid>
Date: Mon, 10 Oct 2005 00:16:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Welcome home
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hi,


Welcome home. Before I'm giving you an update of the things undergoing, and 
since JimC jumped the gun on this list, I'd like to thank all the people who 
wished me an happy retir^H^H^H^H^Hbirthday recently. With such a huge number of 
candles on my birthday cake, I'm pretty sure that each and every space tourist 
wandering in the ISS henceforth knows where I'm living, just by looking down to 
the Earth through the porthole!

Anyway, here is a short update:

- The former fusion code base has been reworked in order to switch back to the 
Xenomai naming scheme, and the result is now available as a SVN tree on GNA [1]. 
Additional features and fixes have been added very recently to this tree, like a 
NMI watchdog for chasing unexpected latencies using a brute force approach on 
x86, or udev support for the pseudo-devices (message pipes and heap). Glitches 
may still exist here and there, but AFAICT reading this list, things get fixed 
gradually.

- A new Xenomai.org website is in preparation. Bruno handles this, and we should 
be able to switch to it in a week or so. For the time being, we are aiming at 
simple and most informative contents given the short time frame and the time 
Bruno can devote to this task. If you have specific wishes regarding this site 
for the future, please post them to this list. For the time being Xenomai.org 
simply points at the project's workspace on GNA.

- Two mailing lists have been created: xenomai-core and xenomai-help. In short, 
the first one is the place where all aspects of the Xenomai project's life 
should be debated (including patches and bug reports). The second one handles 
discussions about configuration, compilation or installation of Xenomai, as well 
as common usage of its features and interfaces. My hope is that at some point in 
time, the latter becomes a coherent and searchable repository that reflects the 
collective experience of Xenomai users.

- The plan is to release Xenomai 2.0 on October 22 at the latest, which leaves 
us a few days to finish testing the new codebase. Since the changes required by 
the transition are "only" syntactical ones, and do not impact the documented 
APIs, things should stabilize reasonably fast. Until then, we clearly are in 
feature freeze from now on. Only obvious bug fixes will be merged.

Aside of this, I'd like that we start a discussion on this list about the 
matters of importance asap. There are a lot, some of them are organisational, 
others are purely technical. My TODO list would not even fit on my hard-drive, 
and since I'm not alone to have an opinion about what we should do next, how and 
when, it's likely that the official list would be even ten times longer than mine.

I propose that we start discussing along the following lines, going into deeper 
detail as needed, but in any case, please remember that we don't have infinite 
resources to do everything at once, and that we need to keep an organisation 
that fits our abilities to manage it, so let's keep it modest and efficient. If 
I missed some important issues, please jump in. After that initial work, we 
should be able to define a sensible roadmap.

- Regular automated benchmarking: What is Xenomai currently capable of, how 
stable is it, do we progress or regress over time and releases, arch by arch?

- Documentation effort, dissemination: I'm a potential new user, do I have some 
unambiguous source of information available to get my feet wet with Xenomai?

- Architecture ports: There is life beyond x86.

- Kernel ports: Is there still room for a 2.4 port?

- Configuration, building and packaging issues: Could we make this easier?

- Linux integration issues: Tools we should interface with, features we should 
make more seamless.

- Scalability: Is Xenomai scalable enough? What's missing?

- Drivers: Now that we have a deeply integrated port of RTDM, what's next? Field 
busses and other industrial gizmos anyone?

- Current interfaces: Are we happy with them?

- New skins: Any new colors for the "chameleon"?

[1] https://gna.org/svn/?group=xenomai

-- 

Philippe.

