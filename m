References: <CAKKWdtfpTs1O5b-ihm2JP8vSm7KxZn7YAaOGO6Zy3H7we=SAYw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9da91ef1-1f12-3e2f-1857-d1552bcccf88@xenomai.org>
Date: Wed, 31 May 2017 11:10:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAKKWdtfpTs1O5b-ihm2JP8vSm7KxZn7YAaOGO6Zy3H7we=SAYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] vortex86dx
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, xenomai@xenomai.org

On 05/30/2017 03:02 PM, ali hagigat wrote:
> I use xenomai for vortex86dx and cpc307 board. the kernel hangs. why?
> 

No idea. A bug maybe?

> 
> Linux version 2.6.30 (am@localhost.localdomain) (gcc version 4.9.3
> (Buildroot 2016.05) ) #6 Tue May 30 12:41:26 IRDT 2017

This kernel is 8 years old. Although people are trying hard to be
helpful, I'm unsure anyone have cycles free to invest in archaeological
matters at the moment. You need to understand that maintaining Xenomai
and the interrupt pipeline has been, and is still quite a significant
work, enough for declining to help in setting up preposterously outdated
configurations.

> KERNEL supported cpus:**************************************
>   Intel GenuineIntel*      Please select boot device:      *
>   AMD AuthenticAMD  ****************************************
>   NSC Geode by NSC  * HDD:PM-Fastwel Embedded ATA Fla      *
>   Cyrix CyrixInstead* USB:JetFlash Transcend               *
>   Centaur CentaurHauls<Enter Setup>                        *
>   Transmeta GenuineTMx86                                   *
>   Transmeta TransmetaCPU                                   *
>   UMC UMC UMC UMC   *                                      *
> CPU: vendor_id 'Vortex86 SoC' unknown, using generic init. *
> CPU: Your system may be unstable.                          *

Regardless of any additional issue with the interrupt pipeline, the
basic situation does not look good. Does it?

> I-pipe 2.4-05: pipeline enabled.
-rw-r--r-- 1 rpm rpm 329448 Jul 19  2009 adeos-ipipe-2.6.30-x86-2.4-05.patch

Unless you misconfigured your kernel with respect to processor support,
it seems that the CPU on your PC/104 module has no TSC, so this means
that Xenomai would have to resort to using the programmable interrupt
timer (PIT) for emulating the 64bit time counter it needs. That beast is
reachable from a 8Mhz ISA bus, which would give utterly slow accesses to
the timer channels, giving poor latency figures.

This may still meet your requirements though, but then I would
definitely recommend a kernel upgrade. Don't expect a lot of support
Xenomai-wise for these low end PC/104 modules though.

-- 
Philippe.

