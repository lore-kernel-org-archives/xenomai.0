From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 22 Jan 2006 21:17:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601222117.01895.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Unresolved symbols
	tickGet/wind_current_context_errno using libvxworks.a
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

Linking my vxworks application library (about 180 C++ files) against xenomai 
2.1 gives me now the following errors:
../../obj/xeno-ppc/BSys_lib.a(BSysCountingSemaphore.o):BSysCountingSemaphore.cpp:
(.text+0x14d4): more undefined references to `wind_current_context_errno' 
follow
../../obj/xeno-ppc/BSys_lib.a(BSysTick.o): In function 
`BSysTick::now()':BSysTick.cpp:(.text+0x1dc): undefined reference to 
`tickGet'

It does not however complain about the other used functions like taskSpawn.
Looking at  /usr/xenomai/lib/libvxworks.a using nm gives me the following 
results:
$ nm -o /usr/xenomai/lib/libvxworks.a |grep tickGet
/usr/xenomai/lib/libvxworks.a:tickLib.o:00000000 T tickGet
$ nm -o /usr/xenomai/lib/libvxworks.a |grep wind_current_context_errno
/usr/xenomai/lib/libvxworks.a:errnoLib.o:00000000 T wind_current_context_errno
$ nm -o /usr/xenomai/lib/libvxworks.a |grep taskSpawn
/usr/xenomai/lib/libvxworks.a:taskLib.o:00000d80 T taskSpawn

Is this the result that tickGet is defined as xnticks_t tickGet(void) in 
xenomai but as int tickGet(void) under vxWorks?

Any help would be appreciated? Thanks in advance.

Best regards

-- 
Niklaus Giger

