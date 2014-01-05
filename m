Message-ID: <52C949D6.6090904@xenomai.org>
Date: Sun, 05 Jan 2014 13:02:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>	<52C7CF1E.2050404@xenomai.org>	<52C85088.7020501@xenomai.org>	<52C86093.4000609@xenomai.org>	<CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>	<52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
In-Reply-To: <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nima Nourozi <n.nourozi@gmail.com>
Cc: xenomai@xenomai.org

On 01/05/2014 01:25 AM, Nima Nourozi wrote:
> On Sat, Jan 4, 2014 at 2:57 PM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
>
>     On 01/04/2014 09:29 PM, Nima Nourozi wrote:
>
>         Here is the task function. But I'm not seeing the printout.
>
>         void xx_start_transfer(void *arg) {
>             rtdm_wait_period();
>
>
>     What about checking the return code of rtdm_wait_period()? If
>     something goes wrong there, you do want to know, instead of entering
>     a tight runaway loop.
>
>     --
>     Philippe.
>
>
> I can't print anything since the system freezes so I don't know how I
> can check return value? Also, what loop are you referring to I don't
> have a loop just a print statement.

It does not make sense to have a single wait statement in a periodic 
task, you should have a loop. Or you don't have periodic task. So your 
task should implement a loop.

To force a direct output through the serial console port, you may want 
to try enabling DEBUG_LL and IPIPE_DEBUG, then call 
__ipipe_serial_debug(), instead of printk. Do not use this in regular 
code, this is for debugging purpose only, in mostly hopeless situations 
where using buffered console output is not an option.

Preventing the thread to exit by suspending it indefinitely before the 
routine returns would also help debugging. Calling rtdm_task_sleep(0) 
should do this.

-- 
Philippe.

