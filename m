MIME-Version: 1.0
In-Reply-To: <870b1220-5c46-e014-e5d0-f60bed7c4f09@xenomai.org>
References: <CAMcKmiH8q2rW72dsyRLjm0SFGYTwgbPSMUbRcv=S+=3jMtHZow@mail.gmail.com>
 <870b1220-5c46-e014-e5d0-f60bed7c4f09@xenomai.org>
From: George Broz <brozgeo@gmail.com>
Date: Tue, 13 Dec 2016 18:22:00 -0800
Message-ID: <CAMcKmiE9VsLgYdN6W1quFt1+Uujy+x+Xrpq40f8Vd4N7Sua68g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] mapping peripherals through /dev/mem on xenomai/cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 14 November 2016 at 01:43, Philippe Gerum <rpm@xenomai.org> wrote:
> On 11/08/2016 01:35 AM, George Broz wrote:
>> Hello,
>>
>> I'm running on an ARM SoC, Xenomai 3.0.3, Linux 3.18.20 and using
>> the Cobalt/POSIX interface in trying to port a legacy application
>> from Linux to Xenomai.
>>
>> The legacy application uses "/dev/mem" from user space to access
>> peripheral memory. The usual calls:
>>
>> fd = open("/dev/mem", O_RDWR);
>> mr = mmap(NULL, PAGE_SZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, devaddr);
>>
>> work fine under Linux, but mmap returns EINVAL when the same
>> code is run under Cobalt.
>>
>> If I use an RTDM (UDD mini-) driver, I can map the peripheral memory
>> that would otherwise return EINVAL when attempting to map it
>> through /dev/mem. (This then requires a device tree entry and
>> "up front" knowledge of the devices in the system.)
>>
>> Conversely, if I use an address that is below the peripheral range
>> (i.e. within system memory as defined by the <memory> device tree
>> node) then the mapping succeeds under Cobalt.
>>
>>
>> My question:
>> Is there a way to mmap peripheral memory via /dev/mem under
>> Cobalt or is an RTDM driver required in this scenario?
>>
>> Bonus question:
>> Where in the Xenomai codebase is the EINVAL determination
>> made in this (/dev/mem) case?
>>
>>
>
> The process for opening a special device file through Cobalt is as follows:
>
> 1. the open() wrapper in lib/cobalt/rtdm.c is called by the application,
> as a result of wrapping the overloaded POSIX symbols (ld's --wrap
> option, see output of xeno-config --ldflags --posix).
>
> 2. the open() wrapper first invokes the Cobalt core with the file path
> ("/dev/mem" in this case), for determining whether the associated device
> is managed by RTDM. If so, RTDM returns a valid file descriptor to the
> caller. This should not match your use case.
>
> 3. otherwise, lib/cobalt hands the request over the glibc by calling the
> real open(). This should happen in the /dev/mem case.
>
> When mapping, the same process happens for the mmap() routine. If the
> file descriptor passed to mmap() belongs to RTDM, Cobalt's mmap handler
> in kernel/cobalt/posix/io.c receives the request. Otherwise, the mmap()
> wrapper from lib/cobalt/rtdm.c hands the request over the regular glibc
> call.
>
> In your case, I would expect step 2 to fail for RTDM since it does not
> manage /dev/mem, and the subsequent mmap() to be fully handled by the
> regular kernel via a glibc call. You may want to track down the issue
> starting from mmap_pgoff() in mm/mmap.c, down to the mmap_mem() in
> drivers/char/mem.c.

Thanks for the information, Philippe.

The EINVAL is returned from mmap_mem() when using the cobalt wrappers.

The mmap call I am trying to make is:
dcdc_map =    mmap(NULL, 0x1000, PROT_READ|PROT_WRITE, \
MAP_SHARED, devmem_fd, 0xff208000);

which fails in mmap_mem() where I have added debug code:

if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size)){
      printk(KERN_ERR "mmap_mem() - valid_mmap_phys_addr_range() \
        failed - vm_pgoff: %p , size: %p\n", (void*) vma->vm_pgoff,
(void*)size);
return -EINVAL;
}

the debug shows:
mmap_mem() - valid_mmap_phys_addr_range() failed - vm_pgoff: fffff208
, size: 00001000


When the same mmap() call is made from an executable without cobalt wrappers
valid_mmap_phys_addr_range() passes, using an unsigned right shifted vm_pgoff
input parameter:

mmap_mem() - valid_mmap_phys_addr_range() succeeded - vm_pgoff:
000ff208 , size: 00001000

I'm not sure what to fix from this information...

Advice?

Thanks,
--George

>
> --
> Philippe.

