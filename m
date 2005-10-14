From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17232.8782.942674.552803@domain.hid>
Date: Fri, 14 Oct 2005 23:25:34 +0200
Subject: Re: [Xenomai-help] Xenomai -> PPC : Better but no cigar yet
In-Reply-To: <4826.193.52.24.125.1129324338.squirrel@domain.hid>
References: <4826.193.52.24.125.1129324338.squirrel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: smannori@domain.hid
Cc: xenomai@xenomai.org

smannori@domain.hid wrote:
 > Hi:
 > 
 > I compiled the adeos-patched kernel 2.6.10, and I recompiled and installed
 > Xenomai from scratch.
 > 
 > After a clean boot, using CRTL+ALT+F1 I logged in a pure text terminal. In
 > this terminal the latency tesk works correctely. If I came back to the
 > graphics terminal with CRTL+ALT+F7 the behavior of the windows are erratic
 > and very strange. If I stop the realtime task everythings go back to normal.

When I tell you to run without X, I mean do not run X. At all. Stop
it. Kill it.


 > I think that the X11 driver shipped with mandriva 10.2 x PPC is a bit
 > tweaked BUT IS NOT THE PROPRIETARY ATI with OpenGL acceleration.
 > 
 > The proprietary ATI driver works with ADEOS in hard-realtime, but I cannot
 > use on a PPC machine because ATI don't release the code. I tried the r300
 > project without succces.

I tried Xenomai with proprietary code from nvidia; it runs fine except
for huge latencies when switching consoles, changing mode or loading 3D
textures: but you have absolutely to recompile the "glue" part of the
driver using the Adeos patched kernel. But I did not see any crashes. I
was just try to make sure you were not trying to run the binary driver
without recompiling it.


 > 
 > It is NOT the first time that an X11 video driver ruin the hard realtime
 > coherency: the RTAI mailing list is full of this examples (expecially in the
 > past).

Yes, using X11 breaks hard real-time, but by causing huge latencies,
there is no evidence so far that it creates random crashes and
segmentation faults. Segmentation faults are rather usually due to a
hole in the FPU switching code, they happen when running X simply
because X applications use the FPU. 

To check if this is the case, could you please try disabling FPU support
?


-- 


					    Gilles Chanteperdrix.

