Message-ID: <009d01c83cb9$388fbea0$2903050a@domain.hid>
From: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
References: <00a501c83bee$de20b5c0$2903050a@domain.hid>
	<475E80A2.5080203@domain.hid>
Date: Wed, 12 Dec 2007 17:49:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Interrupt Handling in Xenomai
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

dear Mr Jan,

For me there are following difficulties to follow the solutions given in 
FAQ.
i) I cant remove the ethernet ports(handled by Linux) since they are also 
integral part of my project.
ii) I am using some 15 boards in my project, which are going to use 
different lines. so some one surely share the interrupt line with ethernet.
iii) I am also confuse about the ethernet interrupts. when they comes, since 
ethernet works on polling mode. why i m getting continous interrupt with or 
without network is connected or not.
iv) If I am returning 0 , what does it exactly means, what it will do?
v) If I not down ethernet ports interrupt are coming continuously, and since 
unhandled they are making system hangs.
vi) how the unhandled shared irq part is implemented in Xenomai.

With Regards
Kapil Jain

----- Original Message ----- 
From: "Jan Kiszka" <jan.kiszka@domain.hid>
To: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
Cc: <xenomai@xenomai.org>
Sent: Tuesday, December 11, 2007 5:50 PM
Subject: Re: [Xenomai-core] Interrupt Handling in Xenomai


> kapilkumar.jain wrote:
>> Hello all,
>>
>> The problem i faced in Registering Interrupt in Xenomai, if my interrupt 
>> line is shared with the ethernet irqs.
>>
>> If we register for the interrupt line which is shared by ethernet irqs we 
>> will get the continuous interrupt.
>>
>> According to the Xenomai interrupt handling - we should return 
>> RTDM_IRQ_NONE for unhandled interrupt.
>> and RTDM_IRQ_HANDLED for interrupt handled.
>>
>> the problem if I return RTDM_IRQ_NONE, system get hanged with message
>> __XINTIRQ_ No Body cared for IRQ 19
>>
>> IRQ 19 - same irq sharing with ethernet & my module.
>>
>> If instead of RTDM_IRQ_NONE i will return 0; it will not hang.
>> but i am not sure about the functionality when it wil share with some 
>> other irq which is important.
>>
>> what is the meaning of returning 0 from Xenomai ISR?
>
> Using 0 directly is not valid, always use the constants, they (or they
> docs) explain their meaning.
>
> I guess you are rather looking for this explanation:
>
> http://www.xenomai.org/index.php/FAQs
> "What can I do if Xenomai and Linux devices share the same IRQ?"
>
> Jan
>
> -- 
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux 


**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********


