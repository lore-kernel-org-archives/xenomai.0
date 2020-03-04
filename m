Subject: Re: GPIO interrupt not working on Zynq7000
References: <7232-5e5fd080-9-2896e5c0@29286504>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eca01f47-9200-821c-cf69-af8fcce5703f@siemens.com>
Date: Wed, 4 Mar 2020 17:08:49 +0100
MIME-Version: 1.0
In-Reply-To: <7232-5e5fd080-9-2896e5c0@29286504>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04.03.20 17:00, François Legal via Xenomai wrote:
> Le Mercredi, Mars 04, 2020 16:48 CET, Greg Gallagher <greg@embeddedgreg.com> a écrit:
>   
>> hi,
>>
>> On Wed, Mar 4, 2020 at 9:40 AM François Legal <devel@thom.fr.eu.org> wrote:
>>>
>>> Le Mercredi, Mars 04, 2020 14:57 CET, Greg Gallagher <greg@embeddedgreg.com> a écrit:
>>>
>>>> Hi,
>>>>
>>>> On Wed, Mar 4, 2020 at 4:01 AM François Legal via Xenomai <
>>>> xenomai@xenomai.org> wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> trying to diagnose an interrupt problem on a Zynq 7000 hardware. The
>>>>> environment is linux 4.4.189, xenomai 3.0.9.
>>
>> Are you building directly from the ipipe repo or applying one of the
>> patches?  If it's a patch what patch are you applying?
> 
> I'm applying ipipe-core-4.4.176-arm-10.patch with slight modifications (KUSER_TSC is not enabled for Zynq 7000 in that patch)
> 

You know that you can find a newer version in 
https://gitlab.denx.de/Xenomai/ipipe/tree/ipipe-4.4.y-cip? I'm just not 
releasing it as I'm lacking test feedback on the updates. It is not 
supposed to resolve the GPIO issue, though.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

