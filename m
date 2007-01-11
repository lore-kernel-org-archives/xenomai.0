Message-ID: <45A5F8B1.2010002@domain.hid>
Date: Thu, 11 Jan 2007 09:43:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Nocow patch.
References: <45A52B04.1010706@domain.hid>
	<200701110838.19182.niklaus.giger@domain.hid>
In-Reply-To: <200701110838.19182.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Am Mittwoch, 10. Januar 2007 19:05 schrieb Gilles Chanteperdrix:
> 
>>Hi,
> 
> <..>
> 
>>This was run on x86, but need further testing before inclusion.
> 
> I wanted to give it a try on my PPC board. But trying to apply it (on a  Linxu 
> 2.6.19.1 kernel patched with 
> ksrc/arch/powerpc/patches/adeos-ipipe-2.6.19-ppc-1.5-01.patch gave me the 
> error
> 
>>Hunk #1 succeeded at 652 (offset -2 lines).
>>patching file include/asm-i386/pgalloc.h
>>Reversed (or previously applied) patch detected!  Assume -R? [n]
> 
> Same problem with ioremap.c.
> Is there a problem or did I apply it against the wrong kernel?

It is a patch for x86 only for now, other architectures will be
implemented when it is stable on x86.

-- 
                                                 Gilles Chanteperdrix

