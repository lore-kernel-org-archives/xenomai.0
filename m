Message-ID: <5469DC54.20005@xenomai.org>
Date: Mon, 17 Nov 2014 12:30:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr>
 <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>
 <20141111174652.GK17476@sisyphus.hd.free.fr>
 <6f2c7097b3eb4473844743b8b495f5e0@EX132MBOX1B.de2.local>,
 <20141117102236.GE23508@sisyphus.hd.free.fr>
 <586e7083cd014fcfb15447028fa02840@EX132MBOX1B.de2.local>
In-Reply-To: <586e7083cd014fcfb15447028fa02840@EX132MBOX1B.de2.local>
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
To: "Stoidner, Christoph" <c.stoidner@arvero.de>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/17/2014 12:13 PM, Stoidner, Christoph wrote:
> 
>>>
>>> Now the problem "scheduling while atomic" does not occur anymore
>>> within API calls of our own skin. However, after some run-time
>>> (about 5 minutes or more) it seems to appear in gatekeeper-thread
>>> (see below).
>>>
>>> What is not clear to me is the ipipe_raise_irq() call in backtrace
>>> below. I could not identify any according call from within
>>> gatekeeper_thread(). Do I overlook something?
>>>
>>> What I also do not understand is the timestamp of kernel message.
>>> As mentioned the messages do appear about 5 minutes after kernel
>>> start. However the message's timestamp are from about 40 seconds
>>> after boot? Could it happen that messages are delayed? Or is the
>>> timestamp wrong?
>>
>> This would probably mean an issue with the tsc emulation, have you
>> tried running the "tsc" program, from xenomai regression testsuite
>> with the -w option ? I remember than the imx28 tsc emulation is a
>> bit weird, the hardware sometimes returns wrong values, and the
>> support answer was "read it twice, until you get twice the same
>> value". But I never found this really satisfactory: what if reading
>> it twice returns the same wrong value twice ?
>>
>> The tsc test should see if the tsc wrapping is doing fine. You can
>> try to run it several time, or even in parallel to your tests, to
>> see if it does not detect any problem.
> 
> There are some other kernel message whose's timestamp seems to be correct. E.g. when creating a semaphore (as below):
> 
> [   17.336237] Xenomai: registered exported object @CGI (semaphores)
> [   17.344122] Xenomai: registered exported object LOG (msgx)
> 
> I would expect these message on program start which would also match the shown timestamp. However these message are also outputted late after 5 minutes run-time, exact same time when "scheduling while atomic" is showed. So now I am assuming the timestamp is valid but messages are delayed shown. However I feel this has nothing to do with my main problem: the program crash. So maybe I should open a new thread for "delayed kernel message or wrong time stamp".
> 
> Back to topic: Do you have any idea why "scheduling while atomic" is thrown by gatekeeper_thread(), based on the backtrace? Or do you know on which place ipipe_raise_irq() is called from gatekeeper thread respectively if that would be legal/expected?
> 

You seem to be running a preempt-rt patched kernel, but the Xenomai core
acts as if it was built for a regular preemption kernel. This virq is
triggered by some code in the Xenomai rescheduling when the caller runs
in secondary mode, which the gatekeeper always does. This code is
correct, the way it is handled by the APC code in Xenomai due to this
apparent build mismatch is not.

-- 
Philippe.

