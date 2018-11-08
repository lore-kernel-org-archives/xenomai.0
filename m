Subject: Re: [PATCH] cobalt/kernel: Simplify mayday processing
References: <3e868e4f-7bd5-2874-d72b-fc2449ef4b65@siemens.com>
 <111becaa-9e0f-f8ad-4802-62f51379fc07@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <efcd107e-d48d-6dac-96e0-890203c072ba@siemens.com>
Date: Thu, 8 Nov 2018 14:14:52 +0100
MIME-Version: 1.0
In-Reply-To: <111becaa-9e0f-f8ad-4802-62f51379fc07@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>, Dmitriy Cherkasov <dmitriy@oss-tech.org>

On 08.11.18 14:05, Philippe Gerum wrote:
> On 11/5/18 1:20 PM, Jan Kiszka wrote:
>> The mayday mechanism exists in order to kick a xenomai userspace task
>> into secondary mode while it is running userspace code. For that, we ask
>> I-pipe to call us back when the task was interrupted and is about to
>> return to userspace.
>>
>> So far we defer the relaxation from that callback via a VDSO-like
>> mechanism that triggers a special syscall to the return path of that
>> very same syscall. However, that is not desirable because it is a
>> complex, arch-specific mechanism that can easily break and,
>> specifically, that destroys the backtrace of ptraced tasks.
>>
>> Fortunately, we can fulfill the needs of mayday also by relaxing
>> the task directly from the mayday callback. Tested successfully on
>> x86-64 and ARM.
> 
> ARM-wise, this change requires ipipe-core-4.14.71-arm-3 or later to work
> properly. This method would cause an interrupt state breakage with any
> older ARM patch.

That would be a change compared to my past ARM experiments (4.x, if not 3.x 
based). Can you point me to the problem in more details?

Thanks,
Jan

