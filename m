From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20070713145756.212990@domain.hid>
References: <20070713092440.281340@domain.hid> <469746E9.6050503@domain.hid>
	<20070713094331.281350@domain.hid> <1184323717.6014.248.camel@domain.hid>
	<20070713133750.277260@domain.hid> <1184335303.6014.268.camel@domain.hid>
	<20070713143914.212980@domain.hid> <1184338266.6014.276.camel@domain.hid>
	<20070713145756.212990@domain.hid>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 17:05:49 +0200
Message-Id: <1184339149.6014.283.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] error compiling linux 2.6.22 or 2.6.22.1
	with	adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-07-13 at 16:57 +0200, Karl Reichert wrote:
> Philippe Gerum wrote:
> > On Fri, 2007-07-13 at 16:39 +0200, Karl Reichert wrote:
> > > Philippe Gerum wrote:
> > > > On Fri, 2007-07-13 at 15:37 +0200, Karl Reichert wrote:
> > > > > Philippe Gerum wrote:
> > > > > > On Fri, 2007-07-13 at 11:43 +0200, Karl Reichert wrote:
> > > > > > 
> > > > > > > But I tried with adeos-ipipe-2.6.22-rc6-i386-1.9-00.patch. Where
> > can
> > > > I
> > > > > > get ipipe-2.6.22-i386-1.8-05? It's not listed on the FTP! I can
> > only
> > > > find
> > > > > > ipipe-2.6.20-i386-1.8-05 (which is for 2.6.20 kernels).
> > > > > > 
> > > > > > The final I-pipe patch for 2.6.22 is currently undergoing survival
> > > > test
> > > > > > under extremely unreasonable load on by boxen. Please wait.
> > > > > > 
> > > > > > -- 
> > > > > > Philippe.
> > > > > > 
> > > > > So I took adeos-ipipe-2.6.20-i386-1.7-03.patch (xenomai 2.3.1) with
> > > > linux2.6.20.11 and linux2.6.20.15 but with both the same problem.
> > Patching and
> > > > preparing works fine as make menuconfig does, but when compiling make
> > says:
> > > > > [...]
> > > > > AS arch/i386/kernel/entry.o
> > > > > arch/i386/kernel/entry.S: Assembler messages:
> > > > > arch/i386/kernel/entry.S:270: invalid character '_' in mnemonic
> > > > > arch/i386/kernel/entry.S:347: invalid character '_' in mnemonic
> > > > > arch/i386/kernel/entry.S:477: invalid character '_' in mnemonic
> > > > > arch/i386/kernel/entry.S:520: invalid character '_' in mnemonic
> > > > > arch/i386/kernel/entry.S:534: invalid character '_' in mnemonic
> > > > > [...]
> > > > 
> > > > Disable CONFIG_PARAVIRT, or upgrade to 2.6.20-1.8-05. The latest patch
> > > > for 2.6.22 is now available.
> > > > 
> > > Thanks a lot, setting this to no solved the issue. Where do I get the
> > patch? I can't find it in the online SVN (web access).
> > > 
> > 
> > http://download.gna.org/adeos/patches/v2.6/i386/older/adeos-ipipe-2.6.20-i386-1.8-05.patch
> > http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-i386-1.9-00.patch
> > 
> > > > > 
> > > > > What's the case here now? I installed all dependencies.
> > > > > 
> > > > > Karl
> > > > -- 
> > > > Philippe.
> > > > 
> > > Karl
> > -- 
> > Philippe.
> > 
> Thank you very much. Maybe this hint about paravirtualization should be added to Xenomai FAQ. Otherwise somebody else could get the same issues.

Somebody did face this issue already. You may find the report and the
resolution into the mail archive.

-- 
Philippe.



