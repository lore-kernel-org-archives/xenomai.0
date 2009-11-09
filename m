Message-ID: <4AF86204.6000700@domain.hid>
Date: Mon, 09 Nov 2009 19:40:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AF85A5F.2030203@domain.hid> <4AF85B75.40408@domain.hid>
	<4AF85EAD.5020408@domain.hid>
In-Reply-To: <4AF85EAD.5020408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Unchecked ipipe_test_pipeline_from
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> just noticed: The __ipipe_check_percpu_access of __ipipe_get_cpu_var,
>>> added in 2.6.29, makes ipipe_test_pipeline_from unusable for debugging
>>> purposes. It now triggers a false positive warning if the caller did not
>>> disabled interrupts or stalled its pipeline. One such user under Xenomai
>>> is rthal_local_irq_disabled, and that is used to check RTDM driver
>>> handlers /wrt leaking IRQ masks.
>> It does not look like a false positive. If the task issuing the call to
>> rthal_local_irq_disabled function was migrated at the wrong time, it
>> could check the stall flag on the wrong cpu.
> 
> Unless you want to test the migration logic itself, a plain task in
> whatever domain should never see a CPU-depend rthal_local_irq_disabled -
> migration should never alter the context in this respect.
> 
>> So, it looks like
>> rthal_local_irq_disabled should be fixed to turn off irqs during the check.
>>
> 
> Would work, but would also be more heavy-weighted then needed.

If it is debug stuff, does the heavy-weight matter that much?

-- 
                                          Gilles


