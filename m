From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 15 Aug 2006 09:49:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608150949.30029.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot cannot compile xenoma: rtcanconfig refences
	pthread_kill
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
To: xenomai-core <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Hi

All my PPC based compilation fail with something like

ccache gcc -rdynamic -o .libs/rtcanconfig 
rtcanconfig.o  -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/native -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so -Wl,--rpath -Wl,/usr/xenomai/lib
/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.libs/librtdm.so: 
undefined reference to `pthread_kill'
http://ngiger.dyndns.org/buildbot/ppc/builds/229/step-mk_xeno/0
Is this only a PPC problem? It appears first with build 226, which referred to 
revisions 1433 and 1434. Details see 
http://ngiger.dyndns.org/buildbot/ppc/builds/226

Jan, could you please have a look at the error, as it seems to me that you 
reduced the lib dependencies a little bit too much?

Jan BTW, I also switched the RTNet svn to the new location. 

Best regards

-- 
Niklaus Giger

