Message-ID: <434E622D.801@domain.hid>
Date: Thu, 13 Oct 2005 15:33:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Future of fusion
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>	<434E19AD.4030500@domain.hid>
	<200510131146.04013.bdi-emc@domain.hid>
In-Reply-To: <200510131146.04013.bdi-emc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <bdi-emc@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
> Hi Philippe
> 
> On Thursday 13 October 2005 09:24, Philippe Gerum wrote:
> 
>>- Regular automated benchmarking: What is Xenomai currently capable of, how
>>stable is it, do we progress or regress over time and releases, arch by
>>arch?
> 
> 
> Have a couple of x86 development boxes running 24/7 - Could set one up as a 
> compile farm for running automated builds.

That would be great, thanks. Let us know if we could help.

  Also have a PowerPC thin client
> that I would like to utilise, but could really do with some help in setting 
> up the tools for cross-compiling the base system under Debian.

What about DENX's ELDK?

> 
> 
>>- Configuration, building and packaging issues: Could we make this easier?
> 
> 
> Anything that involves patching/compiling kernels is bound to cause trouble 
> for new users. Perhaps some tests for kernel options known to cause trouble 
> (such as APM & REGPARM) that print out large warnings during the config stage 
> might help..
> 

Ok, I have something rather highly ranked on my TODO list (which ends up by 2117 
or so), which is about allowing to build all Xenomai's in-kernel support 
statically in the Linux kernel. The rationale behind that is about making more 
straightforward and efficient embedded setups; straightforward because modules 
add more complexity than they would solve in typical embedded systems, and 
efficient since loading modules in a running kernel doesn't come for free.

To do that, portions of the Xeno build system which are currently 
autoconfiscated should move to the target kernel, so that we would only keep the 
autoconf infrastructure for what it's good at, i.e. building the user-space 
support. The basic idea is that we would then have a kernel extension part 
either buildable statically or as modules using Linux's Kconfig/Kbuild 
infrastructure, and a user-space support package providing the various interface 
libraries, headers, tools and scripts, ala glibc.

The immediate advantages would be:

- The core of the Xenomai support would be statically embeddable in the Linux 
kernel;
- No need for a Kconfig duplication like we have now; most of the options 
currently presented by Xeno's Kconfig sub-system concern the kernel portions, 
and very few actually concern the user-space stuff. We would then get rid of the 
former, and rely on the vanilla Linux's one instead.
- Centralizing Xenomai's kernel-related options with Linux's ones would make 
easier defining sanity checks (e.g. APM stuff and so on), since we could use the 
Kconfig language to enforce them in order to obtain sane configurations "by 
construction" (e.g. CONFIG_XENO disables CONFIG_APM). Currently, Xeno's Kconfig 
is not aware of the kernel settings, so the checks are performed afterwise by 
the configure script instead.
- Removing the module compilation logic from the autoconfiscated Makefiles would 
be a significant simplification of the Xeno build system, and would make it less 
dependent on the kernel build system.
- This build process is still fully automatable.
- LKML people among my co-workers (Hi Stelian!) would start talking to me again, 
since I would stop pretending that autoconf is a sane way of controlling builds 
for kernel-based code. :o>

The way I see a typical build process would then be along these lines:

$ tar jxf xenomai-*
$ mkdir xeno-build && cd xeno-build && ../xenomai-*/configure 
--kernel=/usr/src/linux --some-option-only-for-uspace-stuff --prefix=<install-dir>
....
(the configure script would then prepare the autoconf _and_ make the necessary 
links from the target kernel to the Xenomai source tree to connect the modules 
to the kernel's Kbuild/Kconfig infrastructure.
....
$ cd /usr/src/linux
$ make gconfig
....
The user would configure his kernel, and all the kernel-based Xenomai stuff, as 
if they were standard drivers/extensions
....
$ make <the_kernel>
$ cd xeno-build && make install

And we would be done. Well, in a perfect world, I mean.

> Gilles already has a tarball of the Debian rules I used for packaging fusion. 
> With minor changes, these could be used for a Xenomai package. One 
> possibility is to use the rules and the compile farm to produce "ready to 
> run" kernel/Xenomai Debian packages.
>

I think we should be able to work this out will Gilles before 2.0 is out since 
it's a separate build-related issue.

> 
> Regards, Paul.
> 
> 
> 


-- 

Philippe.

