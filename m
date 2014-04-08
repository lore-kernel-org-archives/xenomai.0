Message-ID: <5343F2E1.7050408@xenomai.org>
Date: Tue, 08 Apr 2014 15:00:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396873278.9042.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53429F30.4080204@xenomai.org>
 <1396961235.36322.YahooMailNeo@web163901.mail.gq1.yahoo.com>
 <5343F1D2.8080909@xenomai.org>
In-Reply-To: <5343F1D2.8080909@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch for 3.14 kernel ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/08/2014 02:55 PM, Gilles Chanteperdrix wrote:
> On 04/08/2014 02:47 PM, Huub Van Niekerk wrote:
>> On Monday, April 7, 2014 2:51 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>>
>> On 04/07/2014 02:21 PM, Huub Van Niekerk wrote:
>>> Hi,
>>>
>>> After struggling with the 3.10.18 kernel on armhf (both with and
>>> without the patch), I tried the 3.14 kernel and to my delight some
>>> issues are solved: the clock runs fine again, roscore and top work
>>> great, while they kept failing on 3.10.18.
>>
>>> I would say you have a timer issue, or perhaps the same issue with
>>> SD-card as Andreas. Have you tried turning off the options I said Adreas
>>> to disable yesterday? (dynamic ticks and high res timers)?
>>
>>> When the system is stuck, do you still see the timer interrupt count
>>> incrementing in /proc/interrupts? Same question for the MMC interrupts.
>>
>>> Since you are the one having the issue, you will have to do the
>>> investigation. If you do not do that, do not expect the issue to
>>> magically go away.
>>
>>
>>> So my question is if (or
>>> when) there will be a patch for the 3.14 kernel line ?
>>
>>> I work for the I-pipe patch for the ARM architecture on my free time.
>>> So, I do things when I want to, without any deadline, and certainly not
>>> under pressure.
>>
>> Right now I can't test anything under the 3.10.18 kernel since for some weird reason (which has nothing to do with Xenomai) my network and USB (combined on my board) is off. With the same configuration file, the 3.14 kernel works fine.
>>
>
> In 3.10 kernel, a new configuration disabled by default is the USB PHY.
> You need to select the USB PHY corresponding to your board. If you want
> to boot using NFS, you have to enable the PHY as built-in in addition to
> the built-in network controller. I did that for the pandaboard (which
> uses the same network adapter as Beagle-XM I believe), and it boots just
> fine using NFS.
>
>
The required configuration is CONFIG_NOP_USB_XCEIV, and you do not have 
the problem with 3.14 because CONFIG_NOP_USB_XCEIV is automatically 
selected by CONFIG_USB_EHCI_HCD_OMAP, I guess too many people had the 
issue.

-- 
					    Gilles.

