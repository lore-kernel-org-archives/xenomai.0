Date: Mon, 1 Jun 2015 18:25:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150601162544.GA30861@hermes.click-hack.org>
References: <DUB121-W42011D0A38E8540A396B2C81C80@phx.gbl>
 <20150531063048.GA4433@hermes.click-hack.org>
 <DUB121-W243EAFB481F0A0900E76B081B60@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DUB121-W243EAFB481F0A0900E76B081B60@phx.gbl>
Subject: Re: [Xenomai] smp.c error on rc4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mobin Motallebizadeh <mobin.seven@live.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Jun 01, 2015 at 03:46:07PM +0000, mobin Motallebizadeh wrote:
> 
> 
> > Date: Sun, 31 May 2015 08:30:48 +0200
> > From: gilles.chanteperdrix@xenomai.org
> > To: mobin.seven@live.com
> > CC: xenomai@xenomai.org
> > Subject: Re: [Xenomai] smp.c error on rc4
> > 
> > On Sat, May 30, 2015 at 07:09:15PM +0000, mobin Motallebizadeh wrote:
> > > I'm getting this error in making kernel( Xenomai 3.0 rc4 - ipipe patch 3.16 - kernel 3.16 - target: armv7)
> > > arch/arm/kernel/smp.c: In function ‘ipi_timer’:arch/arm/kernel/smp.c:531:2: error: implicit declaration of function ‘’ [-Werror=implicit-function-declaration]cc1: some warnings being treated as errorsscripts/Makefile.build:257: recipe for target 'arch/arm/kernel/smp.o' failedmake[1]: *** [arch/arm/kernel/smp.o] Error 1make[1]: *** Waiting for unfinished jobs....Makefile:901: recipe for target 'arch/arm/kernel' failedmake: *** [arch/arm/kernel] Error 2
> > > WHY? 		 	   		  
> > 
> > 3.16 is not a version of I-pipe patch, it is the version of the
> > Linux kernel it applies to.
> > armv7 is vague, there are a lot of different armv7 arm cores and
> > processors.
> > The name of the function which is implicitly declared is missing.
> > And the answer to "why", is certainly because you are using kernel
> > configuration options that nobody else uses. But you do not provide
> > that information either.
> > 
> > So, given this characteristic lack of information, I am afraid
> > it is impossible for us to answer your question.
> > 
> > -- 
> > 					    Gilles.
> 
> I have attached my config file.thanX
> 
>  		 	   		  
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: rpi_xen.config
> Type: application/octet-stream
> Size: 49797 bytes
> Desc: not available
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150601/9648bd84/attachment.obj>

That is less information than what I asked, and would be needed to
check the issue you have in details, but I can already answer you,
see:

http://xenomai.org/embedded-hardware/#Supported_SoC

-- 
					    Gilles.

