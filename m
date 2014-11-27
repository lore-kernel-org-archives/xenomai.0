Date: Fri, 28 Nov 2014 00:15:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141127231527.GC24076@hermes>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com>
 <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54778CF6.6000909@siemens.com>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Nov 27, 2014 at 09:43:34PM +0100, Jan Kiszka wrote:
> On 2014-11-27 21:34, Gilles Chanteperdrix wrote:
> > On Thu, Nov 27, 2014 at 02:14:38PM -0500, Lennart Sorensen wrote:
> >> On Thu, Nov 27, 2014 at 07:51:27PM +0100, Jan Kiszka wrote:
> >>> On 2014-11-27 19:18, Gilles Chanteperdrix wrote:
> >>>> According to the filesystem hierarchy standard, /mnt is the standard
> >>>> place for "temporarily mounted filesystems".
> >>>>
> >>>> http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
> >>>
> >>> Right, another reason to NOT mess around with it: if something was
> >>> temporarily mounted there, we will create the mountpoint inside that
> >>> filesystem with unforeseeable side effects.
> >>
> >> I always read that as "temporarily mounted there by the admin or some
> >> other human".  Certainly not automatic mounts by software.  There is a
> >> reason /media and such exists on many distributins.
> > 
> > I would not venture an "always", autofs for instance, used to mount
> > things under /mnt. and /media has not always existed either, we used
> > /mnt/cdrom.
> 
> FHS on /mnt purpose:
> 
> "This directory is provided so that the system administrator may
> temporarily mount a filesystem as needed. The content of this directory
> is a local issue and should not affect the manner in which any program
> is run."
> 
> I think this makes it crystal clear that Xenomai is not supposed to
> touch it.

Just to add another argument. I just asked a friend who is a
professional sysadmin. He creates directory under /mnt and mount
things under these directories. So, I am not sure the standard is
even applied by the people who should use it.

If you read on the last site I sent, under the /media article: 

Amid much controversy and consternation on the part of system and
network administrators a directory containing mount points for
removable media has now been created. Funnily enough, it has been
named /media.

Are you sure, 100% sure, that every Xenomai user expects to be able
to use /mnt as a mount point? Or that they will create directories
under /mnt like everybody has been doing since Linux exists?

-- 
					    Gilles.

