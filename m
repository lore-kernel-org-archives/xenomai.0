Message-ID: <5355728F.80507@xenomai.org>
Date: Mon, 21 Apr 2014 21:33:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5352BA1D.7070707@xenomai.org> <5355705B.5010604@steinkuehler.net>
In-Reply-To: <5355705B.5010604@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Pre/Post patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/21/2014 09:24 PM, Charles Steinkuehler wrote:
> On 4/19/2014 1:02 PM, Gilles Chanteperdrix wrote:
>>
>> I am currently validating the I-pipe patch for Linux 3.14 on armv4 and
>> armv5, but it should already work for armv6 and armv7 processors, it is
>> available as a branch for-ipipe-3.14.0 in ipipe-gch git. Could you have
>> a look at it on BeagleBone, Raspberry and Zynq? For the SOCs supported
>> by mainline, please simply send patches to the for-ipipe-3.14.0 branch.
> 
> I'm still working on building a kernel for the BeagleBone Black.
> 
> I tried the standard method of generating the ipipe patch and applying
> it to the BeagleBone patched kernel source.  The first problem I
> encountered was an unknown architecture error for the
> net/ethernet/cadence/at91_ether.c driver.  I edited the genpatches.sh
> script and forced this to x86 (since I'm pretty sure I don't need this
> driver for the BeagleBone).

Well, at91 are arms, will fix.

> Note the patch set for the 3.14 BeagleBone
> kernel is mostly device-tree changes and about four fairly simple
> back-ported fixes.
> 
> The next problem comes when building the kernel, I get an undefined
> warning from the raid456.ko module (see below).  I'll keep plugging
> away, but any advice would be appreciated.

probably something wrong with the configuration. Why do you need raid 4,
5, 6 anyway? In a first step, you should work with a standard
configuraiton, such as omap2plus_defconfig, or better, if you have it,
with a minimal configuration suited for your board, which will avoid:

> (...)
>   MODPOST 1950 modules

and build a kernel in just a few minutes.

-- 
                                                                Gilles.

