Message-ID: <5437F6ED.8030102@xenomai.org>
Date: Fri, 10 Oct 2014 17:10:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DUB121-W77031E5D3C1CE7CEB386981B90@phx.gbl>
 <542D65B0.3080002@xenomai.org> <20141010132552.GA13501@localhost.localdomain>
In-Reply-To: <20141010132552.GA13501@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai on Cortex R (or Rreal Time) family
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/10/2014 03:25 PM, Richard Cochran wrote:
> On Thu, Oct 02, 2014 at 04:48:16PM +0200, Gilles Chanteperdrix wrote:
>> On 10/02/2014 04:28 PM, mobin Motallebizadeh wrote:
>>>  Hi
>>> can I build xenomai for armv7-r architecture? 
>>> I can't see this mentioned anywhere (surprisingly!)
>>> Is it same as other MMU-less archs(nios II ,e.g.)?
>>
>> The first question to ask is: do you have a Linux kernel for this
>> processor? because Xenomai needs Linux to run.
> 
> There is some main line support for Cortex-M3, for the Energy Micro
> development kit. See Uwe Kleine-König's tree at
> 
>    http://git.pengutronix.de/?p=ukl/linux.git

Well, if it is someone's (other than Linus') tree, it is not mainline :-)

I have worked with Cortex-M3 (TI stellaris family), and as far as I
remember, it has very different behaviour from cortex-A for exceptions,
irqs (the irq controller is integrated in the processor irq path, there
is one irq address for each irq in the vector table, much like x86), and
the like. So, at minimum some changes in entry.S would be needed for
Xenomai to run.


-- 
                                                                Gilles.

