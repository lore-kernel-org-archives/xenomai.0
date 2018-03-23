Date: Fri, 23 Mar 2018 15:39:33 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180323153933.2866a618@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <CAOuPNLhn=TCvg9rvXHdS6232WEVARpE3YJN5He2sdjUx=jWc8A@mail.gmail.com>
References: <CAOuPNLh0inmNY6Vi6CDDranrF3iRv8zKeokfppbZCnoAVz=ZBQ@mail.gmail.com>
 <20180323124215.53d92406@mmd1pvb1c.ad001.siemens.net>
 <CAOuPNLhr5GAznXwfSEke1Z8jAa0CCXgK2aCD1_N1HYo57mjMWw@mail.gmail.com>
 <20180323144007.03c11111@mmd1pvb1c.ad001.siemens.net>
 <CAOuPNLhn=TCvg9rvXHdS6232WEVARpE3YJN5He2sdjUx=jWc8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FUSE package error while doing configure for xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Am Fri, 23 Mar 2018 19:12:42 +0530
schrieb Pintu Kumar <pintu.ping@gmail.com>:

> On Fri, Mar 23, 2018 at 7:10 PM, Henning Schild
> <henning.schild@siemens.com> wrote:
> > Am Fri, 23 Mar 2018 18:55:27 +0530
> > schrieb Pintu Kumar <pintu.ping@gmail.com>:
> >  
> >> On Fri, Mar 23, 2018 at 5:12 PM, Henning Schild
> >> <henning.schild@siemens.com> wrote:  
> >> > Am Fri, 23 Mar 2018 11:36:48 +0530
> >> > schrieb Pintu Kumar <pintu.ping@gmail.com>:
> >> >  
> >> >> Hi,
> >> >>
> >> >> I am trying to install xenomai-3 again.
> >> >> # ./script/bootstrap
> >> >>
> >> >> After this, when I do configure, it is stopped at FUSE
> >> >> # ./configure
> >> >> ....
> >> >> ....
> >> >> checking whether the registry should be enabled... no
> >> >> ./configure: line 13838: syntax error near unexpected token
> >> >> `FUSE,' ./configure: line 13838: `      PKG_CHECK_MODULES(FUSE,
> >> >> fuse)'
> >> >>
> >> >> How to solve this problem ?
> >> >> If anybody have come across this problem?  
> >> >
> >> > Yes, it is known. You will have to install "pkg-config", or the
> >> > equivalent if you are not on Debian.
> >> >  
> >>
> >> Yes, I already installed it.
> >> pkg-config is already the newest version (0.29.1-u.4.0.0.2).
> >> 0 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
> >>
> >> Looks like some problem with fuse.
> >>
> >> # apt-get install fuse
> >> Reading package lists... Done
> >> Building dependency tree
> >> Reading state information... Done
> >> Some packages could not be installed. This may mean that you have
> >> requested an impossible situation or if you are using the unstable
> >> distribution that some required packages have not yet been created
> >> or been moved out of Incoming.
> >> The following information may help to resolve the situation:
> >>
> >> The following packages have unmet dependencies:
> >>  fuse : Depends: libfuse2 (= 2.9.3-u.4.0.0.1) but 2.9.7-u.4.0.0.2
> >> is to be installed
> >> E: Unable to correct problems, you have held broken packages.  
> >
> > You only need fuse when enabling the registry, which you probably do
> > not want to do. The problem you run into is your autoconf not
> > supporting PKG_CHECK_MODULES.
> >
> > grep PKG_CHECK_MODULE /usr/share/aclocal/*
> > should return a line like the following
> > ...
> > /usr/share/aclocal/pkg.m4:AC_DEFUN([PKG_CHECK_MODULES_STATIC],
> > ...  
> 
> OK. For me it return like this:
> 
> # grep PKG_CHECK_MODULE /usr/share/aclocal/*
> /usr/share/aclocal/fontutil.m4: PKG_CHECK_MODULES(MAPS, [fontutil])

If that is the only hit you seem to missing AC_DEFUN and pkg.m4. Find
which package provides this file in your distro.

Henning

> 
> 
> >
> > If not, you are missing some package.
> >
> > Henning
> >  
> >>
> >>  
> >> > Henning
> >> >  
> >> >> I tried installing : fuse, libfuse2, but it did not help.
> >> >>
> >> >> Please help!
> >> >>
> >> >>
> >> >> Thanks,
> >> >> Pintu
> >> >>
> >> >> _______________________________________________
> >> >> Xenomai mailing list
> >> >> Xenomai@xenomai.org
> >> >> https://xenomai.org/mailman/listinfo/xenomai  
> >> >  
> >  


