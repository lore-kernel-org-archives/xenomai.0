Date: Mon, 31 Aug 2015 08:37:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150831063738.GC9120@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Mirroring xenomai.org
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

according to xenomai.org server statistics, some xenomai users are
mirroring xenomai.org git repositories. In order to make things
easy, grokmirror is now set up on xenomai.org. The manifest is
available at:
http://git.xenomai.org/manifest.js.gz
or
https://git.xenomai.org/manifest.js.gz

You can read more about grokmirror here:
https://www.kernel.org/mirroring-kernelorg-repositories.html
and here:
https://github.com/mricon/grokmirror

But, to summarize, writing to repos-xenomai.conf:
[xenomai.org]
site = git://git.xenomai.org
manifest = https://git.xenomai.org/manifest.js.gz
toplevel = /tmp/xeno-gits
mymanifest = /tmp/xeno-gits/manifest.js.gz
projectslist_symlinks = no
post_update_hook =
purgeprotect = 5
default_owner = Xenomai
log = /tmp/xeno-gits/grok-pull.log
loglevel = info
pull_threads = 2
include = *
exclude =

And running grok-pull -c /path/to/repos-xenomai.conf in a crontab
should be enough to set a mirror up in /tmp/xeno-gits. When nothing
changed, the date of the manifest file will be enough to avoid
downloading anything, which makes the process very light.

You can tweak the include line to only mirror some repositories.
Note however that if you want to mirror one of the ipipe gits, since
the I-pipe git now makes reference to the linux and linux stable git,
you will also have to mirror the linux and linux-stable git (which are
mirrored by xenomai). So, for instance, to mirror the official ipipe
git only, you would write:

include = /kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	/kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
	/ipipe.git

instead of include = *

Regards.

-- 
					    Gilles.
https://click-hack.org

