Message-ID: <4D75594F.5000607@domain.hid>
Date: Mon, 07 Mar 2011 23:16:47 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>	<4D74975F.4050009@domain.hid>	<4D74C683.1020904@domain.hid>	<AANLkTi=0kGcZwfTesBKbQ9u6OedaUU8vsMogAbhYceN+@mail.gmail.com>	<4D752CDB.5030904@domain.hid>
	<AANLkTimnZRTFO3u1bn2b+8PfGhnf9XZNKUvpCtwA4Mvc@domain.hid>
	<4D754DD5.3010006@domain.hid>
In-Reply-To: <4D754DD5.3010006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] irqloop hangs on Beagleboard ARM with
	2.5.5.2/2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 03/07/2011 10:27 PM, Gilles Chanteperdrix wrote:
> Eric Eric wrote:
>> On Mon, Mar 7, 2011 at 2:07 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Eric Eric wrote:
>>>> OK, it looks like I would basically have to replace gpioirq-hw.h
>>>> bare-bones GPIO driver for the beagle to get this to work.  Other than
>>>> that, am I correct that the hardware configuration would be two boards
>>>> connected to each other using two GPIO pins for trigger and response?
>>> Well, the gpiolib functions are safe to be used from real-time domain.
>>
>> Hmm, it looked like gpioirqbench went through some pain to -not- use
>> gpiolib and to manually configure and operate the hardware, so I
>> assumed this was not safe.  It's certainly a more pleasant task using
>> gpiolib.  It does beg the question why gpioirqbench isn't doing this.
> 
> The reason is historical.

Right, at that time only a few archs/systems supported the gpolib,
especially with interrupts. But I already have an implementation for the
Qong i.MX31 board using the generic gpiolib. I will dig for it later
this week. "gpioirqbench" measures how fast iPipe or Xenomai software
can respond to an external event (interrupt) in a user-space or
kernel-space task or the Xenomai or iPipe interrupt handler. Anyway,
"gpioirqbench" also needs a host to trigger and measure the latencies in
*hardware*. This is the tricky part. I used a mpc8xx based system.

Wolfgang.

