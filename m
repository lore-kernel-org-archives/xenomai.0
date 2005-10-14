Message-ID: <42134.193.52.24.125.1129325991.squirrel@domain.hid>
Date: Fri, 14 Oct 2005 23:39:51 +0200 (CEST)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Xenomai PPC -> Disable FP : Bingo !
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

-----------------------------------------------------------------------
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Data:	Fri, Altro: 14, 2005 11:01 pm
A:	<smannori@domain.hid>
Cc:	<xenomai@xenomai.org>
Priority: 	Normal

smannori@domain.hid wrote:
 > Hi:
 >
 > thanks for the help. This is a short report of that happen.
 > (...)
 >
 > Konsole application is crashed with signal 11 SIGSEV
 > (...)

Ok, if you can, could you try to compile xenomai without FPU support ?
-----------------------------------------------------------------------


Yes Sir. And now works without glitch both in text and graphics.
Very good suggestion :) Sir.

I smell FPU/Altivec problems...May be Adeos is not fully G4 compliant for
the FP section ? Ok Real man don't need FP (see Linux/Linus in the kernel).
... but sometime a couple of FP ops could be very useful :)

Thanks again for the help: now the system go.

I'm looking forward for latest kernel support, Comedi, ecc..

Good Nigth :)

                     Simone











