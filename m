Message-ID: <540DA12E.1030607@siemens.com>
Date: Mon, 08 Sep 2014 14:29:34 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <540D4E9A.4090203@siemens.com>
 <5d07f986ca9ee2f6e65fe10f16a1bf29@grandegger.com>
 <540D77EB.10602@siemens.com> <540D8759.6050300@xenomai.org>
In-Reply-To: <540D8759.6050300@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Flexcan driver build broken since 3.11 - also in
	upstream?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-09-08 12:39, Gilles Chanteperdrix wrote:
> On 09/08/2014 11:33 AM, Jan Kiszka wrote:
>> On 2014-09-08 11:25, Wolfgang Grandegger wrote:
>>> On Mon, 08 Sep 2014 08:37:14 +0200, Jan Kiszka <jan.kiszka@siemens.com>
>>> wrote:
>>>> Hi all,
>>>>
>>>> just noticed a build breakage in Xenomai 2: ksrc/drivers/can/flexcan.c
>>>> is looking for linux/can/platform/flexcan.h which was removed in
>>>> baffd2e8d9. But both the Xenomai driver and upstream's flexcan.c still
>>>> use the flexcan_platform_data structure which I do not find anywhere in
>>>> the kernel. Does anyone know what happened there?
>>>
>>> I just cloned Linus's kernel tree and do *not* see that any CAN driver is
>>> still including "linux/can/platform/flexcan":
>>>
>>> $ grep -r '/platform/flexcan.h' linux/drivers/net/can/
>>> $
>>>
>>> Will have a closer look later today.
>>
>> Also try "git grep flexcan_platform_data" - confuses me...
> 
> Well, the driver never uses the contents of the pointer to this
> structure, so, it does not really need the structure to be defined...

Indeed, dead code...

> Or am I missing something? Anyway, it would seem the driver has been
> converted to device tree:
> 
> Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> 

Then we need to convert the RT driver as well, right?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

