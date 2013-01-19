Message-ID: <50FA9265.7020100@xenomai.org>
Date: Sat, 19 Jan 2013 13:32:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301182211.27006.paul_c@tuxcnc.org>
In-Reply-To: <201301182211.27006.paul_c@tuxcnc.org>
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

On 01/18/2013 11:11 PM, Paul wrote:

> On Friday 18 January 2013, Pierre LE COZ wrote:
>> I have simple program to manage the GPIO of my raspberry Pi using
>> RTDM.
>>
>> I use :
>> "rtdm_irq_request(& irq_exemple, num_irq, exemple_handler,
>> RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE, "MyProgram", NULL);"
>> in order to detect interrupts.
> 
> rtdm_irq_request does not explicitly enable the interrupts on a gpio pin 
> with ian_cim's patch


This may be a generic issue, which I thought was fixed, but may not be.
Could you try the following patch?

http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=c14c79d29fed82267560c7bf26d628ef4d39f5b7

-- 
                                                                Gilles.

