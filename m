Message-ID: <53EB604D.60603@xenomai.org>
Date: Wed, 13 Aug 2014 14:55:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRN=ExZ4qgcXp8+d2NOzBHUvWb2u6Zu8twmr8Vo2VZnnqg@mail.gmail.com>
 <53EB5F9D.8000905@xenomai.org>
In-Reply-To: <53EB5F9D.8000905@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM !xnpod_unblockable_p() question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On 08/13/2014 02:52 PM, Philippe Gerum wrote:
> On 08/13/2014 02:28 PM, Michael Smith wrote:
>> Hi
>> I have been struggling with this problem for days on end, but there is just
>> not enough information in the code
>> or documentation for me to solve it.
>> I am calling rtdm_mutex_lock() inside a device driver module. It is called
>> by my PCI probe function as
>> the driver is initializing.
>> I keep on getting the error message:
>> Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:1534
>> (!xnpod_unblockable_p())
>> And the resultant -EPERM error message from the return of the function.
>>
>> I know these checks were inserted to stop any call from an incorrect
>> context. But as far as the documentation states
>> it can be called from a kernel module.
> 
> The doc (2.6) reads:
> 
>  * This service can be called from:
>  *
>  * - Kernel-based task
>  * - User-space task (RT)
> 
> The generic "kernel module" context is not mentioned. You get -EPERM
> because you cannot call this from a probe() routine, which runs in
> secondary/pure linux mode. Acquiring a RTDM mutex requires the caller to
> run in real-time mode.
> 

By "kernel based task", the doc always implicitly means kernel-based
_Xenomai_ task, e.g. RTDM driver task. Such one always runs in primary mode.

-- 
Philippe.

