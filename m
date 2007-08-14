MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18113.19726.385060.468564@domain.hid>
Date: Tue, 14 Aug 2007 08:34:54 +0200
In-Reply-To: <46C0F888.5050405@domain.hid>
References: <46C0F888.5050405@domain.hid>
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
To: Bill Gatliff <bgat@domain.hid>
Cc: xenomai@xenomai.org

Bill Gatliff wrote:
 > Guys:
 > 
 > 
 > Trying to put together a Xenomai package for my Debian "testing" PC.  It 
 > hangs here:
 > 
 > # svn co ...; cd xenomai
 > # svn-buildpackage -us -uc -rfakeroot
 > ...
 > rm: cannot remove /root/xenomai/debian/tmp//usr/include/xenomai: Is a 
 > directory
 > make[4]: *** [install-data-local] Error 1
 > 
 > 
 > Any ideas?

Maybe you ran into the same problem as Paul ?
https://mail.gna.org/public/xenomai-core/2007-08/msg00045.html

Could you try the patch attached to that mail and tell us ? Note that
since this patch modifies Makefile.ams, you will have to run
scripts/bootstrap


-- 


					    Gilles Chanteperdrix.

