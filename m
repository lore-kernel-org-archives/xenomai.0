Date: Mon, 27 Oct 2014 19:47:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141027184721.GA17539@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C674EE64@SINTEFEXMBX05.sintef.no>
 <20141027133114.GB13005@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C674F1D1@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C674F1D1@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] Compiling drivers for Xenomai 2.6.4 on Beaglebone
	Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Oct 27, 2014 at 04:40:02PM +0000, Terje Frøysa wrote:
> Hello Gilles,
> Thanks for your quick reply!
> 
> I fully understand that you answer for pages outside your "patch".
> However, I downloaded Xenomai 2.6.4 from you sourcery:
> http://download.gna.org/xenomai/stable/latest/
> 
> When trying to apply the recipes in http://xenomai.org/installing-xenomai-2-x/
> I run into problems as the xenomai-2.6.4/ksrc/arm/patches contains more than the one patch ("adeos-ipipe-2.6.20-arm-*").
> It has also subdirectories with pre/post patches for Beaglebone, RPi and other SoC's not mentioned in your receipe.
> 
> Although I would like to rely solely on the Xenomai recipe I have to take advices from others to try get it all right.

These additional patches are documented in
ksrc/arch/arm/patches/README, I referenced that file in xenomai
2.6.4 to README.INSTALL, but I guess they should also be referenced
in the website instructions.

> 
> I guess I just have two questions for you:
> 
> Q1. Is the correct absolute path to the Xenomai includefiles: /usr/xenomai/include ?

It depends on the options you pass to xenomai user-space configure
script, notably --prefix and --includedir, and of the DESTDIR
variable you pass to the "make install" command, when
cross-compiling.

> 
> Q2. What is the correct absolute path to the file:  linux/ipipe.h ?

It depends on the path where you compiled Linux. This file resides
in Linux sources, in the include subdirectory.

-- 
					    Gilles.

