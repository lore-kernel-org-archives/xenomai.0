Message-ID: <4FABFACE.7030904@domain.hid>
Date: Thu, 10 May 2012 19:28:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1466485845.144436688.1336656387004.JavaMail.root@domain.hid>
In-Reply-To: <1466485845.144436688.1336656387004.JavaMail.root@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: aubin.rebillat@domain.hid
Cc: xenomai@xenomai.org

On 05/10/2012 03:26 PM, aubin.rebillat@domain.hid wrote:
> Hello, 
> 
> I am trying to port Xenomai on the TS-7553 SBC from Technologic systems, based on the ECONA CNS2132 (STAR8132) from Cavium networks (250 MHz arm922t).
> A Linux kernel is available for this board, version 2.6.24.4, which is running fine.
> I patched this kernel with adeos-ipipe-2.6.24-arm-1.9-01.patch and I implemented all the IPIPE code for the CNS2132 and everything is compiling and booting fine.

Note that the following page:
http://www.openembedded.org/wiki/TS-7500

Proposes patches for linux 2.6.35, which is really, really, really more
current than 2.6.24, and for which an I-pipe patch also exists.

I mean, with 2.6.24, you may find bugs we do not even remember, because
they were fixed such a long time ago.

-- 
					    Gilles.

