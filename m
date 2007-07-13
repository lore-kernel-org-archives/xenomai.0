Content-Type: text/plain; charset="us-ascii"
Date: Fri, 13 Jul 2007 15:37:50 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
In-Reply-To: <1184323717.6014.248.camel@domain.hid>
Message-ID: <20070713133750.277260@domain.hid>
MIME-Version: 1.0
References: <20070713092440.281340@domain.hid> <469746E9.6050503@domain.hid>	
	<20070713094331.281350@domain.hid> <1184323717.6014.248.camel@domain.hid>
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error compiling linux 2.6.22 or 2.6.22.1
	with	adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Philippe Gerum wrote:
> On Fri, 2007-07-13 at 11:43 +0200, Karl Reichert wrote:
> 
> > But I tried with adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch. Where can I
> get ipipe-2.6.22-i386-1.8-05? It's not listed on the FTP! I can only find
> ipipe-2.6.20-i386-1.8-05 (which is for 2.6.20 kernels).
> 
> The final I-pipe patch for 2.6.22 is currently undergoing survival test
> under extremely unreasonable load on by boxen. Please wait.
> 
> -- 
> Philippe.
> 
So I took adeos-ipipe-2.6.20-i386-1.7-03.patch (xenomai 2.3.1) with linux2.6.20.11 and linux2.6.20.15 but with both the same problem. Patching and preparing works fine as make menuconfig does, but when compiling make says:
[...]
AS arch/i386/kernel/entry.o
arch/i386/kernel/entry.S: Assembler messages:
arch/i386/kernel/entry.S:270: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:347: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:477: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:520: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:534: invalid character '_' in mnemonic
[...]

What's the case here now? I installed all dependencies.

Karl
-- 
von Karl Reichert

GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail

