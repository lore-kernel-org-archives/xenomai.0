Date: Thu, 27 Nov 2014 23:56:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141127225613.GB24076@hermes>
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

Extract from:
http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/mnt.html

This is a generic mount point under which you mount your filesystems
or devices. Mounting is the process by which you make a filesystem
available to the system. After mounting your files will be
accessible under the mount-point. This directory usually contains
mount points or sub-directories where you mount your floppy and your
CD. You can also create additional mount-points here if you wish.
Standard mount points would include /mnt/cdrom and /mnt/floppy.
There is no limitation to creating a mount-point anywhere on your
system but by convention and for sheer practicality do not litter
your file system with mount-points. It should be noted that some
distributions like Debian allocate /floppy and /cdrom as mount
points while Redhat and Mandrake puts them in /mnt/floppy and
/mnt/cdrom respectively.

However, it should be noted that as of FSSTND version 2.3 the
purpose of this directory has changed.


  This directory is provided so that the system administrator may temporarily
  mount a filesystem as needed. The content of this directory is a local issue
  and should not affect the manner in which any program is run.

  This directory must not be used by installation programs: a suitable temporary
  directory not in use by the system must be used instead.
  

So, at the very least, /mnt used to be the generic point used to
mount filesystems, I was not dreaming. And in fact, checking the
wikipedia article, I do not see any other directory in the "new"
standard that can be used as a place where to mount things, to fill
the role that /mnt used to have.

Unfortunately, I can not access:
http://www.pathname.com/fhs/
http://www.pathname.com/fhs/pub/fhs-2.3.html

To check the standard itself (connection times out).

-- 
					    Gilles.

