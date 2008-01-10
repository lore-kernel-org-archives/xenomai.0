Message-ID: <001c01c8533f$956c31c0$2903050a@domain.hid>
From: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
References: <014d01c852bc$5d4bff10$2903050a@domain.hid>
	<4784EEF3.2090906@domain.hid>
Date: Thu, 10 Jan 2008 09:46:32 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Interrupt Sharing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org



Dear Jan,

Thanks

We will work on it.

With Regards
Kapil Kumar Jain
SDG | Data Patterns Pvt Ltd | West Mambalam | Chennai -33 | India

----- Original Message ----- 
From: "Jan Kiszka" <jan.kiszka@domain.hid>
To: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
Cc: <xenomai@xenomai.org>
Sent: Wednesday, January 09, 2008 9:27 PM
Subject: Re: [Xenomai-core] Interrupt Sharing


> kapilkumar.jain wrote:
>> Dear Mr. Jan Kiszka
>>
>> Long before i have asked solution for Interrupt sharing problem between 
>> non real time & real time module,
>> as i have found it is difficult to disable the non real time.
>>
>> I have found the solution by return RTDM_IRQ_NONE | XN_ISR_PROPAGATE. 
>> from the ISR.
>
> That's not a solution, it's a fragile workaround: Your RT device's IRQ
> may suffer from priority inversion when an IRQ event for the non-RT side
> is pending but cannot be handled timely (due to Linux stalling its IRQs
> or some low-prio RT thread is blocking Linux). Then succeeding IRQ
> events for the RT side will also have to wait until the non-RT side has
> completed its processing.
>
> Jan
>
> -- 
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux 


**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********


