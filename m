Date: Mon, 23 Mar 2015 10:53:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150323095340.GA5299@hermes.click-hack.org>
References: <CAKC9m6dkbD2iwi62YP_O2wRiOUHNp17eoMLYP6okg=PQ0OgjxQ@mail.gmail.com>
 <20150320181308.GA27775@hermes.click-hack.org>
 <CAKC9m6eFoRrFj_QteNeJmcbi+eir0SGzwoCTd2TVzPVuqDsiCQ@mail.gmail.com>
 <20150321131111.GA20203@hermes.click-hack.org>
 <20150321132130.GC20203@hermes.click-hack.org>
 <CAKC9m6ceEi593XX04-dLfQaVYHmQHmwe75oC+d4Qu-t9q1G9_A@mail.gmail.com>
 <550FD6CA.7080407@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <550FD6CA.7080407@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

On Mon, Mar 23, 2015 at 10:03:06AM +0100, Jan Kiszka wrote:
> On 2015-03-23 07:01, Hongfei Cheng wrote:
> > Thank you for the terrific info and timely advice. I'll proceed as you
> > suggested and report back progress regularly.
> 
> Another tip: it can we useful to do early bring-up on QEMU basis. It is
> already in a pretty decent state regarding aarch64, Linaro is hacking on
> it, and vendors like Xilinx do their virtual prototyping on that basis
> as well (in the latter case for the upcoming MPSoC). Probably - I didn't
> try it out myself yet, only planning to do these days - the gdb
> interface also works fine, thus will give you source level debugging.

I would not recommend that, as it adds the debug tools and emulator
bugs, and removes some real silicon bugs, as well as adding the
temptation to rely too much on the debug tools and not see the
forest for the tree. If you really really want to use gdb, I would
rather recommend JTAG (but it still has some of the issues of QEMU).

Besides, developing on real hardware is much less painful on embedded
hardware than on x86 hardware because: 

- embedded hardware usually has a serial console, which makes things
real easy (when everything fails, you can output characters to the
serial console in a brute force polling manner) 

- embedded hardware usually does not take forever to initialize its
firmware (no BIOS with stupid timeouts waiting for not unplugged
peripherals). Typically, u-boot is slower to execute in qemu than on
real hardware (if you want to execute u-boot in qemu).

So, your mileage may vary.

Something I also forgot to mention is the FPU support: keep that for
the end but you will need it to run the latency test. So, I would
recommend compiling an integer-only simplified latency test to
validate the fault/syscall interception. Then add FPU support.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150323/818dd0a5/attachment.sig>
