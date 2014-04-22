Message-ID: <535640F8.1040805@xenomai.org>
Date: Tue, 22 Apr 2014 12:14:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5355F933.20200@easyarm.com>
In-Reply-To: <5355F933.20200@easyarm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] porting xenomai to 3.2 kernel using SOC Ti Am3359
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vattipalli <praveen.v@easyarm.com>
Cc: xenomai@xenomai.org

On 04/22/2014 07:08 AM, vattipalli wrote:
> hi, I am working on Ti Am3359 processor with linux-3.2 kernel. I am
> trying to port Xenomai. I have applied ipipe-core-3.2.21-arm-4.patch
> patch, and compiled the kernel. But when booting uImage it hanged at
> 
> Uncompressing Linux... done, booting the kernel. I could not see any
> console after this.

The I-pipe patch for Linux 3.2 does not support Am33xx processors. And
in fact has known bugs, so is not recommended at all. We have more
recent patches for Linux 3.8 and Linux 3.10. See the help for beaglebone
in ksrc/arch/arm/patches/README in Xenomai 2.6.3 sources.


> But the above patch   Support for CSR SiRFSoC ARM
> Cortex A9 Platform.

I do not understand this sentence.

> Could i get any patch for ARM Cortex A8
> Platform(Ti AM3359) for linux-3.2 kernel.

No.

-- 
                                                                Gilles.

