From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 13 Apr 2006 06:59:22 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604130659.23223.niklaus.giger@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] BuildBot progress for sim, tqm860 with RTnet
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

I was busy improving the buildbot setup and achieved the following:
- added build slave for simulator
- added a buildbot for a TQM860L with Denx PPC 2.4 kernel. Cannot yet build 
the RTnet code.
- patched buildbot to show names for shell build steps instead of the commands
- Hacked buildbot to improve the displayed names of the build step
  (e.g. "configure_xenomai" instead of "configure 2". 

I will look at Philippe's idea about collecting xenomai statistics later, 
because it demands more time and effort to implement.

The following details are probably only of interest for people interested in 
TQM860 and/or RTnet.

My setup for the TQM860 was the following:
- Got Dan Kegel crosstool 0.42
- Compiled/installed the demo-ppc860 (gcc-3.4.1-glibc-2.3.3)
- Used linuxppc_2_4_devel-2006-04-06-1735.tar.bz whith a TQM860L_defconfig
  plus XENOMAI extensions
- Got RTnet trunk via SVN

Could the interested parties please comment, whether this is a good 
combination or whether they prefer something different? If you follow the 
logs you are able to see each step and configuration option (except building 
the crosstool).

configure rtnet fails with the following message:
checking for 
RT-extension... /home/buildslave/bin/linuxppc_2_4_devel-2006-04-06-1735 
(Xenomai 2.0.x)
checking for Xenomai version... configure: error: *** Unsupported Xenomai 
version 2.1.50 in /home/buildslave/bin/linuxppc_2_4_devel-2006-04-06-1735
Is the error correct? Or should I build only against Xenomai 2.0?

Best regards

-- 
Niklaus Giger

