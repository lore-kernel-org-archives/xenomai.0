From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Mon, 17 Nov 2014 11:13:41 +0000
Message-ID: <586e7083cd014fcfb15447028fa02840@EX132MBOX1B.de2.local>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr>
 <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>
 <20141111174652.GK17476@sisyphus.hd.free.fr>
 <6f2c7097b3eb4473844743b8b495f5e0@EX132MBOX1B.de2.local>,
 <20141117102236.GE23508@sisyphus.hd.free.fr>
In-Reply-To: <20141117102236.GE23508@sisyphus.hd.free.fr>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
>>=0A=
>> Now the problem "scheduling while atomic" does not occur anymore=0A=
>> within API calls of our own skin. However, after some run-time=0A=
>> (about 5 minutes or more) it seems to appear in gatekeeper-thread=0A=
>> (see below).=0A=
>>=0A=
>> What is not clear to me is the ipipe_raise_irq() call in backtrace=0A=
>> below. I could not identify any according call from within=0A=
>> gatekeeper_thread(). Do I overlook something?=0A=
>>=0A=
>> What I also do not understand is the timestamp of kernel message.=0A=
>> As mentioned the messages do appear about 5 minutes after kernel=0A=
>> start. However the message's timestamp are from about 40 seconds=0A=
>> after boot? Could it happen that messages are delayed? Or is the=0A=
>> timestamp wrong?=0A=
>=0A=
> This would probably mean an issue with the tsc emulation, have you=0A=
> tried running the "tsc" program, from xenomai regression testsuite=0A=
> with the -w option ? I remember than the imx28 tsc emulation is a=0A=
> bit weird, the hardware sometimes returns wrong values, and the=0A=
> support answer was "read it twice, until you get twice the same=0A=
> value". But I never found this really satisfactory: what if reading=0A=
> it twice returns the same wrong value twice ?=0A=
> =0A=
> The tsc test should see if the tsc wrapping is doing fine. You can=0A=
> try to run it several time, or even in parallel to your tests, to=0A=
> see if it does not detect any problem.=0A=
=0A=
There are some other kernel message whose's timestamp seems to be correct. =
E.g. when creating a semaphore (as below):=0A=
=0A=
[   17.336237] Xenomai: registered exported object @CGI (semaphores)=0A=
[   17.344122] Xenomai: registered exported object LOG (msgx)=0A=
=0A=
I would expect these message on program start which would also match the sh=
own timestamp. However these message are also outputted late after 5 minute=
s run-time, exact same time when "scheduling while atomic" is showed. So no=
w I am assuming the timestamp is valid but messages are delayed shown. Howe=
ver I feel this has nothing to do with my main problem: the program crash. =
So maybe I should open a new thread for "delayed kernel message or wrong ti=
me stamp".=0A=
=0A=
Back to topic: Do you have any idea why "scheduling while atomic" is thrown=
 by gatekeeper_thread(), based on the backtrace? Or do you know on which pl=
ace ipipe_raise_irq() is called from gatekeeper thread respectively if that=
 would be legal/expected?=0A=
=0A=
Regards,=0A=
Christoph=0A=

