References: <56DEA622.4020107@sigmatek.at> <56DEA859.2040306@xenomai.org>
 <56DEBCD0.7080603@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56DEF3D6.5050209@xenomai.org>
Date: Tue, 8 Mar 2016 16:46:30 +0100
MIME-Version: 1.0
In-Reply-To: <56DEBCD0.7080603@sigmatek.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_event_wait -EINTR error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 03/08/2016 12:51 PM, Johann Obermayr wrote:
> Am 08.03.2016 um 11:24 schrieb Philippe Gerum:
>> On 03/08/2016 11:14 AM, Johann Obermayr wrote:
>>> Hello,
>>>
>>> We have some user space task running into a rtdm driver (ioctl).
>>> this task are waiting for a event with rtdm_event_wait.
>>>
>>> When our appliction crash, we see that rtdm_event_wait return with -4
>>> (-EINTR).
>>> is this a normal behavior ?
>>>
>> Please read your question above again, and ask yourself whether you
>> actually gave us enough information to figure out what you are talking
>> about.
>>
> ok,
> we have a application with some rt-task.
> Some of the task are calling a function in our rtdm drive with
> rt_dev_ioctl.
> 
> in the ioctl we have follow code.
>     if ((rval = rtdm_event_wait(&pIrqData->irq_event)) != 0) {
>         if (rval != -EIDRM) {
>             printk(KERN_ERR "rtdm_event_wait failed %d, irq:%d\n", rval,
> local->irq_number);
>         }
>         return rval;
>     }
> 
> if our application crash (we have no backtrace) , we see in the syslog some
> "rtdm_event_wait failed -4"  messages.
> 
> why we see this message ?
>

This return code is documented:

http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__sync__event.html#ga1c433b50c53d49d164b084751861e855

-- 
Philippe.

