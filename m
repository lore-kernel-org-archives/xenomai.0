Date: Fri, 2 Jan 2015 13:51:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150102125133.GA1492@daedalus>
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54A67CD1.10103@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum: copperplate: add
 configuration tunable for registry moint point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Jan 02, 2015 at 12:11:13PM +0100, Jan Kiszka wrote:
> On 2015-01-02 11:58, Philippe Gerum wrote:
> > On 01/02/2015 11:28 AM, Jan Kiszka wrote:
> >> On 2015-01-01 18:43, xenomai-git-request@xenomai.org wrote:
> >>> Module: xenomai-3
> >>> Branch: next
> >>> Commit: d351f712bc9b03d621b454b55fe3e46a0000294a
> >>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=d351f712bc9b03d621b454b55fe3e46a0000294a
> >>>
> >>> Author: Philippe Gerum <rpm@xenomai.org>
> >>> Date:   Thu Jan  1 18:15:36 2015 +0100
> >>>
> >>> copperplate: add configuration tunable for registry moint point
> >>>
> >>> --enable-registry[=/registry-mount-point]
> >>>
> >>> Defaults to /mnt/xenomai.
> >>
> >> Do we really have to leave this as default? Then at least the debian
> >> rules must be fixed to use a FHS-conforming path for distributed packages.
> >>
> > 
> > I don't care about which default is picked, really. I would agree with
> > both options equally, i.e. using /mnt or /var/run, since /mnt has been a
> > sensible and documented root for temporary mount points for ages in the
> > *nix world, although I find /var/run a reasonable choice for
> > non-persistent mount points as well.
> 
> As I explained (and I wasn't alone with this view), this is not a matter
> of taste but standard compliance: FHS requires us - as soon as we
> consider Xenomai being part of the platform and not some self-written
> admin script - to keep away from /mnt. You would have a hard time
> finding a distro package that writes to /mnt without being explicitly
> told by the admin.

And as I explained, the standard sucks. /mnt on the distro I use
contains the following directories:

cdrecorder
cdrom
dvd
floppy
hd
memory
tmp
zip                 

and it puts the following text in /mnt/README

The purpose of the /mnt directory is to provide a place for the admin to
mount block device temporarily.  Any of the subdirectories of /mnt may be
used, or volumes may even be mounted directly on /mnt (which is the
traditional way of doing things, though /mnt/tmp is also provided for
the purpose of mounting any kind of volume temporarily).

See the /media directory also.

IOW: it leaves the choice to the user. What Philippe does is exactly
the same: let the user choose whether he want to use the non
standard sotlution that does not suck and that use to be a standard
practice in Linux world, or the standard solution that sucks.

I thought we agreed this was a sensible solution.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 173 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150102/395319e1/attachment.sig>
