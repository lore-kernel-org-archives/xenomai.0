From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
Date: Thu, 28 Sep 2006 08:02:34 +0200
References: <J67G6W$AFC4CDFDA31A148D03B70B64BA5713E3@domain.hid>
	<451A4ED8.7040708@domain.hid> <451AC0B8.9010204@domain.hid>
In-Reply-To: <451AC0B8.9010204@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609280802.34560.niklaus.giger@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Am Mittwoch, 27. September 2006 20:19 schrieb Wolfgang Grandegger:
<..>
> > I'm now a bit puzzled why a FP exception occurs. What happens if you
> > disable MATH_EMULATION
> > in your kernel (that's what I normally have). It will try the latency
> > test on my Walnut-Board with CONFIG_XENO_OPT_DEBUG asap.
>
> I'm unable to reproduce the problem of our Sycamore board with Linux
> 2.6.14:
Can I you send me (maybe offline) your .config. I will also rebuild my rootfs 
from scratch. At work I have also a walnut board where I could run the tests.
>    CPU:   AMCC PowerPC 405GPr Rev. B at 333.333 MHz (PLB=133, OPB=66,
>           EBC=66 MHz)
>           Internal PCI arbiter enabled, PCI async ext clock used
>           16 kB I-Cache 16 kB D-Cache
>    Board: Sycamore - AMCC PPC405GPr Evaluation Board
>
Thanks for trying to reproduce the problem.

-- 
Niklaus Giger

