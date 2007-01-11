From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Nocow patch.
Date: Thu, 11 Jan 2007 08:38:15 +0100
References: <45A52B04.1010706@domain.hid>
In-Reply-To: <45A52B04.1010706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701110838.19182.niklaus.giger@domain.hid>
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

Am Mittwoch, 10. Januar 2007 19:05 schrieb Gilles Chanteperdrix:
> Hi,
<..>
> This was run on x86, but need further testing before inclusion.
I wanted to give it a try on my PPC board. But trying to apply it (on a  Linxu 
2.6.19.1 kernel patched with 
ksrc/arch/powerpc/patches/adeos-ipipe-2.6.19-ppc-1.5-01.patch gave me the 
error
> Hunk #1 succeeded at 652 (offset -2 lines).
> patching file include/asm-i386/pgalloc.h
> Reversed (or previously applied) patch detected!  Assume -R? [n]
Same problem with ioremap.c.
Is there a problem or did I apply it against the wrong kernel?

Best regards

-- 
Niklaus Giger

