Message-Id: <83EC67CC-9E7E-4BD3-811A-7066D24D59D6@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
In-Reply-To: <5341BEF3.20701@xenomai.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Sun, 6 Apr 2014 22:23:15 +0100
References: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
 <52CAEA4D.1020505@xenomai.org>
 <6FD43B5D-6C35-48E7-BC3C-1414A0B809C9@gmail.com>
 <533E8D1F.7040405@xenomai.org>
 <F7F39021-A6D9-433D-B8F9-917C44A4B6B8@gmail.com>
 <534178AC.3090905@xenomai.org>
 <50C4037C-3A2F-4357-97CB-1F114385D922@gmail.com> <5341BEF3.20701@xenomai.org>
Subject: Re: [Xenomai] Command line freeze during xeno-regression-test on
	omap4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On 6 Apr 2014, at 21:54, Gilles Chanteperdrix wrote:

> On 04/06/2014 06:02 PM, Andreas Glatz wrote:
>>
>> On 6 Apr 2014, at 16:54, Gilles Chanteperdrix wrote:
>>
>>> On 04/06/2014 01:21 PM, Andreas Glatz wrote:
>>>> First i mounted tmpfs on /tmp so I don't wear out the SD card too
>>>> much:
>>>> mount -t tmpfs -osize=192M tmpfs /tmp
>>>>
>>>> Then I used the following line to start the test (substitute MYTEST
>>>> below with the following line):
>>>> /usr/lib/xenomai/testsuite/dohell -m /tmp -l /opt/ltp
>>>>
>>>> Note: I always monitored the test over wifi with 'top' so I also  
>>>> had
>>>> some network load...
>>>>
>>>> I got the following results with the 3.10.34 kernel, which includes
>>>> everything up to the current ipipe-3.10 tag (it also included the
>>>> patch you mentioned):
>>>>
>>>> - xeno-regression-test "MYTEST" -> FAIL if booted from SD card (see
>>>> description above); OK if booted from ext USB HD _AND_ no mmc
>>>> partitions mounted
>>>> - CONFIG_IPIPE && CONFIG_XENOMAI && MYTEST -> FAIL (got status  
>>>> LED 2
>>>> constantly on as described above)
>>>> - CONFIG_IPIPE && MYTEST -> OK (see attached config file and ltp  
>>>> test
>>>> log)
>>>
>>> Of course, I assume you used the exact same kernel configuration,  
>>> the
>>> only difference being CONFIG_XENOMAI in the two cases, right?
>>
>> Yes! I just went into menuconfig and disabled CONFIG_XENOMAI, rebuilt
>> it, installed it and rebooted. I'm now recompiling the kernel with  
>> the
>> last config I sent you and the changes I attached (i got all those
>> changes after enabling CONFIG_XENOMAI and your CONFIG_* changes with
>> make menuconfig). After everything is built, I'll install it and
>> repeat running 'MYTEST' without 'xeno-regression-test'.
>
> Another interesting test would be to enable CONFIG_DETECT_HUNG_TASK.
> With a little luck, we will find on what is blocked the kernel.
>

Unfortunately, I rebooted the system and couldn't check the serial  
console. I started ltp again... so I should have more info tomorrow.

However, last week I got the following backtraces with a CONFIG_IPIPE  
&& CONFIG_XENOMAI kernel:

[10683.230000] INFO: task arith:2623 blocked for more than 120 seconds.
[10683.240000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"  
disables this message.
[10683.250000] arith           D c0825a34     0  2623      1 0x00000001
[10683.260000] [<c0825a34>] (__schedule+0x550/0x858) from [<c0825dcc>]  
(schedule+0x90/0x94)
[10683.270000] [<c0825dcc>] (schedule+0x90/0x94) from [<c08260b4>]  
(io_schedule+0xbc/0x12c)
[10683.280000] [<c08260b4>] (io_schedule+0xbc/0x12c) from [<c02077a4>]  
(sleep_on_buffer+0x18/0x20)
[10683.290000] [<c02077a4>] (sleep_on_buffer+0x18/0x20) from  
[<c0823ef0>] (__wait_on_bit+0x64/0xb0)
[10683.300000] [<c0823ef0>] (__wait_on_bit+0x64/0xb0) from  
[<c0823fc4>] (out_of_line_wait_on_bit+0x88/0x94)
[10683.310000] [<c0823fc4>] (out_of_line_wait_on_bit+0x88/0x94) from  
[<c0207860>] (__wait_on_buffer+0x30/0x38)
[10683.320000] [<c0207860>] (__wait_on_buffer+0x30/0x38) from  
[<c0270e34>] (__ext4_get_inode_loc+0x1cc/0x448)
[10683.330000] [<c0270e34>] (__ext4_get_inode_loc+0x1cc/0x448) from  
[<c0272b64>] (ext4_iget+0x64/0x840)
[10683.340000] [<c0272b64>] (ext4_iget+0x64/0x840) from [<c027b9d4>]  
(ext4_lookup+0x120/0x168)
[10683.350000] [<c027b9d4>] (ext4_lookup+0x120/0x168) from  
[<c01e37e4>] (lookup_real+0x40/0x5c)
[10683.360000] [<c01e37e4>] (lookup_real+0x40/0x5c) from [<c01e7b64>]  
(do_last+0x604/0xd24)
[10683.370000] [<c01e7b64>] (do_last+0x604/0xd24) from [<c01e8348>]  
(path_openat+0xc4/0x460)
[10683.380000] [<c01e8348>] (path_openat+0xc4/0x460) from [<c01e9440>]  
(do_filp_open+0x3c/0x88)
[10683.390000] [<c01e9440>] (do_filp_open+0x3c/0x88) from [<c01d9c48>]  
(do_sys_open+0xf4/0x180)
[10683.400000] [<c01d9c48>] (do_sys_open+0xf4/0x180) from [<c01d9d04>]  
(SyS_open+0x30/0x34)
[10683.410000] [<c01d9d04>] (SyS_open+0x30/0x34) from [<c000e020>]  
(ret_fast_syscall+0x0/0x50)

[10683.070000] INFO: task rs:main Q:Reg:2063 blocked for more than 120  
seconds.
[10683.070000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"  
disables this message.
[10683.080000] rs:main Q:Reg   D c0825a34     0  2063      1 0x00000000
[10683.090000] [<c0825a34>] (__schedule+0x550/0x858) from [<c0825dcc>]  
(schedule+0x90/0x94)
[10683.100000] [<c0825dcc>] (schedule+0x90/0x94) from [<c08260b4>]  
(io_schedule+0xbc/0x12c)
[10683.110000] [<c08260b4>] (io_schedule+0xbc/0x12c) from [<c0195570>]  
(sleep_on_page+0x18/0x20)
[10683.120000] [<c0195570>] (sleep_on_page+0x18/0x20) from  
[<c0823ef0>] (__wait_on_bit+0x64/0xb0)
[10683.130000] [<c0823ef0>] (__wait_on_bit+0x64/0xb0) from  
[<c0195364>] (wait_on_page_bit+0xa0/0xb0)
[10683.140000] [<c0195364>] (wait_on_page_bit+0xa0/0xb0) from  
[<c02765fc>] (ext4_da_write_begin+0x1d4/0x28c)
[10683.150000] [<c02765fc>] (ext4_da_write_begin+0x1d4/0x28c) from  
[<c01966ec>] (generic_file_buffered_write+0xdc/0x240)
[10683.160000] [<c01966ec>] (generic_file_buffered_write+0xdc/0x240)  
from [<c01979b0>] (__generic_file_aio_write+0x360/0x3ac)
[10683.170000] [<c01979b0>] (__generic_file_aio_write+0x360/0x3ac)  
from [<c0197a64>] (generic_file_aio_write+0x68/0xc8)
[10683.190000] [<c0197a64>] (generic_file_aio_write+0x68/0xc8) from  
[<c026d33c>] (ext4_file_write+0x36c/0x454)
[10683.200000] [<c026d33c>] (ext4_file_write+0x36c/0x454) from  
[<c01da120>] (do_sync_write+0x84/0xa8)
[10683.210000] [<c01da120>] (do_sync_write+0x84/0xa8) from  
[<c01da8c0>] (vfs_write+0xe0/0x1c8)
[10683.220000] [<c01da8c0>] (vfs_write+0xe0/0x1c8) from [<c01daec8>]  
(SyS_write+0x4c/0x7c)
[10683.230000] [<c01daec8>] (SyS_write+0x4c/0x7c) from [<c000e020>]  
(ret_fast_syscall+0x0/0x50)

A.



