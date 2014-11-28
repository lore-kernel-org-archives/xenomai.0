From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 28 Nov 2014 11:09:46 -0500
Message-ID: <20141128160946.GQ24110@csclub.uwaterloo.ca>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
 <20141127231527.GC24076@hermes> <5478430B.9030602@siemens.com>
 <20141128095038.GA3832@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141128095038.GA3832@hermes>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Fri, Nov 28, 2014 at 10:50:38AM +0100, Gilles Chanteperdrix wrote:
> This is ridiculous. Because the standard changed, and one
> distribution, Debian, decided to follow the new standard, which
> seems to be not widely accepted, and even controversial, you want to
> impose what Debian does to everybody. The distribution I use has
> mount points under /mnt. So, why following Debian and not the
> distribution I use, and what sysadmin have been doing for ages?

Feel free to make xenomai mandate creating some new mountpoint somewhere
else for its use.

> You want the mount point to be somewhere else? Fine, put a symbolic
> link.
> 
> mkdir /run/xenomai
> ln -s /run/xenomai /mnt/xenomai

And when I do mount /dev/sdf1 /mnt, what will xenomai think?  It sure
won't like it.

Do NOT put xenomai stuff in /mnt.  If you do, some of us will have to
maintain permanent patches to fix xenomai and I hate doing that.

-- 
Len Sorensen

