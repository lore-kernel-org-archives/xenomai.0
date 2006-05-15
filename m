From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17512.27312.732005.286673@domain.hid>
Date: Mon, 15 May 2006 13:49:04 +0200
Subject: Re: [Xenomai-help] mutex_init() error when build
In-Reply-To: <4468652B.1050704@domain.hid>
References: <4546494d0605150250h350fa8c6me325b6d7a73a6d6f@domain.hid>
	<4468652B.1050704@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid

Philippe Gerum wrote:
 > Li Yi (Adam) wrote:
 > > Hi,
 > > 
 > > I am using Xenomai-2.1.0 on Blackfin uClinux. When enabling "POSIX" 
 > > interface and build the kernel, I got error message:
 > > 
 > 
 > It's a known issue involving a naming conflict between 2.6.16 and Xeno 
 > 2.1.x. This has been fixed in 2.2, but we will likely have to backport 
 > this fix.

The fix was backported, commit 772, and is included in release v2.1.1:
http://download.gna.org/xenomai/stable/xenomai-2.1.1.tar.bz2

-- 


					    Gilles Chanteperdrix.

