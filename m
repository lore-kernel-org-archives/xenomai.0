Message-ID: <50EBDAC8.8010006@zultron.com>
Date: Tue, 08 Jan 2013 02:37:28 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50EA9B9A.6000804@zultron.com> <50EB4FAD.2000804@xenomai.org>
In-Reply-To: <50EB4FAD.2000804@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,
On 01/07/2013 04:43 PM, Gilles Chanteperdrix wrote:
> On 01/07/2013 10:55 AM, John Morris wrote:
>> I encountered a couple of problems building packages for 2.6.2 when
>> following the instructions to build from git in this link:
>>
>> http://www.xenomai.org/index.php/Building_Debian_packages
>>
>> First, the autoconf-generated 'configure' script is checked into git.
>> When git-buildpackage cleans up, it removes the configure script, and
>> then bombs out when it finds uncommitted changes (i.e. the configure
>> script removed) in the git tree.  I hacked around it by committing a
>> 'git rm configure' in my own tree, but don't have a more sophisticated
>> fix (is the configure script committed in git for a reason?).
> 
> The configure script is commited in the repository in order to allow
> users to compile the xenomai package without the need to install the
> correct version of the autotools.

I suspected that was the reason.  To work around the problem, one may
add '--git-ignore-new' to the git-buildpackage command line.

>> Second, the kernel patch copying code in debian/rules is out of date.
>> It expects to find "adeos-ipipe-*.patch" in the top-level directory.
>> Here's a patch to copy the ipipe-core patch files from the
>> ksrc/arch/<arch>/patches/ directory instead.
>>
>> One more problem when building the 3.2.21 kernel (I'm building 3.5.3
>> now, but since I have the fix, may as well report it).  The ipipe-core
>> patch introduces a syntax error in arch/x86/kernel/apic/io_apic.c,
>> breaking compile.  Here's a second patch to fix that.
> 
> These issues have been fixed in xenomai git, 

The master branch does indeed work, great!  I needed another small
addition to the git-buildpackage command line to fix the tarball
creation breaking:  '--git-upstream-branch=master
--git-upstream-tree=branch'.

> if you are interested by
> xenomai packages (currently only on the amd64 architectures) see:
> http://www.xenomai.org/pipermail/xenomai/2013-January/027252.html

Yes, I am interested in xenomai packages, thank you!  I'm working on the
project to add new RT systems to LinuxCNC (you might know Michael
Haberler, who wrote the Xenomai ports).  Now that we have a version
ready for testing, we find that the community is having trouble building
working kernels.  They all run Debian-like distros, the only ones
supported by LinuxCNC, so despite having never used Debian/Ubuntu, I
have been busy writing instructions for creating Ubuntu packages.  Next
step is to create a package repo to make it even easier.

The most difficult part has been to create a kernel config that works on
everybody's hardware.  My approach to solving that problem is to create
a well-documented, minimal set of configuration changes that may be
applied to stock distro kernels.  My results have been tested on EL6,
x86_64 (not Deb or 32-bit yet), and the config files can be seen here:

https://github.com/zultron/kernel-tools/tree/master/configs

The community mostly seems to run 32-bit machines, so your repo doesn't
satisfy all their needs yet.  :)  There will soon be a BeagleBone port,
too, an arch I haven't begun to tackle yet.

It seems terrible to duplicate this effort, so let me know if there's
anything I can do to help.  I can also supply packages for EL6 (my own
most familiar distro).

	John

