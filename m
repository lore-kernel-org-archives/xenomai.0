From: Paul <paul_c@domain.hid>
Date: Mon, 5 Mar 2007 15:48:11 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703051548.12008.paul_c@domain.hid>
Subject: [Xenomai-core] --includedir ignored
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>


Exploring some of the configure options with the view to generating a Debian 
rule and I noticed a bug (?) in the make files - Passing an --includedir 
option to configure, during the install phase, the given directory path is 
ignored and make eventually bombs out when trying to create an asm/ symlink.

 Checking the include/ Makefile.am and it's siblings, I note includedir is 
overridden by $(prefix)/include/<skin> and $(prefix)/include/asm-<arch>, yet 
include/Makefile.am honours the $(includedir) config variable when attempting 
to create the symlink.

 Also noted that include/compat/ headers don't get installed - Is this, and 
the $(includedir) issue an oversight ?


Regards, Paul.

