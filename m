Message-ID: <56f788c9-f7c1-a88d-6018-c5de0aaa3a76@siemens.com>
Date: Thu, 5 May 2022 18:35:13 +0200
MIME-Version: 1.0
Subject: Re: Can't compile userspace application with compiler switch
 -std=c++11 and Xenomai 3.2
Content-Language: en-US
References: <AM7P122MB022978CBCF4698031D9E1F33F2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AM7P122MB022978CBCF4698031D9E1F33F2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Grau, Gunter" <gunter.grau@philips.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.05.22 16:56, Grau, Gunter via Xenomai wrote:
> 
> Hi,
> 
> We are trying to port our application to Xenomai 3.2.
> The source is c++ and we use in some parts C++11 elements. Therefore the compile switch is set to -std=c++11.
> When now compiling with this option we see following output when using Xenomai 3.2:
> 
> In file included from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/cobalt/semaphore.h:24,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/cobalt/sys/cobalt.h:25,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/copperplate/clockobj.h:113,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/alchemy/timer.h:22,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD-5.4-Kernel-88/sdk-iv-monitor/target-sysroot/usr/xenomai/include/alchemy/heap.h:22,
>                  from ../PROG/Test.cpp:39:
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h: In function 'void __try_read_start(const urw_t*, urwstate_t*)':
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:57:19: error: expected primary-expression before 'volatile'
>  #define READ_ONCE ACCESS_ONCE
>                    ^~~~~~~~~~~
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:64:10: note: in expansion of macro 'READ_ONCE'
>   token = READ_ONCE(urw->sequence);
>           ^~~~~~~~~
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:57:19: error: expected ')' before 'volatile'
>  #define READ_ONCE ACCESS_ONCE
>                    ^~~~~~~~~~~
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:64:10: note: in expansion of macro 'READ_ONCE'
>   token = READ_ONCE(urw->sequence);
>           ^~~~~~~~~
> 
> This worked with Xenomai 3.1.
> It looks like the issue is related to the usage of "typeof" in the ACCESS_ONCE macro. This seems not to be allowed if you use -std option:
> https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html#Alternate-Keywords
> I have now a workaround by defining a macro prior the inclusion of "heap.h":
> #define typeof __typeof__
> But I am not happy with this. Is there a way to do this better? Is -std now not allowed with Xenomai?

The answer is lying in

https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html#Alternate-Keywords

So we should convert to __typeof__ in-place in the affected kernel
header, possibly also elsewhere. We do have several occurrences of
__typeof__ in interface headers already.

Patch(es) welcome.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

