MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18113.59782.659101.864063@domain.hid>
Date: Tue, 14 Aug 2007 19:42:30 +0200
In-Reply-To: <200708141603.23540.paul_c@domain.hid>
References: <46C0F888.5050405@domain.hid>
	<200708141603.23540.paul_c@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] svn-buildpackage not working?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
 > 
 > Hi Bill
 > 
 > On Tuesday 14 August 2007 01:34, Bill Gatliff wrote:
 > > Guys:
 > >
 > >
 > > Trying to put together a Xenomai package for my Debian "testing" PC.  It
 > > hangs here:
 > >
 > > # svn co ...; cd xenomai
 > > # svn-buildpackage -us -uc -rfakeroot
 > > ...
 > > rm: cannot remove /root/xenomai/debian/tmp//usr/include/xenomai: Is a
 > > directory
 > > make[4]: *** [install-data-local] Error 1
 > >
 > >
 > > Any ideas?
 > 
 > I reported this problem a couple of days ago on Xenomai-core along with a 
 > patch. FYI, same patch attached - You'll need to run scripts/bootstrap (and 
 > use --svn-ignore with svn-buildpackage).

Patch is applied, bootstrap run, everything should be ok now.

-- 


					    Gilles Chanteperdrix.

