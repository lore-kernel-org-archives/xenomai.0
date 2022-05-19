References: <20220517015318.697955-1-qiang1.zhang@intel.com>
 <bfd5f3e30797c8318198c99fb9d5557a64aaebf2.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [linux-dovetail][PATCH 0/3] Add TSC function supports and MFD
 driver for TGPIO
Date: Thu, 19 May 2022 09:02:24 +0200
In-reply-to: <bfd5f3e30797c8318198c99fb9d5557a64aaebf2.camel@siemens.com>
Message-ID: <87czgagg35.fsf@xenomai.org>
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
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "qiang1.zhang@intel.com" <qiang1.zhang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Tue, 2022-05-17 at 09:53 +0800, Zqiang via Xenomai wrote:
>> The following modifications are mainly to add TSC function for TGPIO
>> and add intel-ehl-gpio driver divides and initializes the PSE TGPIO
>> resources.
>> 
>> Christopher Hall (1):
>>   x86/tsc: Add TSC support functions to support ART driven Time-Aware
>>     GPIO
>> 
>> D, Lakshmi Sowjanya (1):
>>   ptp: tgpio: PSE TGPIO crosststamp, counttstamp
>> 
>> Raymond Tan (1):
>>   mfd: intel-ehl-gpio: Introduce MFD framework to PSE GPIO/TGPIO
>
> I haven't looked at the details yet and I missed the Community meeting
> today where this topic might have been discussed.
>
> I'm asking myself if the dovetail tree is the right tree to take those
> patches. Have these patches already been sent to upstream / Linux? If
> so, we should fetch them within the next rebase cycle, right?
>
> If not: I feel we shouldn't apply them here and follow the "upstream
> first" approach.
>

Agreed.

-- 
Philippe.

