From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 11 Mar 2008 21:30:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803112130.18396.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Errors building tarball
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
To: xenomai@xenomai.org

Hi

My HCU3 daily build (which is the only one to build a tarball) reports
the following error when running distcheck (see
http://ngiger.dyndns.org/buildbot/builders/hcu3_f/builds/75/steps/tarball/logs/stdio):

> /home/buildbot/slave/hcu3_f/xenomai/configure successfull
> Exec in /home/buildbot/slave/hcu3_f/build_dist: make SUDO=false distcheck
> make: *** No rule to make target `debian/xenomai.postinst', needed by
> `distdir'.  Stop. make SUDO=false distcheck failed

Commands were
rm -rf /home/buildbot/slave/hcu3_f/build_dist
/home/buildbot/slave/hcu3_f/xenomai/configure
make SUDO=false distcheck

Best regards

Niklaus
 

