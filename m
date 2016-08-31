References: <2016083113134616155361@empower.cn>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fa351b72-f4c0-0232-f2b2-64abd3253cfb@xenomai.org>
Date: Wed, 31 Aug 2016 09:47:43 +0200
MIME-Version: 1.0
In-Reply-To: <2016083113134616155361@empower.cn>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Two questions about Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "liufei@empower.cn" <liufei@empower.cn>, xenomai <xenomai@xenomai.org>

On 08/31/2016 07:14 AM, liufei@empower.cn wrote:
> Dear all:
>   Recently,i prepared to using Xenomai 3 in our zedboard considering to port a RT-PREEMT  embedded application.There are two questions that i am not sure about.
> 
>   First,The Xenomai 3 architecture says that Xenomai 3 can run natively over mainline Linux kernels.If like that,the mainline kernel can be supplemented by the RT-PRERMPT patch.I want to know whether this means that Xenomai 3 can be patched to a RT-PREEMPT kernels.If yes,is there a version limit in PT-PREEMPT?If no,how to install Xenomai 3 to make that?If it solves, can the PT-PREEMT embedded application work normally?

The RTOS _APIs_ Xenomai provides can run indifferently over a dual
kernel or native system, as stated here:
http://xenomai.org/start-here/#What_is_Xenomai_about

Whether you may want to consider using a dual kernel or native system is
explained here:
http://xenomai.org/start-here/#Preparation_checklist

Some projects even combine a dual kernel system with preempt-rt, by
merging the interrupt pipeline and preempt-rt kernel patches.

A dependency on a particular kernel release exists when one uses
Xenomai's dual kernel support which is named "Cobalt" (alone, or side by
side with preempt-rt). The interrupt pipeline (I-pipe) patch is
logically part of such support, although it is maintained in a separate
GIT tree.

With Xenomai 3, all non-POSIX RTOS APIs are implemented in user-space,
so there is no particular dependency on a kernel release starting from
v3.10 onward, which is the earliest version officially supported by
Xenomai 3.

> 
>   Second,actually our zedboard used Xenomai 2.x in the past,so it has some Xenomai 2.x embedded application.If i work the first problem out,that kernels can support the old Xenomai 2.x embedded application or not?

You may want to have a look to this migration guide to estimate the
effort: http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

-- 
Philippe.

