Message-ID: <34086.193.52.24.125.1129373726.squirrel@domain.hid>
Date: Sat, 15 Oct 2005 12:55:26 +0200 (CEST)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] XenoPPC :-> 2.6.13.4-ipipe :)
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

Everything works perfect (for the internal test). CPU pushed steady to 99%
with glxgear (NO DRI, software emululation only by Mesa): 350 fps

Max latency = 44 us
Overrun = zero nil nada zip.

I think that the save/restore functions of xenomai must be aware of the
presence of Altivec. If I disable Altivec the X11 server (x.org) shipped
with mandriva ppc does not start.

This is a very good impruvement. If you use thread in the user space, the
FPU support is not a must.

   Simone








