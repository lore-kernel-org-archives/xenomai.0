MIME-Version: 1.0
In-Reply-To: <52C949D6.6090904@xenomai.org>
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
 <52C949D6.6090904@xenomai.org>
Date: Sun, 5 Jan 2014 12:54:22 -0800
Message-ID: <CAFnctWGqCaXg=y=CCNhmvsxGfBxZTtnFNn7PdAecg8g_ZXA_ow@mail.gmail.com>
From: Nima Nourozi <n.nourozi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, Jan 5, 2014 at 4:02 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 01/05/2014 01:25 AM, Nima Nourozi wrote:
>
>> On Sat, Jan 4, 2014 at 2:57 PM, Philippe Gerum <rpm@xenomai.org
>> <mailto:rpm@xenomai.org>> wrote:
>>
>>     On 01/04/2014 09:29 PM, Nima Nourozi wrote:
>>
>>         Here is the task function. But I'm not seeing the printout.
>>
>>         void xx_start_transfer(void *arg) {
>>             rtdm_wait_period();
>>
>>
>>     What about checking the return code of rtdm_wait_period()? If
>>     something goes wrong there, you do want to know, instead of entering
>>     a tight runaway loop.
>>
>>     --
>>     Philippe.
>>
>>
>> I can't print anything since the system freezes so I don't know how I
>> can check return value? Also, what loop are you referring to I don't
>> have a loop just a print statement.
>>
>
> It does not make sense to have a single wait statement in a periodic task,
> you should have a loop. Or you don't have periodic task. So your task
> should implement a loop.
>
> To force a direct output through the serial console port, you may want to
> try enabling DEBUG_LL and IPIPE_DEBUG, then call __ipipe_serial_debug(),
> instead of printk. Do not use this in regular code, this is for debugging
> purpose only, in mostly hopeless situations where using buffered console
> output is not an option.
>
> Preventing the thread to exit by suspending it indefinitely before the
> routine returns would also help debugging. Calling rtdm_task_sleep(0)
> should do this.
>
> --
> Philippe.
>

Initially I set the periodicity in the init_task to zero to get a one-shot
task to transfer the spi data. But that was freezing the system as well so
I changed my code to mimic what the demo code was doing, hence a periodic
task but without a loop.

I'll add the loop on Monday to see if it makes a difference.
