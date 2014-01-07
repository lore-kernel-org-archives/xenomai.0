Message-ID: <52CC7D71.4040703@steinkuehler.net>
Date: Tue, 07 Jan 2014 16:19:29 -0600
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <44lhyrmuw9.fsf@be-well.ilk.org>
In-Reply-To: <44lhyrmuw9.fsf@be-well.ilk.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Altera Cyclone V
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 1/7/2014 1:52 PM, Lowell Gilbert wrote:
> Hi. =

> =

> I'm starting out trying to get Xenomai running on the ARM cores in the
> "golden reference design" for the Cyclone V SOC from Altera. So far, I'm
> still working on getting a kernel booting with the ipipe support, and I
> could use a hand. If anyone's already worked with this system, or if I
> definitely can't get under 10-microsecond latency with core affinity
> keeping my second core clear of non-real-time processing, I'd appreciate
> a word.
> =

> I'm trying to do this on a 3.10 Linux kernel, because going back much
> further will give me problems with backporting some of the peripheral
> support. I may try 3.8 to see what happens, but I really can't go any
> earlier than 3.6 in any case.

I'd follow Gilles' advice for tracking down issues.  I'm working with
this SoC for my day job, and Xenomai on the A8 (TI AM3359 on a
BeagleBone) for my 3D printing hobby.  I design hardware and can't be
much help with the hard-core kernel coding, but I have a couple of dev
boards and am willing to do some compiling and testing if it would help.

If you're trying to stay under 10 uS latency, you may need to
instantiate a soft core CPU of some sort in the FPGA fabric.  The ARM A
series cores aren't really designed for low IRQ latency, but I haven't
seen numbers from a dual-core A9 part yet.  The single-core A8 on the
BeagleBone is good for about 25 uS typical and 80 uS or so worst case
latency.  I'm sure the dual-core A9 will be better, but you're needing
almost an order of magnitude improvement which seems unlikely (but
perhaps not impossible).

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140107/e03ccb7=
f/attachment.sig>
