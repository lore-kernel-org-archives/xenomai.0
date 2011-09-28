Message-ID: <4E8368A6.7010303@domain.hid>
Date: Wed, 28 Sep 2011 20:34:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai 2.6.0-rc4
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>


Hi, 

here is the 4th release candidate for Xenomai 2.6.0:
http://download.gna.org/xenomai/testing/xenomai-2.6.0-rc4.tar.bz2

Novelties since -rc3 include:
- a fix for the "long names" issue on psos+
- a fix for the build issue of mscan on mpc52xx (please Wolfgang, have 
a look at the patch, to see if you like it:)
http://git.xenomai.org/?p=xenomai-head.git;a=commitdiff;h=d22fd231db7eb0af8e77ec570efb89e578e13781;hp=4a2188f049e96fc59aa7c4a7a9d058075f3d79e8
- a new version of the I-pipe patch for linux 3.0 on ppc.

This should be the last release candidate.

Regards.

-- 
                                                                Gilles.

