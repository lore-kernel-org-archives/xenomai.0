Message-ID: <5460D139.7090709@siemens.com>
Date: Mon, 10 Nov 2014 15:52:41 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr>
In-Reply-To: <20141110124308.GK17476@sisyphus.hd.free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2014-11-10 13:43, Gilles Chanteperdrix wrote:
> On Mon, Nov 10, 2014 at 09:08:47AM +0000, Stoidner, Christoph wrote:
>>
>> Hi Gilles,
>>
>>> Do you have the same message with exactly the same kernel
>>> configuration, only with CONFIG_XENOMAI and CONFIG_IPIPE disabled?
>>
>> When CONFIG_XENOMAI and CONFIG_IPIPE are disabled the message does not 
>> appear on boot-up.
>>
>>> Do you have FCSE enabled? If yes, did you try disabling it? same
>>> with unlocked context switch.
>>
>> FCSE is already disabled at all.
>>
>> Do you have an idea how to overcome the problem?
> 
> I am not sure the lockdep message really is a problem. lockdep could
> be confused by the fact that the hardware interrupts are not off
> when running the I-pipe, or because we are missing some bit in the
> I-pipe arm specific code to get it looking at the virtual mask
> instead of the hardware mask.
> 
> As for the scheduling while atomic and random segmentation fault,
> you should use the I-pipe tracer, configure it with enough back
> trace points, something like 1000 or 10000, and trigger a trace
> freeze in the kernell code when the problem happens.
> 
> Also, for the "scheduling while atomic", it may happen if you call
> some Linux service which reschedules from primary mode, you can try
> enabling I-pipe debugging, and in fact all Xenomai debugging, to try
> and catch such mistakes. This is especially important if you are
> running a custom skin.

"Scheduling while atomic" may have the same reason why lockdep stumbles:
some changes of I-pipe messe up with IRQ state tracing of Linux. I just
started to look into this issue again. We tried earlier but got distracted.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

