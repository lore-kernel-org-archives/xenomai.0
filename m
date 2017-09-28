From: <dietmar.schindler@manroland-web.com>
Date: Thu, 28 Sep 2017 06:18:47 +0000
Message-ID: <440e81c61b3749b293cb7d3c9281f069@AUSMXMBX04.mrws.biz>
References: <CAKJ14NdyH7FF+pwj9J-FLSnCWHOqAteKVrrbagA4eqhvETgFoA@mail.gmail.com>
 <CAKJ14NfuNCtfK9bT5Oh+dRYAKhW+4KgaFO5w=xt=exJOw6forQ@mail.gmail.com>
 <e847e788-f0c4-9d27-9dd7-4cb9c22de649@xenomai.org>
 <CAKJ14NcCac2Q32b8tGsNKXYZX9toGsxBEvXGt+2Pa8FYrihdKQ@mail.gmail.com>
In-Reply-To: <CAKJ14NcCac2Q32b8tGsNKXYZX9toGsxBEvXGt+2Pa8FYrihdKQ@mail.gmail.com>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Unexpected mode switches when reordering C++ lines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

> Von: Andreas Glatz
> Gesendet: Mittwoch, 27. September 2017 15:38
>
> ...
> >>>    u32Tmp        =3D ntohl(*reinterpret_cast<u32*>(pDat));
> >>>    sPhasor.mag   =3D interpretU32AsFloat(u32Tmp);
> >>>    u32Tmp        =3D ntohl(*reinterpret_cast<u32*>(pDat+4));
> >>>    sPhasor.angle =3D interpretU32AsFloat(u32Tmp);
> ...
>
> It's true according to the ARM doc [1]. But the pDat alignment is
> prescribed by the sender and we're at the receiver. So I guess the
> question is how to tell the assembler not to use ldm in the first
> place?

Try defining `*pDat` with `volatile`.
See http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.faqs/ka16=
346.html (How do I avoid the compiler generating LDM/STM instructions?)
--
Regards,
Dietmar Schindler
________________________________
manroland web systems GmbH | Managing Director: Alexander Wassermann
Registered Office: Augsburg | Trade Register: AG Augsburg | HRB-No.: 26816 =
| VAT: DE281389840

Confidentiality note:
This eMail and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you are not the intended recipient, you are hereby notified that any use=
 or dissemination of this communication is strictly prohibited. If you have=
 received this eMail in error, then please delete this eMail.
________________________________

