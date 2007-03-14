From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] debian/rules update
Date: Wed, 14 Mar 2007 16:48:56 +0000
References: <200703121756.08070.paul_c@domain.hid>
	<45F7D59E.3090406@domain.hid> <1173870898.32259.41.camel@domain.hid>
In-Reply-To: <1173870898.32259.41.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703141648.56722.paul_c@domain.hid>
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

On Wednesday 14 March 2007 11:14, Philippe Gerum wrote:
> On Wed, 2007-03-14 at 11:59 +0100, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > On Tue, 2007-03-13 at 20:32 +0000, Paul wrote:
> > >>Hi Philippe
> > >>
> > >>On Tuesday 13 March 2007 16:30, Philippe Gerum wrote:
> > >>>>A question for the project admins: Do you have a Release Manager to
> > >>>>coordinate package releases ?
> > >>>
> > >>>I'm currently coordinating the Xenomai releases, with input from the
> > >>>sub-systems/architecture maintainers. I guess that by "package", you
> > >>> are referring to another division of the work, though.
> > >>
> > >>By "package", I mean binaries in the form of *.deb and/or *.rpm -
> > >> Whilst I'm happy to build and host i386/x86 Debian packages, I'm
> > >> concerned about treading on someone's toes without a discussion about
> > >> revision numbers and general policy about "official" releases.
> > >
> > > So far, we don't have an established policy for making distro-oriented
> > > packages; a few people have contributed some of them from time to time,
> > > but there is no "appointed" maintainer doing sustained work for the
> > > project on this issue yet.
> > >
> > >> For example, the packages I've
> > >>built to date have used 2.3.50 even although a tarball of that version
> > >> hasn't been released.. That could well cause confusion for users and
> > >> yourself if bugs are reported. There is also a minor problem with
> > >> keeping the debian/changelog in sync.
> > >>
> > >> One possible answer is for me to rebuild my repository from scratch
> > >> and append the SVN revision number to revision number so that we end
> > >> up with 2.3.50-1~r2289 - This would allow an official 2.3.50-1 release
> > >> to override the ~r2289 revision..
> > >
> > > It would be saner to use the commit number indeed, especially since it
> > > allows decouple the package versioning from the source releases while
> > > keeping a reference to a common history of changes.
> >
> > Do we really want to make debian packages with trunk ? Would not it make
> > sense to only make debian packages from stable releases ?
>
> Not necessarily, the same way one may want to base his work on sid,
> because some features only available in the development branch are
> needed (e.g. support for multiple time bases is only available in the
> trunk/ and not with 2.3.x, and one would need such feature to run
> VxWorks and the POSIX skins in parallel for instance). Provided we do
> have a non-confusing way to name such intermediate releases, of course.

With a Debian pool style of repository, the X.Y.50+rnnn packages would always 
go in unstable (Sid) or even experimental. When the release number gets 
bumped up to X.{Y+1}.0, it would go in testing (Etch), and when Etch becomes 
the default "stable", any X.Y.0 releases would automatically migrate across.
Bug fixes to X.Y.{0+n} would normally appear in testing and/or stable leaving 
Sid to track the trunk of SVN - Primarily a repository management issue..

Following this proposal, the end user can opt for stable/testing or unstable. 
Should he/she choose, it is a simple matter to "downgrade" from unstable or 
track the unstable releases.. That said, I suspect most users would compile 
from source, perhaps using the debian/rules as an aid to install/remove.. 
Prebuilt binaries & kernels would most likely be used by people wanting to 
try Xenomai before committing time to a patch/build cycle.


Regards, Paul.

