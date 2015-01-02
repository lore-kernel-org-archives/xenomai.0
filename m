Date: Fri, 2 Jan 2015 16:10:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150102151027.GF1492@daedalus>
References: <mailman.787.1420134217.6101.xenomai-git@xenomai.org>
 <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de> <20150102125133.GA1492@daedalus>
 <20150102150503.GT24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150102150503.GT24110@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@web.de>, Xenomai <xenomai@xenomai.org>

On Fri, Jan 02, 2015 at 10:05:03AM -0500, Lennart Sorensen wrote:
> On Fri, Jan 02, 2015 at 01:51:33PM +0100, Gilles Chanteperdrix wrote:
> > And as I explained, the standard sucks. /mnt on the distro I use
> > contains the following directories:
> > 
> > cdrecorder
> > cdrom
> > dvd
> > floppy
> > hd
> > memory
> > tmp
> > zip                 
> > 
> > and it puts the following text in /mnt/README
> > 
> > The purpose of the /mnt directory is to provide a place for the admin to
> > mount block device temporarily.  Any of the subdirectories of /mnt may be
> > used, or volumes may even be mounted directly on /mnt (which is the
> > traditional way of doing things, though /mnt/tmp is also provided for
> > the purpose of mounting any kind of volume temporarily).
> > 
> > See the /media directory also.
> > 
> > IOW: it leaves the choice to the user. What Philippe does is exactly
> > the same: let the user choose whether he want to use the non
> > standard sotlution that does not suck and that use to be a standard
> > practice in Linux world, or the standard solution that sucks.
> > 
> > I thought we agreed this was a sensible solution.
> 
> So your README file even says the traditional way is to mount on top
> of /mnt, which again means /mnt/xenomai stops working if you do what it
> says is traditional in the README on that system.  Good reason not to
> rely on anything in /mnt

You deliberately misread the README. It says that you may mount
under whatever directory under /mnt makes sense for you OR that if
you want, you can use /mnt. In the first case, using /mnt/xenomai
will not break anything, in the second case yes, it will break
things. But as I already said, I believe not many users are using
the second solution because it inconvenient: if you do that, you
have only one mount point for temporary thing, so the standard
decided for you that you only mount one temporary thing at a time. I
do not know about you, but I sometimes need to mount more than one
thing temporarily, which is why I have plenty directories under
/mnt.

-- 
					    Gilles.

