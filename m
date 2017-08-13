References: <CAAaH=QEBiyiRuW5NTHuAKMcAB1yYLErOTsdB5b35GeiSKgOH4g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ca41ec31-76eb-567b-0d9b-8019426302f7@xenomai.org>
Date: Sun, 13 Aug 2017 18:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAAaH=QEBiyiRuW5NTHuAKMcAB1yYLErOTsdB5b35GeiSKgOH4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error while generating zImage of Xenomai on UDOO board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mohamed atef <mohamedatefmohamed95@gmail.com>, xenomai@xenomai.org

On 08/13/2017 12:01 PM, mohamed atef wrote:
> Hi,
> 
> I'm currently working on UDOO Quad board with 4 IMX6 multicore processor. I
> found a linux kernel on UDOO github and am trying to adopt Xenomai to it.
> It's based on linux 3.14.56 which has no i-pipe patch yet, so I followed
> the patch of linux kernel 3.14.44 and modified it until my kernel is
> patched and prepare_kernel ran successfully.
> 
> After that, I continued following Xenomai instructions, so I configured the
> kernel using uddo_quad_dual_defconfig file and the Makefile was generated
> successfully.
> 
> At the last step where I try to build the zImage and modules, the operation
> seems to enter an infinite loop. It keeps typing:
> 
> 
> *GEN
> /home/test/Desktop/Atef/Xenomai/linux_kernel-3.14-1.0.x-udoo/building_here/linux/Makefilescripts/kconfig/conf
> --silentoldconfig Kconfig*
> and this lasts forever as shown in the attached screenshot. I tried to
> search for this problem, but I couldn't reach anything, neither the reason
> nor the solution.
> 
> Anyone know why this happen or how to solve it?
> 

This question is also off-topic on the Xenomai mailing list. As often, 
Google has the answer it seems:
http://lmgtfy.com/?q=linux+kconfig+gen+infinite+loop+udoo

First match points at a broken udoo meta layer for Yocto:
https://lists.yoctoproject.org/pipermail/yocto/2016-January/028192.html

-- 
Philippe.

