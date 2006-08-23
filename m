From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 23 Aug 2006 20:58:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608232058.36523.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Problems building RTnet
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

Since a few hours RTnet cannot even be configured, as the Xenomai version got
bumped to 2.3-devel. See
http://ngiger.dyndns.org/buildbot/tqm860/builds/8/step-cfg_RTnet/0
Where it says:

checking for Xenomai version... configure: error: *** Unsupported Xenomai 
version 2.3-devel in /var/buildbot/slave/tqm860/linux

This morning the buildbot complained like the following:
powerpc-860-linux-gnu-gcc -DHAVE_CONFIG_H -I. -I. -I../../../config   -g -I. -I/usr/xenomai/include -g -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -pipe -I../../../stack/include -I../../../stack/include -g -MT 
rtnet_ifs.o -MD -MP -MF ".deps/rtnet_ifs.Tpo" -c -o rtnet_ifs.o rtnet_ifs.c; 
\
        then mv -f ".deps/rtnet_ifs.Tpo" ".deps/rtnet_ifs.Po"; else 
rm -f ".deps/rtnet_ifs.Tpo"; exit 1; fi
In file included from rtnet_ifs.c:31:
../../../stack/include/rtnet.h:29:23: rtdm/rtdm.h: No such file or directory
rtnet_ifs.c: In function `main':
rtnet_ifs.c:51: warning: implicit declaration of function `rt_dev_socket'
rtnet_ifs.c:61: warning: implicit declaration of function `rt_dev_ioctl'
rtnet_ifs.c:61: error: `SIOCGIFCONF' undeclared (first use in this function)
rtnet_ifs.c:61: error: (Each undeclared identifier is reported only once
rtnet_ifs.c:61: error: for each function it appears in.)
rtnet_ifs.c:63: warning: implicit declaration of function `rt_dev_close'
rtnet_ifs.c:73: error: `SIOCGIFFLAGS' undeclared (first use in this function)
rtnet_ifs.c:83: error: `SIOCGIFINDEX' undeclared (first use in this function)
make[4]: *** [rtnet_ifs.o] Fehler 1

Best regards
-- 
Niklaus Giger

