Message-ID: <476D7914.3010703@domain.hid>
Date: Sat, 22 Dec 2007 21:52:36 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <OFD2B0EC2A.B4C937F8-ONC12573AD.0036F9DB-C12573AD.00370BC4@domain.hid>	<475DA397.6000408@domain.hid>
	<47665F6C.1000007@domain.hid> <476D5E66.5050902@domain.hid>
In-Reply-To: <476D5E66.5050902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Antwort: Xenomai v2.4.0:
 CONFIG_XENO_OPT_SHIRQ_LEVEL vs. CONFIG_XENO_OPT_SHIRQ
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
>> Wolfgang Grandegger wrote:
>>> Thomas Wiedemann wrote:
>>>> Hi,
>>>>
>>>> we had a problem compiling the CAN-Driver for the last release candidate 
>>>> when
>>>> shared interrupts had been enabled, because of the re-named option
>>>> "CONFIG_XENO_OPT_SHIRQ_LEVEL.". After a quick look, version 2.4.0 still
>>>> doesn't fix this. A patch is included (for ksrc/drivers/can).
>>> Ah, thanks for reporting. I'm going to remove these #ifdefs a.s.a.p.
>>> It's sufficient to print an appropriate error messsage in case interrupt
>>> registration fails with -EBUSY.
>> The attached patch fixes this issue. Here is the ChangeLog entry:
>>
>> 2007-12-17  Wolfgang Grandegger  <wg@domain.hid>
>>
>>   * ksrc/drivers/can/sja1000/{rtcan_sja1000.c, rtcan_*_pci.c}: Remove
>>   CONFIG_XENO_OPT_SHIRQ* ifdefs to fix build problems with recent
>>   versions of Xenomai. If rtdm_irq_request() now fails with -EBUSY, an
>>   error message reminds the user to check for shared interrupt support.
>>
>>   * ksrc/drivers/can/rtcan_dev.c (rtcan_dev_unregister): unregister
>>   devices properly in case refcounts are disabled.
>>
>> If there are no objections, I'm going to apply this patch to Xenomai
>> v2.3.x, v2.4.x and the trunk.
>>
> 
> Please merge. TIA,

Done.

Wolfgang.

