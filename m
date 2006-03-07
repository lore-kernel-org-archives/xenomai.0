Message-ID: <440DB608.40900@domain.hid>
Date: Tue, 07 Mar 2006 17:34:16 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1-rc4 RTDM bug
References: <4409E37A.6090300@domain.hid> <4409E59E.50305@domain.hid>
	<440AF8EF.3010707@domain.hid>
In-Reply-To: <440AF8EF.3010707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
> Hannes Mayer wrote:
>> Hannes Mayer wrote:
>>> Ciao Jan!
>>>
>>> It doesn't seem to make a difference if one uses
>>> RTDM_IRQ_NONE or RTDM_IRQ_HANDLED.
>>> With RTDM_IRQ_NONE the IRQ should be passed to linux,
>>> right ? But it doesn't seem to happen - this brought
>>> up the "top" problem I've posted a few days ago.
>> Returning XN_ISR_PROPAGATE passes the grabbed timer
>> interrupt to Linux and "top" works again.
>>
> 
> As forwarding interrupts to the non-realtime domain is not a common
> use-case of realtime device drivers, I decided to drop the propagation
> support at RTDM level. So if you are including this mechanism in your
> demo, please mark this pattern as something RTDM drivers should normally
> NOT do (and explain what's reason for it here).

Thanks Jan!

I'll add that in a few.

Best regards,
Hannes.

