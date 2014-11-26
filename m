From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 26 Nov 2014 10:22:25 -0500
Message-ID: <20141126152225.GF24110@csclub.uwaterloo.ca>
References: <9BA84827B30CBE4996725F98F7DC9123428F6675@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC9123428F6675@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] ipipe-arm for kernel 3.12 on ls1021
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 26, 2014 at 03:09:04PM +0000, Hänel-Baas, Alexander wrote:
> I need a ipipe-arm patch for kernel-3.12.0.
> 
> I have the layerscape ls1021atwr from freescale here that comes with yocto sdk and a 3.12.0 freescale git kernel.
> Bitbake the kernel /rootfs is worked already.
> 
> So the next step is: make xenomai on it!
> I found the ipipe-raw/ipipe-3.12.0 tree on your git server, make a diff to vanilla 3.12.0 kernel and get my ipipe-3.12.0.patch.
> 
> Now I patched the freescale git kernel  with my ipipe-3.12.0 patch with only three errors:
> 
> arch/powerpc/include/asm/qe_ic.h -> file not found
> arch/powerpc/sysdev/qe_lib/qe_ic.c -> file not found
> arch/powerpc/include/asm/qe_ic.h -> file not found
> 
> Powerpc is not layerscap, so I comment out these 3 patches.
> 
> During the compilation i get an error:
> undefined reference to `__ipipe_pin_range_globally'

Do you have LPAE enabled?  Why yes you do.  Don't do that.  It doesn't
work (yet).  Turn off LPAE and that should solve that compile problem,
and also give you a chance of a working system.

> I found an email (22 Aug 2014) that gives me the solution:
> In arch/arm/mm/fault.c  i moved the #endif at bottom of the file to above the #ifdef CONFIG_IPIPE
> 
> And finally I can compile the kernel and dtb.
> 
> But after u-boot load the kernel I see only
> Starting kernel...
> 
> And nothing is happened.
> 
> My question:
> What can I do to see why the kernel isn't starting and make the patch to work?
> 
> I attached my created ipipe-3.12.0 patch and the kernelconfig.

You can not boot with IPIPE and LPAE at the same time for now.  Work is
in progress on this, but it isn't done yet.

-- 
Len Sorensen

