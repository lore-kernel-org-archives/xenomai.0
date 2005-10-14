Message-ID: <4826.193.52.24.125.1129324338.squirrel@domain.hid>
Date: Fri, 14 Oct 2005 23:12:18 +0200 (CEST)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Xenomai -> PPC : Better but no cigar yet
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

I compiled the adeos-patched kernel 2.6.10, and I recompiled and installed
Xenomai from scratch.

After a clean boot, using CRTL+ALT+F1 I logged in a pure text terminal. In
this terminal the latency tesk works correctely. If I came back to the
graphics terminal with CRTL+ALT+F7 the behavior of the windows are erratic
and very strange. If I stop the realtime task everythings go back to normal.

I think that the X11 driver shipped with mandriva 10.2 x PPC is a bit
tweaked BUT IS NOT THE PROPRIETARY ATI with OpenGL acceleration.

The proprietary ATI driver works with ADEOS in hard-realtime, but I cannot
use on a PPC machine because ATI don't release the code. I tried the r300
project without succces.

It is NOT the first time that an X11 video driver ruin the hard realtime
coherency: the RTAI mailing list is full of this examples (expecially in the
past).

Philippe: at this point I think that it is not your fault.

Thanks again to everybody for the help.

                    Simone





