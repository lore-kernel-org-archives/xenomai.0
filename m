MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18376.27268.570447.130166@domain.hid>
Date: Fri, 29 Feb 2008 21:26:44 +0100
In-Reply-To: <200802292012.18924.paul_c@domain.hid>
References: <47C71CF6.1040701@domain.hid> <47C80D5C.2020409@domain.hid>
	<18376.25072.448345.88827@domain.hid>
	<200802292012.18924.paul_c@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Script marking
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
 > 
 > Hi Giles
 > 
 > First, sorry about not jumping in on some of the other threads about Debian 
 > and packaging...
 > 
 > On Friday 29 February 2008 19:50, Gilles Chanteperdrix wrote:
 > > Roland Stigge wrote:
 > >  > Gilles Chanteperdrix wrote:
 > >  > >>  Further, I updated the package in Debian with the suggested changes.
 > >  > >
 > >  > > We trust you, please send patches.
 > >  >
 > >  > The attached patch (and the latest version of it) can also always be
 > >  > found at the Debian developer's package page for Xenomai at
 > >  > http://packages.qa.debian.org/x/xenomai.html .
 > >  >
 > >  > It applies to the latest Xenomai release (currently 2.4.2), and assumes
 > >  > that there is _no_ debian/ directory in the original source tree (as
 > >  > discussed beforehand - Debian maintains the complete debian/* hierarchy
 > >  > completely - for further questions just ask).
 > >
 > > Hi Paul,
 > >
 > > Is it Ok for you to replace the repository debian directory current
 > > contents with the debian directory as provided by Roland ? Or will it
 > > break things on your side ?
 > 
 > I have no problem with Roland's changes, it won't break anything I do. The 
 > relevant wiki page will need to be updated to reflect the extra packages that 
 > are generated, but that is a minor detail.

IMO, the page should be updated to talk about the official Debian
packages as well.

 > 
 > On a personal level, I would like to see a debian/ structure retained within 
 > SVN - This simplifies test builds and allows changes (such as merged x86 
 > trees) to be tackled before (Debian) releases are made.

I agree. This is a way to build Xenomai which we should not
remove. Roland also has the choice to use it if he changes his mind.

-- 


					    Gilles Chanteperdrix.

