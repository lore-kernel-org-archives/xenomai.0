Message-ID: <4C3AE459.5080108@domain.hid>
Date: Mon, 12 Jul 2010 11:46:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C3ADF54.1080507@domain.hid> <4C3AE0F2.3070908@domain.hid>
	<4C3AE2EE.9050701@domain.hid>
In-Reply-To: <4C3AE2EE.9050701@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Oliver Clugnet <oliver.clugnet@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Oliver Clugnet wrote:
> On 07/12/2010 11:31 AM, Gilles Chanteperdrix wrote:
>> Oliver Clugnet wrote:
>>    
>>> Hello,
>>>
>>> I am trying to get the xenomai user-space programs to work on an x86
>>> embedded system with a uClibc Buildroot root filesystem.
>>> I have patched a kernel, activated the Xenomai sub-system, and
>>> cross-compiled it with the Buildroot uClibc toolchain as well as the
>>> userspace programs. The system boots alright with the Xenomai nucleus
>>> and everything ("dmesg | grep Xenomai" shows that Xenomai is initialised).
>>> But everytime I try to launch a program (cyclictest, clocktest, ...), I
>>> get a segmentation fault with a kernel error message such as:
>>> "clocktest[149] general protection ip:804cc22 sp:bfa29594 error:0 in
>>> clocktest[8048000+7000]".
>>> A possibility I've been looking at is that maybe the programs try to
>>> access the High Memory, even though /proc/meminfo shows that there is
>>> none on this system ("HighTotal 0k"), thus the segmentation fault. I
>>> might add that the system has a 500Mb memory.
>>> Could the High Memory be the problem? Is there a way of getting around it?
>>> Or could the problem be elsewhere?
>>>      
>> No. There is little chance. Chances are higher that the problem comes in
>> fact from uclibc (on x86, few people use uclibc). Could you try a glibc
>> rootfs to confirm this hypothesis?
>>
>>    
> Hello,
> 
> Thank you for answering so quickly. I am actually in the process of 
> building a glibc root filesystem with Buildroot and a glibc toolchain 
> generated with crosstool-ng, so I will see soon enough if the problem 
> comes form the lib version.
> What I don't understand though, is why the uclibc-x86 combination solely 
> would induce such an error as this one. Does it have something to do 
> with the xenomai compatibility in such a case?

x86 usually have lots of RAM and storage, so people probably never used
uclibc on x86 before you. So, my guess is that it was never tested, and
as such it does not work. By experience, we know that compatibility with
uclibc does not come automatically.

Please do not forget to CC the mailing list.

-- 
					    Gilles.

