Subject: Re: GPIO interrupt not working on Zynq7000
References: <7230-5e5fd700-9-4d48c480@89257876>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9f7ba85f-501d-d8aa-9c2b-7346b975abc6@siemens.com>
Date: Wed, 4 Mar 2020 17:48:54 +0100
MIME-Version: 1.0
In-Reply-To: <7230-5e5fd700-9-4d48c480@89257876>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04.03.20 17:28, François Legal wrote:
> Le Mercredi, Mars 04, 2020 17:12 CET, Greg Gallagher <greg@embeddedgreg.com> a écrit:
>   
>> On Wed, Mar 4, 2020 at 11:08 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 04.03.20 17:00, François Legal via Xenomai wrote:
>>>> Le Mercredi, Mars 04, 2020 16:48 CET, Greg Gallagher <greg@embeddedgreg.com> a écrit:
>>>>
>>>>> hi,
>>>>>
>>>>> On Wed, Mar 4, 2020 at 9:40 AM François Legal <devel@thom.fr.eu.org> wrote:
>>>>>>
>>>>>> Le Mercredi, Mars 04, 2020 14:57 CET, Greg Gallagher <greg@embeddedgreg.com> a écrit:
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Wed, Mar 4, 2020 at 4:01 AM François Legal via Xenomai <
>>>>>>> xenomai@xenomai.org> wrote:
>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> trying to diagnose an interrupt problem on a Zynq 7000 hardware. The
>>>>>>>> environment is linux 4.4.189, xenomai 3.0.9.
>>>>>
>>>>> Are you building directly from the ipipe repo or applying one of the
>>>>> patches?  If it's a patch what patch are you applying?
>>>>
>>>> I'm applying ipipe-core-4.4.176-arm-10.patch with slight modifications (KUSER_TSC is not enabled for Zynq 7000 in that patch)
>>>>
>>>
>>> You know that you can find a newer version in
>>> https://gitlab.denx.de/Xenomai/ipipe/tree/ipipe-4.4.y-cip? I'm just not
>>> releasing it as I'm lacking test feedback on the updates. It is not
>>> supposed to resolve the GPIO issue, though.
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>>> Corporate Competence Center Embedded Linux
>>
>> I'll have to look at this a little more closely, I don't think you
>> need to clear the pending status unless something changed upstream on
>> us.  The chained handler should be calling a mask and ack to hold the
>> line  and then unmask once the handler is called.  In userspace you're
>> just calling select on the gpio path?  I can test this with just the
>> ipipe first and see if we can isolate the issue to either the ipipe or
>> Xenomai.  It may take me a couple of days to get setup with my Zynq
>> board again, can you try the 4.4.y branch Jan mentioned, I'll use that
>> as a starting point when I start debugging.
>>
>> Thanks
>>
>> Greg
>   
> Your comment on using the ipipe repo made me go there and have a look. It seems I found the answer.
> In the zynq_gpio_handle_bank_irq, the ipipe repo uses "ipipe_handle_demuxed_irq" whereas mine used "generic_handle_irq"
> 
> It seems that my problem is solved now.
> 
> So I think I saw the announcement for ipipe-core-4.4.196-cip38-x86-19.patch, but nothing for arm.

That's what I meant with "I'm just not releasing it as I'm lacking test 
feedback on the updates". Only since rather recently, we have here a 
BeagleBone Black as part of our lab on 4.4-cip head as well, but that's 
just one target.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

