Date: Wed, 1 Apr 2015 14:51:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150401125148.GA29467@hermes.click-hack.org>
References: <E1YdHjz-0005Rv-A3@sd-51317.xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1YdHjz-0005Rv-A3@sd-51317.xenomai.org>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : Create gitignore for
	autotools files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Wed, Apr 01, 2015 at 02:27:27PM +0200, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 519962c23a696aba736d8b535c8f1a00382dae8b
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=519962c23a696aba736d8b535c8f1a00382dae8b
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Wed Apr  1 14:25:42 2015 +0200
> 
> Create gitignore for autotools files
> 
> This avoids filling up "git status" with tones of autotools files that
> are now locally maintained.

I am not sure having a gitignore file in the repository is a good
idea, for instance, it will conflict with the gitignore I already
had, because not using the same autotools version as Philippe, my
git status was already filled with tons of autotools files without a
gitignore and before they were removed from the repository. I also
like to add files to gitignore like *~ my editor creates, and so if
my gitignore has local modifications, I will see it in the git
status too.

-- 
					    Gilles.

