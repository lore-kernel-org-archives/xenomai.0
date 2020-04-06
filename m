Date: Mon, 6 Apr 2020 18:56:48 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
Subject: Re: Xenomai 3.1 missing munmap Posix wrapper
In-Reply-To: <b5c576a3-e61b-6b8d-c40d-2db14f811a7c@siemens.com>
Message-ID: <freemail.20200406185648.25793.1@fmxmldata10.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

>> Hello Everybody,
>> 
>> I just migrated from 2.6.2.1. to 3.1 and run into an issue in my user mode application.
>> The Posix wrapper for the munmap() function is missing. I mean the cobalt.wrappers file does not have a --wrap munmap line and the library does not have the function either. Why is that?
>> The mmap wrapper is there. I need to unmap the memory before closing the file descriptor. At least I did it this way in my old sources. Can I skip the munmap() call in this new Xenomai version before closing the descriptor?
>
>You mmap memory against an RTDM device handle, the only difference to 
>mmap against a Linux device is who provides the memory. Releasing that 
>mapping is just the same as with Linux: call munmap.
>
>If your driver has anything to do on release, register vmops with the 
>backing vma. See e.g. spi_master_mmap.
>
>Jan
>

This is an ARM system (MX6) where I use the external parallel bus of the CPU to communicate with an FPGA in a real-time fashion in user mode. I need to access memory mapped registers of the CPU during the configuration of the CPU external bus interface, and the address range I use to "access" the FPGA is mapped to memory as well. In the old 2.6.2.1 system I was using the mmap() and munmap() wrapper functions for this purpose. I linked only Xenomai libraries to my executable. 
Do you mean I should not use the mmap() wrapper from the cobalt library anymore. Use the Linux equivalent in 3.1? Will it not lead to any trouble? I mean will I not switch to secondary mode when I access the memory I mapped this way for example? 

Thanks,
Tamas

