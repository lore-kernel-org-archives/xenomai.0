Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Feb 2008 10:50:29 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD3816B@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Atomic 64 bit write access on PCIe device
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

M. Koehrer wrote:
>perhaps this issue is off-topic, but I expect that there are many
experts on that issue reading the Xenomai list...
>I have a Core2Duo Intel CPU (32 bit mode) and a proprietary PCI Express
I/O board plugged in.
>This PCI Express I/O board has some 64 bit registers that are mapped
into address space via mmap.
>Now, I want to write atomically (one PCIe access) to one of the 64 bit
registers.
>Unfortunately, the Intel CPUs does not have an atomic 64 bit write
operations when running the CPU in 32 bit mode.

I'm no expert, but did you tried already using FP instructions, which is
a common
trick to make use of 64 bits I/O in code optimization (before SIMD era).

How about the following:

void do_write64(void *p, unsigned long long x)
{
        volatile union {
                unsigned long long ull;
                double d;
        } u;

        u.ull =3D x;
        *(volatile double *)p =3D u.d;
}

Disassemble that code, you should see some fldl and fstpl.
--=20
Stephane

