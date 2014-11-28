From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 28 Nov 2014 11:07:22 -0500
Message-ID: <20141128160722.GP24110@csclub.uwaterloo.ca>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
 <20141127231527.GC24076@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141127231527.GC24076@hermes>
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

On Fri, Nov 28, 2014 at 12:15:27AM +0100, Gilles Chanteperdrix wrote:
> Just to add another argument. I just asked a friend who is a
> professional sysadmin. He creates directory under /mnt and mount
> things under these directories. So, I am not sure the standard is
> even applied by the people who should use it.

Well being the admin, the admin can mount whatever they want in there.
That agrees with the standard just fine.

> If you read on the last site I sent, under the /media article: 
> 
> Amid much controversy and consternation on the part of system and
> network administrators a directory containing mount points for
> removable media has now been created. Funnily enough, it has been
> named /media.

The /media is generally used by auto mounters for removable media.

> Are you sure, 100% sure, that every Xenomai user expects to be able
> to use /mnt as a mount point? Or that they will create directories
> under /mnt like everybody has been doing since Linux exists?

I do use /mnt and I do NOT create directories in it.  I know people that
do create directories.  The admin can do whatever they want in there.

-- 
Len Sorensen

