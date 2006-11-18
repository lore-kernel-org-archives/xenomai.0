From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 18 Nov 2006 18:18:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181818.17629.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot: Errors building rtnet since at least r1834
Reply-To: niklaus.giger@domain.hid
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

Hi

Unfortunately I cannot say since when this build is broken, as I had to 
reinstall the buildbot on my main server. But this particular build target 
should not have been affected. (Same compiler, same build slave, same 
scripts)

But since at November 12 I get the following errors in my builds:
See http://ngiger.dyndns.org/buildbot-full/tqm_f/builds/0/step-mk_RTnet/1
libtool: link: warning: library 
`/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' was 
moved.
libtool: link: warning: library 
`/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was moved.
libtool: link: warning: library 
`/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' was 
moved.
libtool: link: warning: library 
`/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was moved.

Has anybody a hint, what the reason could be?

Best regards

-- 
Niklaus Giger

