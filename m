From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1267017080.26785.324.camel@domain.hid>
References: <4B6E8167.6010907@domain.hid> <4B76B7F2.2050303@domain.hid>
	<4B76C045.2070602@domain.hid>
	<1266140329.27019.17.camel@domain.hid>
	<4B8407B5.10109@domain.hid>
	<1266947163.26785.300.camel@domain.hid>
	<4B85246A.2020907@domain.hid>
	<1267017080.26785.324.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Feb 2010 14:13:23 +0100
Message-ID: <1267017203.26785.325.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-02-24 at 14:11 +0100, Philippe Gerum wrote:
> On Wed, 2010-02-24 at 14:06 +0100, Stefan Kisdaroczi wrote:
> > Hi Philippe,
> > 
> > Am 23.02.2010 18:46, schrieb Philippe Gerum:
> > > On Tue, 2010-02-23 at 17:52 +0100, Stefan Kisdaroczi wrote:
> > >> Hi,
> > >>
> > >> Am 14.02.2010 10:38, schrieb Philippe Gerum:
> > >>>
> > >>> <snip>
> > >>> In the future, maybe we could simply provide a wrapper script accepting
> > >>> sub-commands, such as "xeno latency, xeno sigtest" etc, to be put
> > >>> into /usr/bin by distros, which would hide the actual location of those
> > >>> binaries?
> > >>>
> > >>> In any case, thanks for your work so far. We probably need to discuss
> > >>> the packaging issues on this list, so that we get both consistency and
> > >>> usability in the future.
> > >>>
> > >>> Gilles and Roland, if this is fine with you, I'll handle the liaison
> > >>> role with upstream packagers, so please CC me explicitly on those mails.
> > >>> We'll sort out this issue, it doesn't look that bad anyway.
> > >>
> > >> Roland added a xeno wrapper to the debian.org xenomai package 2.5.1-3.
> > >>
> > >> I synced now the debian/ directories from debian.org and xenomai.org:
> > >>  - For debian.org I sent patches to the Debian bugtracker [1] [2].
> > >>    Another patch for dpkg-cross support [3] I sent to Roland privately.
> > >>  - For xenomai.org I attached patches to this mail (against -2.5.git).
> > >>
> > >> If both parties apply the patches the debian directories are in sync,
> > >> except some minor differences in the debian/control file, see patch
> > >> do-not-commit-please.patch. I would like to keep these changes out so
> > >> that the xenomai.org packages are compatible with Debian 5.0 Lenny.
> > >> The debian.org packages are for Debian 6.0 Squeeze.
> > >>
> > > 
> > > Merged into my queue (except the last one as mentioned). This will be
> > > pushed upstream to Gilles for 2.5.2. Thanks.
> > 
> > I took a look at your branch for-upstream. Your commit
> >   scripts: add wrapper script to run standard Xenomai commands
> >   6e0574791f48cbf8b3421a68c5789254e7d084b7
> > adds the same wrapper as my patch 0005-debian-wrapper-script-usr-bin-xeno-to-call-executa.patch
> >   debian: wrapper script /usr/bin/xeno to call executables in /usr/lib/xenomai/
> >   fbe86cc50d3a65cd23e93d43adba4ed369fe70b1
> > Please revert the commit of my patch, we need another fix for debian/rules for "your" wrapper.
> > 
> 
> Ok, I thought your patch set was based on my tree, so I did not check
> thoroughly. I did not send any pull request to Gilles, so no harm done.
> 
> > How do I call configure to install the wrapper in /usr/bin and
> > the programs like latency, switchtest etc. to /usr/lib/xenomai ?
> > 
> 
> We need some fixage in scripts/wrappers/Makefile.am to do that. I'll
> prepare this asap.

scripts/Makefile.am...

> 
> > Stefan
> > 
> > > 
> > >> Thanks
> > >> kisda
> > >>
> > >> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=571099
> > >> [2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=571104
> > >> [3] http://git.xenomai.org/?p=xenomai-2.5.git;a=commitdiff;h=5bcd18f714f4cbeaaac0cc4a08e6c9f375aa3b77
> > > 
> > > 
> > 
> > 
> 
> 


-- 
Philippe.



