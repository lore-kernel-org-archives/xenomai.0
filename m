Subject: Re: Debugging kernel paging request oops
References: <CAPMj8MvTHmgqABPTdvsiN8F5m6j4Sa0EA7iBUjT2hYikyQaY_w@mail.gmail.com>
 <8f9d3ba7-e8b0-c302-b6cc-b8795efe1de0@siemens.com>
 <CAPMj8Mt+6gHSCpfAXHqBkjD4zbfCZV4sKo=u+-jJb3TLN4q4xw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1f4be821-5f99-339e-4599-532c1a9ed35b@siemens.com>
Date: Thu, 16 Dec 2021 10:06:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAPMj8Mt+6gHSCpfAXHqBkjD4zbfCZV4sKo=u+-jJb3TLN4q4xw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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
To: Sam Daniel <daniel.jacob.samuel@gmail.com>
Cc: xenomai@xenomai.org

On 16.12.21 09:49, Sam Daniel wrote:
> On Thu, Dec 16, 2021 at 12:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 16.12.21 06:35, Sam Daniel via Xenomai wrote:
>>> Hello. I am running on a Xilinx ZCU102 (ARM64, Cortex A53) development
>>> board and I've written a lot of userspace software against the POSIX skin
>>> of Cobalt 3.1.
>>>
>>> For context, I have set isolcpus=1,2,3 as kernel boot args. I only run my
>>> Xenomai tasks on CPUs 1,2,3. I know that despite isolcpus, the Linux kernel
>>> will still run a few kthreads on those cores. I am worried that the cause
>>> of my issues might be my Xenomai tasks completely starving those Linux
>>> kthreads.
>>
>> That is likely if your task actually dominates those isolated cores
>> (100% CPU usage). The Xenomai watchdog can catch such bugs and resolve
>> the lockup by kicking the CPU hog out of RT mode. Then you can analyze
>> why the task was not sleeping from time to time.
>>
>> Jan
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
> 
> I have CONFIG_XENO_OPT_WATCHDOG=y and CONFIG_XENO_OPT_DEBUG=y set but
> don't get any Xenomai/watchdog related output when this kernel oops
> occurs.
> 

OK, then your task should release the core from time to time, and we
have a different kind of crash.

What is your kernel version? Where did the patch come from?

Also, your trace of the crash is unfortunately filled with printing the
oops, likely not with the actual problem. Do you have a backtrace as
well? Can you make the trace longer [1]?

Jan

[1] https://source.denx.de/Xenomai/xenomai/-/wikis/Using_The_I_Pipe_Tracer

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

