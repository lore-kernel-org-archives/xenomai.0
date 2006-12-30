From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 30 Dec 2006 15:38:28 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200612301538.28825.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot update
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

In the last weeks before Christmas I was integrating the new features of the 
Buildbot 0.7.5 release into the Xenomai buildbot. I would like to thank Brian 
Warner (maintainer of Buildbot) for integrating my suggestions into the 
buildbot framework.

The changes were:
* In December 2006 I upgraded to buildbot 0.7.5 and used the new 
features "SVNPoller" to eliminate the svn_watcher.py script. There are cases, 
where SVNPoll breaks the buildbot if it does not get a correct answer from 
the SVN-repository, then I have to restart the master manually and the 
intermediate revisions are lost.

* The "FileUpload" and "FileDownload" in buildbot 0.7.6 allowed me also to 
centralise all configs and scripts on the master.

* Changed the hcu3 builder (PPC405 based boards) using ELDK 4.0 on a 
MacMini running GNU/Debian Linux. (before they were located on a PowerBook 
G4).

* As suggested my Jan and Gilles I switched one of the builders to generate 
first a tarball. An example of this build may be found at:
http://ngiger.dyndns.org/buildbot-full/hcu3_f/builds/55

* As requested by rpm he will receive an email each time the buildbot found an 
error building one of its targets. If somebody else wants to receive these 
emails, he can drop me an email. 
	Unfortunately there are sometimes false positives because of
  - Unavailability/errors in my infrastructure (the systems are shared for 
other uses too
   - Changes in the buildbot setup, as I have different machines to test my 
setup and the buildbot master

As always you may consult the documentation at
http://ngiger.dyndns.org/xenomai-data/xeno_buildbot.pdf
All the buildbot configuration files are stored in the SVN repository
http://ngiger.dyndns.org/svn/admin/hcu3_linux/doc/buildbot


Best regards
-- 
Niklaus Giger

