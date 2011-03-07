MIME-Version: 1.0
In-Reply-To: <4D74C683.1020904@domain.hid>
References: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>
	<4D74975F.4050009@domain.hid> <4D74C683.1020904@domain.hid>
Date: Mon, 7 Mar 2011 13:52:29 -0500
Message-ID: <AANLkTi=0kGcZwfTesBKbQ9u6OedaUU8vsMogAbhYceN+@mail.gmail.com>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

OK, it looks like I would basically have to replace gpioirq-hw.h
bare-bones GPIO driver for the beagle to get this to work.  Other than
that, am I correct that the hardware configuration would be two boards
connected to each other using two GPIO pins for trigger and response?

On a related note, I'm trying to figure out what exactly the latency
program measures.  From the code, it looks like it's measuring timer
jitter and latency (ie it registers a timer for 1mS from now, the when
the timer fires the timer procedure records how far current time is
from the requested fire time).  Is this correct?

Lastly, I'm trying to get some idea of context switch latency.  I see
a man page for "switchbench" but can't seem to find code or binaries
for switchbench.  Any ideas?  I've been using switchtest instead.  It
seems like switchtest fires up a bunch of threads and measure how man
context switches it can do among them.  On my board, I see about
10,000/sec.  Is this equivalent to a 100uS context switch time?  Maybe
it's a stupid question, but something tells me these two things may
not be equivalent.

Thank you again for the prompt and helpful response.

- Eric

On Mon, Mar 7, 2011 at 6:50 AM, Wolfgang Grandegger <wg@domain.hid> wro=
te:
> On 03/07/2011 09:29 AM, Gilles Chanteperdrix wrote:
>> Eric Eric wrote:
>>> Hi, I'm attempting to run irqloop/irqbench and irqloop just appears to
>>> hang indefinitely. =A0Behavior is the same with -t0 and -t1. =A0I am ab=
le
>>> to successfully run other tests such as latency and switchtest. =A0Belo=
w
>>> is the output of strace ./irqloop -t1. xeno_irqbench is loaded, I have
>>> a null modem cable connected to an x86 running irqbench and have
>>> disabled the serial log output and serial tty on the beagle.
>>
>> I am not sure, but I think irqloop currently only works on x86. You
>> should try gpioirqbench instead.
>>
>> http://www.denx.de/wiki/DULG/AN2008_03_Xenomai_gpioirqbench
>
>
> Yes, irqbench requires a 16650-compatible serial or parallel interface
> accessible via ioports, which is usually not available on embedded
> systems. In contrast, gpioirqbench uses GPIO pins but getting it working
> on the Beagle board is also not straight-forward. At least it does not
> work out-of-the-box.
>
> Wolfgang.
>
>

