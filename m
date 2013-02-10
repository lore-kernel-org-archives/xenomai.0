Message-ID: <5117AD5A.1080504@xenomai.org>
Date: Sun, 10 Feb 2013 15:23:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
	<50F3DD9A.9050306@gmail.com>
In-Reply-To: <50F3DD9A.9050306@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <stefan.roese@gmail.com>
Cc: mfornero@aanddtech.com, Xenomai@xenomai.org

On 01/14/2013 11:27 AM, Stefan Roese wrote:

> Hi Matthew,
> 
> On 01/12/2013 06:21 PM, mfornero@aanddtech.com wrote:
>>    I'm looking for recommendations on how to best port ipipe support to a
>>    new ARM SoC. The SoC has started to show up in mainline, but many of
>>    the features haven't made it over yet. Xilinx maintains a git repo
>>    here:
>>
>>    git://git.xilinx.com/linux-xlnx.git
>>
>>    And it look like they've synced with mainline 3.6
>>
>>    The two approaches I've considered were either trying to port ipipe to
>>    stock 3.6 (or at least the generic and ARM bits) or trying to backport
>>    the Xilinx code to 3.5.3. I started with the later approach, but some
>>    changes to the common clock architecture between 3.5 and 3.6 make this
>>    somewhat difficult.
>>
>>    Any thoughts on which approach would be better?
> 
> I'm also working on supporting Zynq in I-pipe. My approach was to use
> the Xilinx 3.5.0 code version (git tag "xilinx-14.3-build2"). And port
> the I-pipe version from Gilles git repository to it. I still need to do
> some cleanup then I can send you the latest version.


Hi Stefan, Matthew,

I do not know if you managed to get the I-pipe working on Zynq. 
You may have missed it, but it may be very important for debugging the 
issues you encounter with the I-pipe port on Zynq, printk from primary 
domain in I-pipe patches for Linux 3.4 and 3.5 does not work. So, if 
you are debugging with printk, it may lead you to false conclusions. 
You should apply the following patch (it has been pushed in the 
for-core-3.5.7 branch of the ipipe-gch git):

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3b86167..f77ef11 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -440,7 +440,7 @@ void __ipipe_ipis_alloc(void)
 		return;
 
 	/* __ipipe_first_ipi is 0 here  */
-	ipi_nr = IPI_IPIPE_FIRST + IPIPE_LAST_IPI;
+	ipi_nr = IPI_IPIPE_FIRST + IPIPE_LAST_IPI + 1;
 
 	for (virq = IPIPE_IPI_BASE; virq < IPIPE_IPI_BASE + ipi_nr; virq++) {
 		_virq = ipipe_alloc_virq();



-- 
                                                                Gilles.

