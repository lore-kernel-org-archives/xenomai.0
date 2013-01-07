Message-ID: <50EB4FAD.2000804@xenomai.org>
Date: Mon, 07 Jan 2013 23:43:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50EA9B9A.6000804@zultron.com>
In-Reply-To: <50EA9B9A.6000804@zultron.com>
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

On 01/07/2013 10:55 AM, John Morris wrote:

> Hi list,


Hi,

> 
> I encountered a couple of problems building packages for 2.6.2 when
> following the instructions to build from git in this link:
> 
> http://www.xenomai.org/index.php/Building_Debian_packages
> 
> First, the autoconf-generated 'configure' script is checked into git.
> When git-buildpackage cleans up, it removes the configure script, and
> then bombs out when it finds uncommitted changes (i.e. the configure
> script removed) in the git tree.  I hacked around it by committing a
> 'git rm configure' in my own tree, but don't have a more sophisticated
> fix (is the configure script committed in git for a reason?).


The configure script is commited in the repository in order to allow
users to compile the xenomai package without the need to install the
correct version of the autotools.

> 
> Second, the kernel patch copying code in debian/rules is out of date.
> It expects to find "adeos-ipipe-*.patch" in the top-level directory.
> Here's a patch to copy the ipipe-core patch files from the
> ksrc/arch/<arch>/patches/ directory instead.
> 
> One more problem when building the 3.2.21 kernel (I'm building 3.5.3
> now, but since I have the fix, may as well report it).  The ipipe-core
> patch introduces a syntax error in arch/x86/kernel/apic/io_apic.c,
> breaking compile.  Here's a second patch to fix that.


These issues have been fixed in xenomai git, if you are interested by
xenomai packages (currently only on the amd64 architectures) see:
http://www.xenomai.org/pipermail/xenomai/2013-January/027252.html

Regards.

-- 
                                                                Gilles.

