Message-ID: <53B54D77.3020808@xenomai.org>
Date: Thu, 03 Jul 2014 14:32:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53B512BB.9040908@ma-info.de>
In-Reply-To: <53B512BB.9040908@ma-info.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on PhyCore/Board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frede Florian <florian.frede@ma-info.de>, xenomai@xenomai.org

On 07/03/2014 10:22 AM, Frede Florian wrote:
> Hello,
> 
> We started a new real time project. For this project we decided to 
> compare the PREEMPT_RT and Xenomai on our future hardware. For this we 
> got two developer board from Phytec.
> 
>   * Linux-phyCORE-AM335x-Kit
>     (https://www.osadl.org/Profile-of-system-in-rack-7-slot-5.qa-profile-r7s5.0.html)
>   * phyBOARD-Wega-AM335x
>     (https://www.osadl.org/Profile-of-system-in-rack-8-slot-8.qa-profile-r8s8.0.html)
> 
> Now I have the Problem that I can not compile a running Linux with 
> Xenomai on this board. The supplier delivers patches for Kernel 3.2 for 
> the board  and on the linked page I get patches for the Kernel 3.12.19.
> 
>   * Is there a possibility to run Xenomai on one on this kernel versions?
>   * I am really no expert in writing patches for a Kernel so I need some
>     help or a HowTo. Where can I find that help?
> 
> Thanks for helping a Xenomai beginner.

It is sometimes easier to port the board-specific patches (in your case,
the ones provided by Phytec) to a kernel already supported by Xenomai,
than to port the I-pipe patch (the patch used by Xenomai) to a kernel
not already supported. What makes your situation even more complicated,
is that the I-pipe patches for mainline Linux do not support the AM335x
processor, people working with this processor seem to prefer working
with kernel forks, so the patches for AM335x only exist for one of these
forks (namely the Robert Nelson repository).

So, I would suggest:
- porting the Phytec patches to a recent kernel supported by Xenomai,
like 3.10.32 or 3.14;
- merge with the I-pipe patch using git, there should not be conflicts,
as the I-pipe patch and the board specific patches should not touch the
same files;
- port Xenomai to this new kernel, using ideas from the AM335x patches
in Xenomai repository.

For the last step, you can use the help found in the following document:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

You will find AM335x specific patches (for the Robert Nelson fork) in
the directory ksrc/arch/arm/patches/beaglebone in Xenomai sources, with
instructions on how to apply them to this fork in
ksrc/arch/arm/patches/README.

For general help about Xenomai, you can start here:
http://www.xenomai.org/index.php/Getting_Started

-- 
                                                                Gilles.

