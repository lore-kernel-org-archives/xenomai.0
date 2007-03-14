Message-ID: <45F7F611.3090602@domain.hid>
Date: Wed, 14 Mar 2007 14:18:09 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HOW5u-0006Ap-EW@mailer.emlix.com>
	<45F7DEA8.2050309@domain.hid>
	<E1HRSws-0007cE-R3@domain.hid>
In-Reply-To: <E1HRSws-0007cE-R3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Wolfgang Grandegger wrote:
>> Sebastian Smolorz wrote:
>>> Last summer we had a discussion about the BEI issue on the socketcan-ML.
>>> Two additional handling policies popped up:
>>> 1. The interface could restart itself after an amount of BEIs, thus
>>> taking responsibility from the user application.
>>> 2. The BEI could be completely disabled if no one is interested in this
>>> type of error frame.
>> I tried to implement 2. for SJA1000, but re-enabling the BIE on the fly
>> does not work. :-(. The controller requires a re-start of the device to
>> get the bus error reporting back to work.
> 
> Oh, really? I wasn't aware of this.

I was surprised as well. The bus error interrupt can be disabled but not 
enabled in active mode.

> 
>>> Maybe it is time to think about the implementation of these policies as
>>> more and more users seem to run into the BEI issue with a disconnected
>>> bus. Wolfgang, Jan, what is your opinion?
>> Well, solution 2. with the limitations mentioned above is therefore less
>> attractive because it interrupts the CAN traffic.
> 
> True.
> 
>> The Socket-CAN 
>> implementation actually restarts the CAN controller after a certain
>> amount of bus error interrupts (200 by default) which matches your first
>> policy above. But in RT-Socket-CAN, we do not automatically re-start the
>> device by purpose. Therefore I tend to just stop the device. It's then
>> up to the application to restart it. What do you think?
> 
> No fundamental objections but it would be best if an application would be 
> informed of this special situation e.g. through an error frame with the 
> meaning "controller was stopped because of a disconnected bus after trying to 
> send 200 times the same message".

D'accord, but we need another error definition for it, e.g. 
CAN_ERR_BUSERROR_FLOOD. I also plan to reset the error count in case of 
a successful transmission (counting only successive errors).

> A question pops up in this context: Why do we define CAN_ERR_RESTARTED if we 
> never do this? Only to be compatible with Socket-CAN? Then I would propose to 
> extend the documentation by pointing out that this will not appear under 
> RT-Socket-CAN.

It's just copied from the Socket-CAN implementation and some doc would 
be nice, indeed.

Wolfgang.


