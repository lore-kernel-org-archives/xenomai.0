Message-ID: <5374C28F.2060902@xenomai.org>
Date: Thu, 15 May 2014 15:35:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF9A29EB.3436%donald.poole@swri.org>
In-Reply-To: <CF9A29EB.3436%donald.poole@swri.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] v2.6.3 ARM I-Pipe Patch Kernel Version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Poole Jr, Donald R." <donald.poole@swri.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/15/2014 03:23 PM, Poole Jr, Donald R. wrote:
> All,
>
> I’m using the latest version of Xenomai (v2.6.3) to path the
> HardKernel ODROID-U3 kernel, but I was wondering which 3.8.13 version
> of the kernel the I-Pipe patch was created from. Specifically, which
> sub-minor version of the 3.8.13 kernel (e.g. 3.8.13.1, 3.8.13.2,
> etc.)   Currently, the ODROID-U3 kernel is at version 3.8.13.21, but
> the current patch, ipipe-core-3.8.13-arm-3.patch, does not patch
> against the 3.8.13.21 kernel.

The 4 version numbers correspond to the kernels released by Canonical, 
if I understood correctly. The I-pipe patch for 3.8.13 is for the 3.8.13 
released before Canonical took over the maintenance.

>
> I realize from earlier discussions regarding this SoC (Samsung Exynos
> 4412) that Xenomai does not currently support this, so my goal is to
> create a port that does. My plan was to try and get the I-pipe patch
> able to patch my kernel, and then go back through the porting guide
> to make sure all of the timers, clocks, interrupts as taken care of
> for the Cortex-A9 case.  Is this a good approach?

If you have the choice of the kernel, please choose a more recent one, 
like 3.14 or 3.10.

-- 
					    Gilles.

