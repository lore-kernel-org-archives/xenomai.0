Message-ID: <50EC80AD.3090301@xenomai.org>
Date: Tue, 08 Jan 2013 21:25:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50EA9B9A.6000804@zultron.com> <50EB4FAD.2000804@xenomai.org>
	<50EBDAC8.8010006@zultron.com>
In-Reply-To: <50EBDAC8.8010006@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian package build problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

On 01/08/2013 09:37 AM, John Morris wrote:

> Hi Gilles,
> On 01/07/2013 04:43 PM, Gilles Chanteperdrix wrote:
>> On 01/07/2013 10:55 AM, John Morris wrote:
>>> I encountered a couple of problems building packages for 2.6.2 when
>>> following the instructions to build from git in this link:
>>>
>>> http://www.xenomai.org/index.php/Building_Debian_packages
>>>
>>> First, the autoconf-generated 'configure' script is checked into git.
>>> When git-buildpackage cleans up, it removes the configure script, and
>>> then bombs out when it finds uncommitted changes (i.e. the configure
>>> script removed) in the git tree.  I hacked around it by committing a
>>> 'git rm configure' in my own tree, but don't have a more sophisticated
>>> fix (is the configure script committed in git for a reason?).
>>
>> The configure script is commited in the repository in order to allow
>> users to compile the xenomai package without the need to install the
>> correct version of the autotools.
> 
> I suspected that was the reason.  To work around the problem, one may
> add '--git-ignore-new' to the git-buildpackage command line.
> 
>>> Second, the kernel patch copying code in debian/rules is out of date.
>>> It expects to find "adeos-ipipe-*.patch" in the top-level directory.
>>> Here's a patch to copy the ipipe-core patch files from the
>>> ksrc/arch/<arch>/patches/ directory instead.
>>>
>>> One more problem when building the 3.2.21 kernel (I'm building 3.5.3
>>> now, but since I have the fix, may as well report it).  The ipipe-core
>>> patch introduces a syntax error in arch/x86/kernel/apic/io_apic.c,
>>> breaking compile.  Here's a second patch to fix that.
>>
>> These issues have been fixed in xenomai git, 
> 
> The master branch does indeed work, great!  I needed another small
> addition to the git-buildpackage command line to fix the tarball
> creation breaking:  '--git-upstream-branch=master
> --git-upstream-tree=branch'.
> 
>> if you are interested by
>> xenomai packages (currently only on the amd64 architectures) see:
>> http://www.xenomai.org/pipermail/xenomai/2013-January/027252.html
> 
> Yes, I am interested in xenomai packages, thank you!  I'm working on the
> project to add new RT systems to LinuxCNC (you might know Michael
> Haberler, who wrote the Xenomai ports).  Now that we have a version
> ready for testing, we find that the community is having trouble building
> working kernels.  They all run Debian-like distros, the only ones
> supported by LinuxCNC, so despite having never used Debian/Ubuntu, I
> have been busy writing instructions for creating Ubuntu packages.  Next
> step is to create a package repo to make it even easier.
> 
> The most difficult part has been to create a kernel config that works on
> everybody's hardware.  My approach to solving that problem is to create
> a well-documented, minimal set of configuration changes that may be
> applied to stock distro kernels.


This minimal set of change is documented, for xenomai, on the website.
If you find you need other changes, they may be bugs, and could need fixing.

  My results have been tested on EL6,
> x86_64 (not Deb or 32-bit yet), and the config files can be seen here:
> 
> https://github.com/zultron/kernel-tools/tree/master/configs
> 
> The community mostly seems to run 32-bit machines, so your repo doesn't
> satisfy all their needs yet.  :) 


I am going to compile the i686 packages, I guess we need to provide two
packages, one for UP, one for SMP.


> There will soon be a BeagleBone port,
> too, an arch I haven't begun to tackle yet.
> 
> It seems terrible to duplicate this effort, so let me know if there's
> anything I can do to help.  I can also supply packages for EL6 (my own
> most familiar distro).


we realized recently that:
- we need to test whether the in-tree debian packaging works for every
release, otherwise we make broken releases, the only way to do that is
to well, generate the debian packages and install them to see whether
they work;
- many newbies questions are about compiling kernels, mostly for the x86
architecture, so, if we provide the packaged kernels, we will avoid
these questions, and people will not have to master kernel compilation
and installation to be able to use xenomai. This did not look so hard a
few days ago, as learning to compile your own kernel was part of
learning to use Linux, but these days, with the one-fits-all distros
kernel, we find that people no longer know how to compile a kernel
(however easy it seems).

So, we tried and improved the I-pipe patches so that a single or a pair
of kernels (SMP and UP) can be generated for each architecture.

I started setting up a repository on the xenomai server, but obviously,
can not do it for all distributions, so, any help is welcome. What I can
propose is to set-up an inoticoming repository, give you access to an
incoming repository through scp (you whould have to send me your ssh
public key for that). Then, before a release, we would work to provide
the corresponding debian and ubuntu packages. As for the fedora
packages, I do not know the equivalent of reprepro and inoticoming.

Regards.

-- 
                                                                Gilles.

