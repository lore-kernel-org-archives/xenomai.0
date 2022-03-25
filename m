Message-ID: <310bda4d-5f04-c7f0-b896-19e1ebfed0a8@siemens.com>
Date: Fri, 25 Mar 2022 15:28:07 +0100
MIME-Version: 1.0
Subject: Re: xeno-test fails when kernel 64bit userland 32bit
Content-Language: en-US
References: <freemail.20220325140159.96034.1@fmxmldata08.freemail.hu>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <freemail.20220325140159.96034.1@fmxmldata08.freemail.hu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paal Tamas <paal_to@freemail.hu>
Cc: xenomai@xenomai.org

On 25.03.22 14:01, Paal Tamas wrote:
>  
> 
> Jan Kiszka <jan.kiszka@siemens.com> írta:
> 
>     On 25.03.22 13:26, Paal Tamas via Xenomai wrote:
>     > Dear All,
>     > I am using xenomai_3.2.1 with kernel 5.10-dovetail on x86_64 platform. I compile the kernel to 64bit, but I need to have the userspace as 32bit. So I configured the userspace compilation the following way:
>     > ./configure --with-core=cobalt --enable-smp --enable-pshared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64" LDFLAGS=-m32 host_alias=i686-linux
>     > I tried to start RTNET, but I get "Inappropriate ioctl for device" errors. I reported this issue in another thread.
>     > The problem seems to be not RTNET realted, since xeno-test fails with the same error: desktop:/usr/xenomai/bin$ sudo ./xeno-test
>     > Started child 2202: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper ./xeno-test
>     > ++ echo 0
>     > ++ testdir=/usr/xenomai/bin
>     > ++ which systemctl
>     > ++ systemctl is-active --quiet systemd-timesyncd
>     > ++ timesyncd_was_running=true
>     > ++ systemctl stop systemd-timesyncd
>     > ++ /usr/xenomai/bin/smokey --run random_alloc_rounds=64 pattern_check_rounds=64
>     > arith OK
>     > bufp skipped (no kernel support)
>     > cpu_affinity skipped (no kernel support)
>     > fpu_stress OK
>     > gdb OK
>     > iddp skipped (no kernel support)
>     > leaks OK
>     > memory_coreheap OK
>     > memory_heapmem OK
>     > memory_tlsf OK
>     > setup.c:96, ioctl(fd, IOC_RT_IFINFO, &cmd): Inappropriate ioctl for device
>     > /usr/xenomai/bin/smokey: test net_packet_dgram failed: Inappropriate ioctl for device
>     > + start_timesyncd
>     > + true
>     > + systemctl start systemd-timesyncd
>     > + timesyncd_was_running=false
>     > child 2202 returned: exited with status 1
>     > What am I doing wrong?
> 
>     Nothing, known issue in principle:
>     https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21
> 
>     Jan
> 
>     -- 
>     Siemens AG, Technology
>     Competence Center Embedded Linux
> 
>     Jan,
> 

The citation settings of your email client are misconfigured.

>      
> 
>     Thank you for the fast response!
> 
>     Do you have any guess when this "mixed system" will work?
> 

There are multiple issues to be debugged and patched. Someone has to sit
down and do at least the debugging work. And we need that image for the
test lab so that the result is validated during regular runs. So far
none of those to-dos have a schedule yet.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

