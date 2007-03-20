Message-ID: <45FF84F2.5050209@domain.hid>
Date: Tue, 20 Mar 2007 07:53:38 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>	<45FDA81F.2080004@domain.hid>
	<E1HTD6v-0004qo-QI@mailer.emlix.com>	<E1HTDZN-0006rl-2g@domain.hid>	<45FE7578.4000306@domain.hid>
	<45FE8AA2.1030507@domain.hid> <45FEF649.9060205@domain.hid>
	<45FEFE64.5010206@domain.hid> <45FF0DC8.6000007@domain.hid>
In-Reply-To: <45FF0DC8.6000007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>>>> The problem is to define what degree of error-related IRQ load is
>>>> generally acceptable. We surely can't do this, so we have to document
>>>> the effect /at least/ and help the users to check it on their own - or
>>>> we have to avoid it / make it insignificant compared to normal CAN
>>>> operation (I'm still in favour of this path).
>>> We speak about a pathological situation and therefore I do not share
>>> your concerns. When there are electrical problems or even the cable is
>>> not connected, we do have an abnormal mode of operation and CAN
>>> related real-time is broken anyhow. The bus error messages are then
>>> useful for analyzing the problem. The effect of the bus error
> 
> I do understand, and that's why I was looking for some solution that
> rate-controls such IRQs deterministically, but doesn't switch them off
> altogether.

OK, then lets first check if we need bus error rate control at all for 
the sake of real-time. I will do some test a.s.s.p. I still believe that 
most of the reported problems are due to heavy printk debuging output.

>>> interrupts on non-CAN related latencies is another issue but I think
>>> it's not that critical either (handling a bus error just requires the
>>> reading of 2 SJA1000 registers). But I agree, a more detailed analysis
>>> of "bus error flooding" would help to understand the impact on the
>>> real-time behavior.
>> And also be aware, that heavy CAN traffic can cause similar latencies as
>> well and when there is more than one CAN controller, they can accumulate
>> (as I have observed with my PCAN dongle tests). Here a IRQ service task
> 
> Well, this argumentation doesn't help if some concrete CAN bus was
> specified to _not_ deliver such high traffic.
> 
>> or threaded IRQs would help. Maybe this is the right way to go.
> 
> Again: threaded IRQs are no magic bullet. First of all, they add
> latencies, specifically on low-end. And they can only help if IRQ
> priorities can actually be lowered appropriately (or if you apply
> round-robin or a similar CPU bandwidth policy).

I know, but if the servicing of interrupts takes too long and other task 
should not suffer from that, it's the only reasonable solution, AFAIS.

Nevertheless, I think we all agree that the patch for 2., the on-demand 
bus error interrupts, should be commited, right?

Wolfgang.

Wolfgang.

