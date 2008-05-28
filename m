Message-ID: <483D4D1E.6030100@domain.hid>
Date: Wed, 28 May 2008 14:16:30 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <483D1D9A.7010209@domain.hid> <483D2177.7010909@domain.hid>
In-Reply-To: <483D2177.7010909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with semaphores in an RTDM driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Johan Borkhuis wrote:
>   
>> Hello,
>>
>> I am trying to use semaphores inside my driver. It is a driver that can 
>> be used as standard Linux driver and RTDM driver.
>>
>> However, when I use rt_sem_p or rtdm_sem_timeddown in my read_nrt 
>>     
>
> Calling those blocking RT services over a non-RT RTDM handler is a
> strong indication that you are doing something fundamentally wrong.
>
> (BTW, for consistency reasons, you shouldn't use native API services in
> RTDM drivers. Technically, this can be OK, but it is at least very unclean.)
>   

This is true, but as the RTDM sem's did not work for me I moved to the 
rt_sem, which also did not work for the same reason.

>> function I get a -1 return value, indicating EPERM. When I look at the 
>> thread state I see a value of 0x00400080, which indicates a standard 
>> Linux thread. The rtdm-context is 0x00000001.
>> The userspace thread has a thread state of 00300380.
>>
>> What am I doing wrong here? How can I get a semaphore or other sync 
>> mechanism to work inside my RTDM driver?
>>     
>
> RT resources are for RT threads in _primary_ mode. Why do you want to
> pend on those resources while the threads are in secondary ("nrt") more?
>   

The main problem is is that part of the driver (especially the interrupt 
handler) is running in primary mode. The application itself is running 
partly in secondary mode. I need some mechanism to have the application 
waiting for a signal from the interrupt handler.
Do I need to implement this using rtdm_nrtsig, or are there other ways 
to send signals from primary to secondary mode?

Kind regards,
    Johan Borkhuis

-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@domain.hid          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands


