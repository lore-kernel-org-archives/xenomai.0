Date: Fri, 2 Jan 2015 14:41:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150102134146.GC1492@daedalus>
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de> <20150102125133.GA1492@daedalus>
 <54A6977F.6050607@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54A6977F.6050607@web.de>
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

On Fri, Jan 02, 2015 at 02:05:03PM +0100, Jan Kiszka wrote:
> On 2015-01-02 13:51, Gilles Chanteperdrix wrote:
> > On Fri, Jan 02, 2015 at 12:11:13PM +0100, Jan Kiszka wrote:
> >> On 2015-01-02 11:58, Philippe Gerum wrote:
> >>> On 01/02/2015 11:28 AM, Jan Kiszka wrote:
> >>>> On 2015-01-01 18:43, xenomai-git-request@xenomai.org wrote:
> >>>>> Module: xenomai-3
> >>>>> Branch: next
> >>>>> Commit: d351f712bc9b03d621b454b55fe3e46a0000294a
> >>>>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=d351f712bc9b03d621b454b55fe3e46a0000294a
> >>>>>
> >>>>> Author: Philippe Gerum <rpm@xenomai.org>
> >>>>> Date:   Thu Jan  1 18:15:36 2015 +0100
> >>>>>
> >>>>> copperplate: add configuration tunable for registry moint point
> >>>>>
> >>>>> --enable-registry[=/registry-mount-point]
> >>>>>
> >>>>> Defaults to /mnt/xenomai.
> >>>>
> >>>> Do we really have to leave this as default? Then at least the debian
> >>>> rules must be fixed to use a FHS-conforming path for distributed packages.
> >>>>
> >>>
> >>> I don't care about which default is picked, really. I would agree with
> >>> both options equally, i.e. using /mnt or /var/run, since /mnt has been a
> >>> sensible and documented root for temporary mount points for ages in the
> >>> *nix world, although I find /var/run a reasonable choice for
> >>> non-persistent mount points as well.
> >>
> >> As I explained (and I wasn't alone with this view), this is not a matter
> >> of taste but standard compliance: FHS requires us - as soon as we
> >> consider Xenomai being part of the platform and not some self-written
> >> admin script - to keep away from /mnt. You would have a hard time
> >> finding a distro package that writes to /mnt without being explicitly
> >> told by the admin.
> > 
> > And as I explained, the standard sucks. /mnt on the distro I use
> 
> Even if it sucked, it remains the standard that most distros apply.
> 
> > contains the following directories:
> 
> This is apparently an exception. Debian, Ubuntu, Suse/SLES, Fedora/RHEL,
> Gentoo - they all handle this conformingly and leave /mnt empty when
> installing things. At least today, I cannot comment on the history of
> all of them: Suse does as long as I us it (almost 20 years), Debian at
> least for the past 10 years. This is my concern.

Putting directories under /mnt does not prevent users from using
/mnt as a mount point. The distribution I use is Slackware, the
oldest Linux distribution still maintained.

Anyway, as I also already said, most people using Xenomai build it
from sources, and it is even probable that they do not use a
mainstream distribution, they rather use distributions that build
everything from sources, such as yocto or buildroot if they
integrate xenomai into a distribution at all.

And finally, as you already said, changing distribution scripts to
pass an FHS compliant directory, which could even be /run for Debian
instead of /var/run is not really complicated and will not break
anything. Keeping /mnt/xenomai as the default will avoid uselessly
surprising people which have been using Xenomai 3.x since the
beginning, and will keep happy people which find that using
directories under /mnt as mount points is fine. And as I also
already said, a lot of people are mounting their disks under
directories under /mnt, including people who administer Linux
systems for a living, and in fact, everything is made, including in
Debian, so that you can use /mnt the way you please, so, even using
/mnt/xenomai under Debian, would not break anything in Debian, it
would only be a problem for the stubborn people who want to use /mnt
as a mount point, but these people, which are the exception, can use
the configure option to pass /run as a mount point.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 173 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150102/dae0ef5b/attachment.sig>
