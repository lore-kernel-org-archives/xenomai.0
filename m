Message-ID: <496F1CF2.1030401@domain.hid>
Date: Thu, 15 Jan 2009 12:24:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <496F0DBE.5010108@domain.hid> <496F14B9.4010604@domain.hid>
In-Reply-To: <496F14B9.4010604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Pending patches
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
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> commit 728fc8970e2032b3280971788f1223f3ad82d80d
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Thu Jan 15 11:10:24 2009 +0100
>>
>>     xnpipe: Fix racy callback handlers
>>     
>>     Invocation of input, output and alloc handler must take place under
>>     nklock to properly synchronize with xnpipe_disconnect. Change all
>>     callers to comply with this policy.
>>
> 
> That one is under investigation. I agree on the bug report (thanks btw), but I
> disagree on the fix. Basically, we can't run all hooks under nklock. For
> instance, the alloc_handler may issue kmalloc() calls when issued from the Linux
> write endpoint.

You mean it /could/? Because no in-tree user (ie. native) calls
rt-unsafe services from its alloc_handler.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

