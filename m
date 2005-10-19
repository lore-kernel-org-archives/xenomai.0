From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.64004.730077.475100@domain.hid>
Date: Wed, 19 Oct 2005 09:47:16 +0200
Subject: RE: [Xenomai-core] Cosmetic changes to script xeno-config + man page
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E2D@rennsmail02.eu.thmulti.com>
References: <1CFEB358338412458B21FAA0D78FE86D4F0E2D@rennsmail02.eu.thmulti.com>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
 > Romain Lenglet wrote:
 > [..]
 > >I found a better solution, that could be a replacement for both a 
 > >xenomai.m4 trick, and the xeno-config script: pkg-config.
 > >http://pkgconfig.freedesktop.org/wiki/
 > >There are packages for pkgconfig in both Debian and RedHat, 
 > >AFAIK, and surely for all other distribs.
 > >
 > >I will look into making a xenomai.pc file.
 > 
 > Make it a xenomai.pc.in file   ;-)

I am not sure we want to depend on pkg-config...

-- 


					    Gilles Chanteperdrix.

