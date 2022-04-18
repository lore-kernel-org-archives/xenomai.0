Message-ID: <047a5d37-59e7-4ec0-a918-2f0ce12d738f@akamina.com>
Date: Mon, 18 Apr 2022 19:39:30 -0400
MIME-Version: 1.0
Subject: Re: Analogy supported DAQ
Content-Language: en-CA
References: <075339687d602ea1c4c7841a79dff2d4@rtxi.org>
 <41a8bf39-676c-c28b-03a3-53788a4f7676@siemens.com>
 <30ed23fe57ee9720ff0ab364a55c6a2a@rtxi.org>
From: Peter Laurich <Peter.Laurich@akamina.com>
In-Reply-To: <30ed23fe57ee9720ff0ab364a55c6a2a@rtxi.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Ivan,

I also use Analogy and I believe that I am the user that Jan was 
referring to.

I have used some of the newer NI cards a few years ago but, at the time 
at least, developing Analogy drivers for them was not possible since NI 
does not make low-level hardware register information available to 
users. Without that information, driver development was not possible. We 
chose to use the NI development libraries at the lowest-level and map 
those to Analogy calls so that we could reuse some of our higher-level 
code. That seemed to work reasonably well.

I have recently developed an Analogy driver for an ACCES I/O mPCIe card 
(mPCIe-AIO16-16F) as well as one for the CAN Bus interface on an ARM 
board that we are using. We implemented the Analogy driver for the CAN 
Bus i/f so that our higher level software could acquire data from CAN 
sensors in the same way that it acquires data from the analog I/O card. 
I'd be open to sharing some of our recent driver development with you if 
this seems helpful.

Let me know if I can be of assistance.

Peter

On 4/15/2022 10:19 AM, Ivan F. Valerio via Xenomai wrote:
> On 2022-04-13 11:59, Jan Kiszka wrote:
>> On 12.04.22 18:36, Ivan F. Valerio via Xenomai wrote:
>>> Hello,
>>>
>>> I am looking to use Xenomai's analogy to connect my application to a NI
>>> PCIe DAQ card. I found your list of supported hardware for analogy, and
>>> the only PCIe found in your list are no longer supported by National
>>> Instruments(PCIe-6251 & PCIe-6259). Are there any other PCIe cards
>>> supported by Analogy? How would I go about confirming compatibility 
>>> with
>>> the newer NI PCIe cards?
>>
>> Analogy was about to be removed from Xenomai because no one was
>> contributing updates to it in a long while, particularly -but not only-
>> drivers. One user raised his voice that at least the core is still used
>> (with out-of-tree drivers), so that move was postponed. In that light,
>> it is a bit unlikely that you get much more feedback.
>>
>> We are surely open to new contributors "reviving" part of Analogy again,
>> specifically /wrt to newer hardware. The first step to assess the
>> efforts would likely be comparing older drivers and their manuals (or
>> kernel drivers, if any) to newer one, e.g. whether the register
>> interface is just an extension or rather something completely different.
>>
>> Jan
>
> I am interested in perhaps doing an assessment and even submit patches as
> our application depends on Analogy support however I am not familiar with
> device driver development. Any Xenomai/Linux resources that you can point
> me to in order to get started? Thanks.
>
> -Ivan
>
