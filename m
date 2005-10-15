Message-ID: <58010.193.52.24.125.1129376818.squirrel@domain.hid>
Date: Sat, 15 Oct 2005 13:46:58 +0200 (CEST)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] XenoPPC : 
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi:

- Apple PowerBook 1.67
- Mandriva Limited 2005 (Mandrake 10.2) for PPC
- Linux 2.6.13.4
- Adeos patch x ppc (32bit - G4) (www.adeos.org) (Thanks Philippe :) )
- Xenomai: configured with NO FPU SUPPORT  (Thanks Gilles  :) )

CPU pushed steady to 99%:
- glxgear (NO DRI, software emululation only by Mesa): 250 fps
- Kaffeine player: Linux Revolution DVD . Audio OK, Video OK

Max latency = 18 us

Overrun = ONE : when I inserted the DVD I noticed one single 180us overrun.
I think that the interrupt gerated from DVD slot-in superdrive is not
handled properly. The DVD playback is smooth as usual.

Overrun = TWO :  twin 220us overrun when DVD player has changed layer.

I'm understanding your efforts regarding the FP support without switching
"mode".

If you have any suggestion regarding the testing... I'm ready :)

       Simone

P.S. Do you know where is it a good Madriva PPC repository for rpm(s) and
update ?








