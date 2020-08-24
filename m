Subject: Re: Strange switching [threadname] to secondary mode after exception
 #0 in kernel-space at 0x80272444
References: <1174-5f438c00-25-37e14c00@201457175>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9ab37fa2-25df-dc60-453b-83b36cb7f1f4@siemens.com>
Date: Mon, 24 Aug 2020 13:28:51 +0200
MIME-Version: 1.0
In-Reply-To: <1174-5f438c00-25-37e14c00@201457175>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org, Greg Gallagher <greg@embeddedgreg.com>

On 24.08.20 11:44, François Legal wrote:
> Le Vendredi, Août 21, 2020 20:04 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 20.08.20 15:46, François Legal via Xenomai wrote:
>>> Using RTNet with multiple interfaces, xenomai 3.1 with linux 4.4
>>> Whenever a posix RT thread calls recvmsg (), I get this error.
>>>
>>> I could track this down to line 422 in udp.c :     msg = rtnet_get_arg(fd, &_msg, u_msg, sizeof(_msg));
>>>
>>> If I disassemble the kernel, the failing instruction (at 0x80272444) is a nop in arm_copy_from_user
>>> Am I doing anything wrong ?
>>
>> Maybe you are passing an invalid pointer to recvmsg, directly or in its
>> message structures. That would cause an exception which is fixed up but
>> also reported. Do you get an error in return?
>>
> 
> So, I checked, and the same happens on calls to sendto ().
> I doubt the pointer passed is invalid, as I don't get that kind of problems with 3.0.9.
> Upon return from recvmsg or sendto, I get -1 with errno set to 14.

14 is EFAULT. That at least is as expected.

> Also, I checked in ipipe_base.h, exception #0 seem to be an instruction/data access exception, which seems very weird to me for a NOP instruction that does not appear to be on a line/page boundary.
> 

Can you reproduce the issue with a simple test case? Is it
board-dependent, or does it even trigger in a qemu-arm environment like
xenomai-images builds?

Greg, any idea?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

