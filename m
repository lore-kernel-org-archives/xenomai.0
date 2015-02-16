From: "Hays, Arthur (NIH/NEI) [E]" <art@lsr.nei.nih.gov>
Date: Mon, 16 Feb 2015 16:18:04 +0000
Message-ID: <7E7E1F635323E543B04E7D69A4E262E7159C6AC4@msgb08.nih.gov>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Porting from QNX?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hays, Arthur (NIH/NEI) [E]" <art@lsr.nei.nih.gov>

Our application for laboratory automation and experimental control (for neu=
rophysiology labs) runs on QNX on commodity x86 motherboards (when we can f=
ind ones that don't have the SMM issue).  We do this because our users are =
on tight grant money at universities.

With QNX we measure typical 4usec and worst case maximum 6usec latency from=
 #INTA asserted on the PCI bus to entry of a service routine in user space.=
  This is when disk i/o, display updating, network activity all present.

We also execute another routine scheduled by a timer every 1msec that may i=
nvolve updating the display and network communication to other machines.  T=
he jitter for this routine is not crucial.

QNX has discontinued self-hosting on x86- they are embedded only now.  Phot=
on/PhAB is no longer supported.  So we are looking to port to another envir=
onment that is self-hosted on x86 perhaps using Qt instead of Photon.

>From what I've read on Xenomai the typical latency to entry of a routine in=
 user space initiated by a hardware IRQ would stay the same as with QNX, bu=
t the maximum would be on the order of 20-40usec on x86?

Would the routine that is scheduled every 1msec be able to update displays =
and use TCP/IP?

Any advice would be appreciated.

Thanks,

Art Hays
National Institutes of Health
National Eye Institute
Bethesda, MD  20892







