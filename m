Message-ID: <4B3019A8.2030501@domain.hid>
Date: Tue, 22 Dec 2009 01:58:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.20465.1261407746.2717.xenomai-git@xenomai.org>
	<4B2FAA92.2040606@domain.hid>
In-Reply-To: <4B2FAA92.2040606@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai-git Digest, Vol 9, Issue 40
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> xenomai-git-request@domain.hid wrote:
>> Date: Mon, 21 Dec 2009 16:04:33 +0100
>> From: GIT version control <git@domain.hid>
>> Subject: [Xenomai-git] Gilles Chanteperdrix : rtcan: use the new
>> 	pci_ids	header for pci rtcan drivers
>> To: xenomai-git@xenomai.org
>> Message-ID: <E1NMjoH-0003St-31@domain.hid>
>> Content-Type: text/plain; charset=UTF-8
>>
>> Module: xenomai-head
>> Branch: master
>> Commit: 5662ced95f1f51dbf4285d5ff5a6da84cc74af83
>> URL:    http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=5662ced95f1f51dbf4285d5ff5a6da84cc74af83
>>
>> Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> Date:   Sun Dec 20 02:43:36 2009 +0100
>>
>> rtcan: use the new pci_ids header for pci rtcan drivers
>>
>> ---
>>
>>  ksrc/drivers/can/sja1000/rtcan_ems_pci.c   |    1 +
>>  ksrc/drivers/can/sja1000/rtcan_esd_pci.c   |    1 +
>>  ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c |    1 +
>>  ksrc/drivers/can/sja1000/rtcan_peak_pci.c  |    1 +
>>  4 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/ksrc/drivers/can/sja1000/rtcan_ems_pci.c b/ksrc/drivers/can/sja1000/rtcan_ems_pci.c
>> index f69b5b8..a0921b4 100644
>> --- a/ksrc/drivers/can/sja1000/rtcan_ems_pci.c
>> +++ b/ksrc/drivers/can/sja1000/rtcan_ems_pci.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/pci.h>
>>  #include <asm/io.h>
>> +#include <asm-generic/xenomai/pci_ids.h>
> 
> Is there any prerequisite for including this header? If not, can't we
> drag it in via Xenomai's rtdm_driver.h? That avoids diverging too much
> from the "only Linux or RTDM" rule in our drivers.

I understand, RTcan would not compile with RTAI. This header is also
used by the smi module, which is not an RTDM module, that said we can
include it through RTDM for RTDM drivers, and smi module would include
it directly.

-- 
					    Gilles.

