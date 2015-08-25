Message-ID: <55DCA714.5030609@xenomai.org>
Date: Tue, 25 Aug 2015 13:34:12 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DC76C7.5040606@xenomai.org> <55DC87AB.2040306@xenomai.org>
 <55DC940C.4000408@siemens.com> <55DCA0EB.6070905@xenomai.org>
In-Reply-To: <55DCA0EB.6070905@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 08/25/2015 01:07 PM, Jorge Ramirez Ortiz wrote:
> On 08/25/2015 12:13 PM, Jan Kiszka wrote:
>> On 2015-08-25 17:20, Jorge Ramirez Ortiz wrote:
>>> On 08/25/2015 10:08 AM, Philippe Gerum wrote:
>>>> On 08/25/2015 02:13 AM, Don Mahurin wrote:
>>>>> Hi all,
>>>>>
>>>>> We would like to submit our current work on the arm64 port of
>>>>> ipipe/xenomai. We hope that this contribution will encourage further
>>>>> development of arm64 support in ipipe/xenomai.
>>>>>
>>>>
>>>> arm64 support is definitely a high priority item. Thanks for tackling this.
>>>
>>> There are a numbers of cheap (<100USD) and well documented aarch64 boards [1]
>>> that could be used as a reference platform (different SoC vendors)
>>> I'd suggest we use Qualcomm's Dragon 410c.
>>
>> The Qualcomm thing is pretty ugly beast, using a proprietary interrupt
>> controller instead of the standard GIC as strongly recommended by ARM.


Looking at the device tree setting it seems to me it is using GICv2

drivers/irqchip/irq-gic.c


