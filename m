From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] debian/rules update
Date: Wed, 14 Mar 2007 16:48:55 +0000
References: <200703121756.08070.paul_c@domain.hid>
	<200703132032.26296.paul_c@domain.hid>
	<1173869781.32259.29.camel@domain.hid>
In-Reply-To: <1173869781.32259.29.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703141648.55033.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Wednesday 14 March 2007 10:56, Philippe Gerum wrote:
> On Tue, 2007-03-13 at 20:32 +0000, Paul wrote:
> > Hi Philippe
> >
> > On Tuesday 13 March 2007 16:30, Philippe Gerum wrote:
> > > > A question for the project admins: Do you have a Release Manager to
> > > > coordinate package releases ?
> > >
> > > I'm currently coordinating the Xenomai releases, with input from the
> > > sub-systems/architecture maintainers. I guess that by "package", you
> > > are referring to another division of the work, though.
> >
> > By "package", I mean binaries in the form of *.deb and/or *.rpm - Whilst
> > I'm happy to build and host i386/x86 Debian packages, I'm concerned about
> > treading on someone's toes without a discussion about revision numbers
> > and general policy about "official" releases.
>
> So far, we don't have an established policy for making distro-oriented
> packages; a few people have contributed some of them from time to time,
> but there is no "appointed" maintainer doing sustained work for the
> project on this issue yet.
>
> >  For example, the packages I've
> > built to date have used 2.3.50 even although a tarball of that version
> > hasn't been released.. That could well cause confusion for users and
> > yourself if bugs are reported. There is also a minor problem with keeping
> > the debian/changelog in sync.
> >
> >  One possible answer is for me to rebuild my repository from scratch and
> > append the SVN revision number to revision number so that we end up with
> > 2.3.50-1~r2289 - This would allow an official 2.3.50-1 release to
> > override the ~r2289 revision..
>
> It would be saner to use the commit number indeed, especially since it
> allows decouple the package versioning from the source releases while
> keeping a reference to a common history of changes.
>
> Some information about the current naming scheme I'm using for tagging
> the intermediate development milestones:
>
> 1- when reopened after a major version X.Y has been rolled out, the
> development branch (i.e. SVN trunk/) is always tagged as X.Y.50. There
> is no X.Y.51 version and beyond; the next step is always to enter the
> release candidate cycle when appropriate.

That sounds reasonable - Any packages built from trunk would probably better 
off following an X.Y.50+r<svn tag>.

> 2- when the development branch enters the release candidate cycle, this
> tag is bumped to X.Y.90 for -rc1, X.Y.91 for -rc2 and so on.
>
> 3- a release candidate that goes final is eventually tagged as X.{Y
> +1}.O, and the development cycle restarts at step 1.

So X.{Y+1}.0 will always override an X.Y.50+rnnnn - Works for me.


Regards, Paul.

