References: <99BAB48E90E86D42AD41F0BCE3225AEB018DE50813@GRZSMS582.andritz.com>
 <a00a6566-e5f0-9496-f139-beed6d1a1bad@siemens.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB018DE508FF@GRZSMS582.andritz.com>
 <2d21cf6a-1ed6-ab61-07d6-188a48ee98de@siemens.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB018DE509D8@GRZSMS582.andritz.com>
 <39f43017-33cb-c7e0-67e0-cd824a5bc6c4@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f6bfce5b-60ac-f02e-154a-6b62b01f5a81@xenomai.org>
Date: Wed, 20 Dec 2017 19:15:50 +0100
MIME-Version: 1.0
In-Reply-To: <39f43017-33cb-c7e0-67e0-cd824a5bc6c4@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Weird behavior during debug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 12/19/2017 07:57 PM, Jan Kiszka wrote:
> On 2017-12-19 14:44, Lange Norbert wrote:
>>
>> Problem persists in ipipe-core-4.9.51-x86-4, ipipe-4.4 kernel crashes at boot (likely no good support for this SOC).
>> Used program is attached, it is being executed twice, once directly via serial or ssh, once via gdbserver or gdb (tested various combinations).
>>
>> The directly executed program will stop (supposedly at read), as soon as the debugged program is halted.
> 
> OK, now I get the point: You need
> http://git.xenomai.org/xenomai-3.git/commit/?id=0d653e6db75f01287f83ddc3a4ba8189f0bd0366,
> but that is only in next so far.
> 
> What happens in stable (and also in older versions) is that all Xenomai
> timers in the system are stopped once one Xenomai application enters a
> ptrace state. That is going to vanish in the next version, and we may
> consider taking it to stable as well. What do you think, Philippe?
> 

I did not see any regression on the next branch so far with this patch
in, so functionally speaking, there should be no issue in backporting
this code.

However this would break the build for out of tree drivers which depend
on XNTIMER_NOBLCK. A possible work-around would be to add a null
placeholder for XNTIMER_NOBLCK to the backport, along with that patch.

-- 
Philippe.

