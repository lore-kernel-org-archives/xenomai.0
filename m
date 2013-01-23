Message-ID: <50FFD423.2070300@xenomai.org>
Date: Wed, 23 Jan 2013 13:14:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301200013.09110.paul_c@tuxcnc.org>
	<50FBF628.1000709@xenomai.org>
	<201301220306.28220.paul_c@tuxcnc.org>
In-Reply-To: <201301220306.28220.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: Pierre LE COZ <peter.le.coz@gmail.com>, xenomai@xenomai.org

On 01/22/2013 04:06 AM, Paul wrote:

> On Sunday 20 January 2013, Gilles Chanteperdrix wrote:
>> On 01/20/2013 01:13 AM, Paul wrote:
> 
>>>>  About the fact that interrupts are not detected :
>>>>
>>>> This may be a generic issue, which I thought was fixed, but may
>>>> not be.
>>>>
>>>>> Could you try the following patch?
>>>>
>>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=c14c79d29fed822
>>>> 675 60c7bf26d628ef4d39f5b7
>>>
>>> Gilles: Looked at the patch and got as far as the changes in
>>> kernel/ipipe/timer.c:ipipe_timer_stop() - Correct me if I'm wrong,
>>> but this patch is based on a 3.5.7 parent without
>>> GENERIC_CLOCKEVENTS ?
>>
>> Yes, this patch is based on 3.5.7 and is used with and without
>> GENERIC_CLOCKEVENTS.
> 
> Short version: Updated my kernel to 3.5.7 and backported the Raspberry 
> Pi changes from 3.6.11 and added in the ipipe support. Interrupts are 
> not being recognised unless irq_set_irq_type() is called. Digging 
> through the rtdm, nucleus, and ipipe code, at no point is 
> irq_chip->irq_set_type() called - 


The problem is that in Xenomai 2.x branch, it is valid to call
rtdm_irq_request from primary domain, and irq_set_irq_type can not be
called from primary domain. This will be simplified in Xenomai 3.0, but
for the time being, it is much simpler if drivers call it separately.

-- 
                                                                Gilles.

