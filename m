Date: Fri, 2 Jan 2015 16:06:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150102150638.GE1492@daedalus>
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de> <54A69D42.2010408@xenomai.org>
 <54A69BFA.7060405@web.de> <54A6A506.3060504@xenomai.org>
 <54A6A387.4010109@web.de> <20150102141625.GD1492@daedalus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150102141625.GD1492@daedalus>
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

On Fri, Jan 02, 2015 at 03:16:25PM +0100, Gilles Chanteperdrix wrote:
> On Fri, Jan 02, 2015 at 02:56:23PM +0100, Jan Kiszka wrote:
> > On 2015-01-02 15:02, Philippe Gerum wrote:
> > > On 01/02/2015 02:24 PM, Jan Kiszka wrote:
> > >> On 2015-01-02 14:29, Philippe Gerum wrote:
> > >>> On 01/02/2015 12:11 PM, Jan Kiszka wrote:
> > >>>> On 2015-01-02 11:58, Philippe Gerum wrote:
> > >>>>> On 01/02/2015 11:28 AM, Jan Kiszka wrote:
> > >>>>>> On 2015-01-01 18:43, xenomai-git-request@xenomai.org wrote:
> > >>>>>>> Module: xenomai-3
> > >>>>>>> Branch: next
> > >>>>>>> Commit: d351f712bc9b03d621b454b55fe3e46a0000294a
> > >>>>>>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=d351f712bc9b03d621b454b55fe3e46a0000294a
> > >>>>>>>
> > >>>>>>> Author: Philippe Gerum <rpm@xenomai.org>
> > >>>>>>> Date:   Thu Jan  1 18:15:36 2015 +0100
> > >>>>>>>
> > >>>>>>> copperplate: add configuration tunable for registry moint point
> > >>>>>>>
> > >>>>>>> --enable-registry[=/registry-mount-point]
> > >>>>>>>
> > >>>>>>> Defaults to /mnt/xenomai.
> > >>>>>>
> > >>>>>> Do we really have to leave this as default? Then at least the debian
> > >>>>>> rules must be fixed to use a FHS-conforming path for distributed packages.
> > >>>>>>
> > >>>>>
> > >>>>> I don't care about which default is picked, really. I would agree with
> > >>>>> both options equally, i.e. using /mnt or /var/run, since /mnt has been a
> > >>>>> sensible and documented root for temporary mount points for ages in the
> > >>>>> *nix world, although I find /var/run a reasonable choice for
> > >>>>> non-persistent mount points as well.
> > >>>>
> > >>>> As I explained (and I wasn't alone with this view), this is not a matter
> > >>>> of taste but standard compliance: FHS requires us - as soon as we
> > >>>> consider Xenomai being part of the platform and not some self-written
> > >>>> admin script - to keep away from /mnt. You would have a hard time
> > >>>> finding a distro package that writes to /mnt without being explicitly
> > >>>> told by the admin.
> > >>>
> > >>> FHS 2.3 required volatile data to go to /var/run, and then Debian and
> > >>> others found out that it might not be the most usable choice, and went
> > >>> for /run+symlink to cope with legacy, until FHS 3.0 validates this
> > >>> arbitrary change eventually.
> > >>>
> > >>> So, I'm ok with FHS, but in that particular case, FHS has been wrong for
> > >>> years it seems. I'd rather discuss about usability then. The kind of
> > >>> issues I'd like to see people discussing instead of going ballistic for
> > >>> a freaking mount point would rather be:
> > >>>
> > >>> /var/run means tmpfs, which implies rw.
> > >>> /mnt means root fs, which might imply ro in some embedded cases.
> > >>
> > >> Thanks for reminding, that was one of my initial points in the
> > >> discussion. It derives from the ideas of the standard about the usage of
> > >> those mount points.
> > >>
> > > 
> > > [...]
> > > 
> > >>> It could be acceptable, or maybe there are arguments against requiring
> > >>> this. Please discuss about usability issues first and foremost.
> > >>>
> > > 
> > > That part of the quote is important too. The fact that it departs from
> > > FHS is not a fundamental issue per se to me. What is important is
> > > whether departing is a problem for users, or transparent, or this
> > > improves usability.
> > 
> > It obviously degraded the default experience:
> >  - unexpected changes to /mnt
> >  - unneeded persistent changes as /mnt is not intended to be used for
> >    temporary system mount points, thus doesn't reside in tmpfs
> 
> Both only for the small fractions of the users who do not routinely create
> directories under /mnt.
> 
> 
> >  - conflicts on r/o file systems that hold /mnt
> 
> This is a non issue: installing Xenomai requires doing a few things
> as administrator, creating /mnt/xenomai would just be one more.
> Using /var/run or /run on an embedded system that does not already
> have it creates the same issue. Really, not a problem.

To explain a bit more completely. We can not assume that xenomai
applications are running as root user. And non root user are not
allowed to create /run/xenomai or /var/run/xenomai (at least not on
debian or slackware). What is more, these directories being
typically non persistent, a script has to be modified somewhere to
add mkdir /var/run/xenomai at every boot. On the other hand, mkdir
/mnt/xenomai has to be done once and only once, in the "make
install" phase for instance, since "make install" is run as root,
except that if /mnt is read-only it will not work. But not many
users are running system where they compile and run things with root
filesystem read-only. Anyway, the two cases are really similar, no
one is advantageous over the other. We are going to see questions on
the mailing list about that, whatever we do. Perhaps adding a small
kernel module to create /proc/xenomai/registry would make things
simpler...

-- 
					    Gilles.

