Message-ID: <55C495D6.2070706@xenomai.org>
Date: Fri, 07 Aug 2015 07:26:14 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <55C17C8E.5000909@gatech.edu> <55C3AEBE.9080603@xenomai.org>
 <55C3C3F8.1090808@gatech.edu> <55C3C7F4.1030107@xenomai.org>
 <12F45B9B-70C3-4278-BA0E-DFC26E19DBF0@gatech.edu>
In-Reply-To: <12F45B9B-70C3-4278-BA0E-DFC26E19DBF0@gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/06/2015 09:57 PM, Yogi A. Patel wrote:
> 
>> On Aug 6, 2015, at 16:47, Jorge Ramirez Ortiz <jro@xenomai.org> wrote:
>>
>> On 08/06/2015 04:30 PM, Yogi A. Patel wrote:
>>> When I run
>>>
>>> sudo ./analogy_calibrate --device=analogy0 --output=file
>>>
>>> I see
>>>
>>> [ 1124.191097] analogy_calibra[2822]: segfault at 7 ip 00007f10b88c6a03 sp
>>> 00007fffaee2bb40 error 4 in libc-2.19.so[7f10b887b000+1bb000]
>>>
>>> on two computers running Xenomai RC5 with Linux 3.18.12 both with NI DAQs
>>> installed (M-Series).
>>
>> please send the procs /proc/analogy/*
> 
> rtxi@synch:~$ cat /proc/analogy/*
> --  Subdevices --
> 
> | idx | type
> |  00 | Analog input subdevice
> |  01 | Analog output subdevice
> |  02 | Digital input/output subdevice
> |  03 | Unused subdevice
> |  04 | Unused subdevice
> |  05 | Calibration subdevice
> |  06 | Memory subdevice
> |  07 | Digital input/output subdevice
> |  08 | Unused subdevice
> |  09 | Serial subdevice
> |  10 | Unused subdevice
> |  11 | Counter subdevice
> |  12 | Counter subdevice
> |  13 | Counter subdevice
> --  Analogy devices --
> 
> | idx | status | driver
> |  00 | Linked | pci-6259
> |  01 | Unused | No driver
> |  02 | Unused | No driver
> |  03 | Unused | No driver
> |  04 | Unused | No driver
> |  05 | Unused | No driver
> |  06 | Unused | No driver
> |  07 | Unused | No driver
> |  08 | Unused | No driver
> |  09 | Unused | No driver
> --  Analogy drivers --
> 
> | idx | board name 
> |  00 | analogy_ni_pcimio 
> |  01 | analogy_8255 
> 
>> can you run analogy_calibrate under gdb?
> 
> I did - and it turns out the error was due to this line:
> 
> __debug("Calibrating AI: %s \n", cal_info[i]);
> 
> changing this to:
> 
> __debug("Calibrating AI: %s \n", cal_info[i].message);

I already sent you a patch for this

> 
> resolves this error.
> 
> Now, I get a file output from analogy_calibrate.
> 
> # uname -a
> 
> Linux synch 3.18.12-xenomai-3.0-rc6 #1 SMP Thu Aug 6 18:30:02 EDT 2015 x86_64 x86_64 x86_64 GNU/Linux
> 
> # cat /proc/xenomai/version
> 
> 3.0-rc6
> 
> # cat /proc/cpuinfo
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 15
> model		: 4
> model name	: Intel(R) Pentium(R) 4 CPU 3.40GHz
> 
> # sudo ./../../usr/xenomai/bin/insn_read -c 0 -R 0
> 
> Non Calibrated values: 
> 1.178149
> 1.178149
> 1.177844
> 1.178454
> 1.178454
> 1.178454
> 1.178149
> 1.178454
> 1.178149
> 1.178149
> 
> # sudo ./../../usr/xenomai/bin/insn_read -c 0 -R 0 -y file
> 
> Never prints anything, top shows continuous running and increased consumption of memory

can you send the calibration file please?
also can you gdb insn_read?

> 
> Yogi
> 
> 

-- 
jro

