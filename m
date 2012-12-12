Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
Date: Wed, 12 Dec 2012 07:54:04 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE9848C4-D19F-4628-8047-5E67A667A2E9@mah.priv.at>
References: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
Subject: Re: [Xenomai] RT GPIO with Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Poli <polimarco@gmail.com>
Cc: xenomai@xenomai.org

not strictly a Xenomai issue, but I'd completely bypass the kernel GPIO =
support and manipulate the GPIO registers directly - they are all memory =
mapped=20

some inspiration here: =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/refs/heads/rtos-integratio=
n-preview1:/src/hal/drivers/hal_gpio.c

this runs from a userland thread but kernel shouldnt be much different

-m

Am 11.12.2012 um 21:32 schrieb Marco Poli:

> Hello all!
>=20
>=20
>=20
> I would like to apologize if this is a somehow recurrent or previously =
addressed question, but all the answers I got on the topic were =
inconclusive, at least for someone with so far minimal experience with =
Xenomai.
>=20
> Raspberry Pi patched kernels have GPIO and GPIO generated-interrupts =
working and exported to userland, but it is unclear to me if the =
in-kernel drivers are able to deal with RT applications in primary mode, =
or would it be necessary to make changes to the Linux Kernel Drivers or =
new GPIO RTDM drivers to be able to access GPIO from a RT application in =
primary mode? Maybe Analogy?
>=20
> Is it possible to use these sort of Linux Kernel GPIO drivers and =
still be able to have my application not leave primary mode? Is there =
some source of documentation someone can point me to that might be of =
assistence?
>=20
>=20
> Thanks in advance.
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


