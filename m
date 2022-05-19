Message-ID: <fde20948-b893-8a30-c653-8e8ae7cb8018@siemens.com>
Date: Thu, 19 May 2022 07:41:22 +0200
MIME-Version: 1.0
Subject: Re: [linux-dovetail][PATCH 0/3] Add TSC function supports and MFD
 driver for TGPIO
Content-Language: en-US
References: <20220517015318.697955-1-qiang1.zhang@intel.com>
 <bfd5f3e30797c8318198c99fb9d5557a64aaebf2.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <bfd5f3e30797c8318198c99fb9d5557a64aaebf2.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>, "qiang1.zhang@intel.com" <qiang1.zhang@intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 18.05.22 19:45, Bezdeka, Florian (T CED SES-DE) wrote:
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

Yup, those should be confirmed upstream first. I'm not seeing them in
Linus' tree yet, or anything related. I thought EHL upstreaming was
completed by now?

Once they are confirmed, backporting accepted patches to certain stable
trees is much safer than having to change APIs again once that feature
hits upstream later.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

