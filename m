From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: AW: [Xenomai-help] prepare kernel fails
Date: Tue, 19 Dec 2006 22:02:58 +0100
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<200612192054.54573.niklaus.giger@domain.hid>
	<45884DC5.2030701@domain.hid>
In-Reply-To: <45884DC5.2030701@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612192202.58982.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

Am Dienstag, 19. Dezember 2006 21:38 schrieb Jan Kiszka:
> Niklaus Giger wrote:
> > Am Montag, 18. Dezember 2006 15:39 schrieb Gilles Chanteperdrix:
> >> Jan Kiszka wrote:
> >>> @all: please give the -rc3 tar.bz2 hell! New files can easily slip
> >>> through the developer fingers when it comes to distribution (I know
> >>> this very well /wrt RTnet...).
> >>
> >> The way around this is to run automated scripts using the result of a
> >> make distcheck instead of using an svn checkout. Niklaus, how hard would
> >> it be to change the buildbot to do this ?
> >
> > What do you want the buildbot do to exactly?
> > a) First svn checkout followed by make distcheck?  This is easy. eg. I
> > would just add an additional step before the "configured
> > xenomai"
> >
> > b) Grab tarballs, extract them to clean directory? Here I need to study
> > the buildbot a bit better, as it does no concept for tarballs as
> > ChangeSources. But I might write a small script which polls
> > http://download.gna.org/xenomai/testing/ and
> > http://download.gna.org/xenomai/stable/ for new tarballs. If found I
> > would unpack it somewhere and submit the change to some new builders
> > Buildbot (similar to the /buildbot-full/).
> > This will probably take a few hours of work, but quite for some time I
> > felt uncomfortable about neither testing branches nor releases.
> > If this solution works I would suggest that the release manager should
> > delay announcing the availability of a new releases till he has examined
> > the results of the buildbot.
> >
> > What variant do you prefer?
>
> I rather think c) is desired: checkout from svn, make dist, untar that
> archive and continue to work with *those* sources.
This solution is also easily integretable into the actual Buildbot. I suppose 
do it would be sufficient to add it only to the daily "full" builds. But I 
would need to know how the release is exactly generated. E.g. after a 
checkout to clean directory there is no Makefile and therefore "make dist" 
fails miserably. Could somebody please tell me the exact steps?

Niklaus

