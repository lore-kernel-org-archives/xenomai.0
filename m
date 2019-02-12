Subject: Re: driver make files and target architecture size
References: <ba52d8a1-4012-dbd9-6d34-e10d0237cd35@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <31b61932-40c0-2719-24ee-6be9d8a2520d@xenomai.org>
Date: Tue, 12 Feb 2019 09:20:40 +0100
MIME-Version: 1.0
In-Reply-To: <ba52d8a1-4012-dbd9-6d34-e10d0237cd35@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Newbold <d.o.newbold@gmail.com>, xenomai@xenomai.org

On 2/12/19 5:25 AM, Don Newbold via Xenomai wrote:
> Hi all,
> 
> This is my first post, so please excuse my shortcomings.
> 
> I've been writing and maintaining Linux drivers for over 15 years, and
> am now being tasked with Xenomai support.
> 
> 1. When I look at the driver make files included with the latest Xenomai
> download they look totally foreign. Is the existing Linux driver module
> makefile format usable or must another format be generated?

Xenomai uses regular Makefiles for the kernel bits it provides. It also
uses autoconf-generated Makefiles for the userland components. E.g.
kernel/cobalt/Makefile describes the build recipe for the Xenomai core
in a way that should be familiar to you. This makefile and the related
sources are introduced into a regular kernel tree by a script called
"prepare-kernel.sh".

You may find detailed information there:
https://gitlab.denx.de/Xenomai/xenomai/wikis/Installing_Xenomai_3

> 
> 2. I'm familiar with building drivers to support 32-bit vs 64-bit
> targets. I see that Xenomai has in the past had x64 support, but I now
> only see x86. Please clarify the current x86 vs x64 support.
> 

kernel/cobalt/arch/x86 includes both 32 and 64 bit support.

-- 
Philippe.

