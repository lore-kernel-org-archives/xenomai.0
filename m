Date: Mon, 7 Sep 2015 12:08:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150907100846.GA13241@hermes.click-hack.org>
References: <20150831063738.GC9120@hermes.click-hack.org>
 <20150831070849.GD9120@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150831070849.GD9120@hermes.click-hack.org>
Subject: Re: [Xenomai] Mirroring xenomai.org
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On Mon, Aug 31, 2015 at 09:08:49AM +0200, Gilles Chanteperdrix wrote:
> On Mon, Aug 31, 2015 at 08:37:38AM +0200, Gilles Chanteperdrix wrote:
> > Hi,
> > 
> > according to xenomai.org server statistics, some xenomai users are
> > mirroring xenomai.org git repositories. In order to make things
> > easy, grokmirror is now set up on xenomai.org.
> 
> Unfortunately, this broke http/https checkout for ipipe* gits. The
> reason is that the "alternate" file in the ipipe gits contains the
> absolute path to the kernel.org repositories, which does not work
> for http/https checkouts. I will need to spend more time fixing
> this. In the mean time, I revert the ipipe* gits to their former
> contents, without references.

Hi,

Since yesterday, the ipipe gits are now references to the
linux-stable git. I could not find a way to "nest" the references,
have the ipipe git be references to both linux-stable.git and
linux.git.

So, this means that a typical grokmirror configuration, saving the
mirrors in /var/xeno-gits would be:

[xenomai.org]
site = git://git.xenomai.org
manifest = https://git.xenomai.org/manifest.js.gz
toplevel = /var/xeno-gits
mymanifest = /var/xeno-gits/manifest.js.gz
projectslist_symlinks = no
post_update_hook =
purgeprotect = 5
default_owner = Xenomai
log = /var/xeno-gits/grok-pull.log
loglevel = info
pull_threads = 2
include = *
exclude =

If you want to only mirror ipipe.git and say, ipipe-gch.git and want
to benefit from sharing the linux-stable repository, the include
line should be replaced with:

include = /kernel.org/linux-stable.git
	/ipipe.git
	/ipipe-gch.git

Now, if you want to only mirror ipipe.git and do not care to have a
separate linux-stable.git repository, the include line can be
replaced with:

ignore_repo_references = yes
include = /ipipe.git

Also note that another advantage of the grokmirror tools is the
grok-fsck tool, which cleans up the repositories, and spread the
work over time.

If following these changes, something does not work, please report
the problem on this mailing list.

Regards.

-- 
					    Gilles.
https://click-hack.org

