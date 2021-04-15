References: <20210414021625.24725-1-hongzhan.chen@intel.com>
 <18d563d0-53d7-b7a0-9b0c-f328afef2513@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 1/3] rtdm/testing: latmus: introduce latmus driver
In-reply-to: <18d563d0-53d7-b7a0-9b0c-f328afef2513@siemens.com>
Date: Thu, 15 Apr 2021 09:47:26 +0200
Message-ID: <87eefcugz5.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org


Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:

> Missing commit message in this patch, and in patch 3.
>
> Also, could you provide cover letters with your patch series (for series
>> 1 patch)? That letter would provide a chance to set the context,
> explain potential dependencies.
>
> Does this series already work over next? Or does it have dependencies on
> the dovetail patches?
>
> Given that some hardware setup will be needed, a patch adding
> documentation would be useful. What does the user have to do to be able
> to use the benchmark?
>

Since this a backport from EVL to Cobalt, the procedure is fully
described here: https://evlproject.org/core/benchmarks/

This is a documentation which could be shared between the two cores,
based on making latmus part of the CXP.

-- 
Philippe.

