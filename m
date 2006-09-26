From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
Date: Tue, 26 Sep 2006 20:56:30 +0200
References: <J67G6W$AFC4CDFDA31A148D03B70B64BA5713E3@domain.hid>
	<1159287029.5084.149.camel@domain.hid>
	<4519553A.3040109@domain.hid>
In-Reply-To: <4519553A.3040109@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262056.30673.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Am Dienstag, 26. September 2006 18:28 schrieb Wolfgang Grandegger:
> Philippe Gerum wrote:
> > On Tue, 2006-09-26 at 16:56 +0200, gilles.chanteperdrix wrote:
> OK, but in general, soft-float emulation should be used on systems
> without FPU and this is even more important for real-time. This is a
> tool chain issue. Niklaus, what tool chain are you using?
>
In my .config I have 
MATH_EMULATION=y

The toolchain is gcc-3.4.4-glibc-2.3.5/powerpc-405-linux-gnu built using Dan 
Kegel crosstool (Version 0.42 if I remember exactly).

Shall I switch to another one?

-- 
Niklaus Giger

