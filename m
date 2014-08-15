From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Fri, 15 Aug 2014 06:47:30 +0000
Message-ID: <e3bdea6dcdb84852972a720789331cb2@CVEX13.valentin-carl.de>
References: <mailman.1.1408010401.9958.xenomai@xenomai.org>
In-Reply-To: <mailman.1.1408010401.9958.xenomai@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] access SPI and DMA hardware from application
 ("external abort...")
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

meanwhile I have solved the issue on my own. I tried to access the SPI1 HW =
with traditional mmap approach from user space and had the same problem unt=
il I saw that I had to start the whole SPI1 module by setting a specific co=
ntrol bit to enable its clock. Sorry for posting this, but I was really puz=
zled then. I guess it will also be possible to access the hw registers of t=
he SPI with the xenomai rtdm io user mapping now...

Kind regards,
Peter Reitinger

