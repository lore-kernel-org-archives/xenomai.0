Message-ID: <5469F90D.4030101@xenomai.org>
Date: Mon, 17 Nov 2014 14:33:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr>
 <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>
 <20141111174652.GK17476@sisyphus.hd.free.fr>
 <6f2c7097b3eb4473844743b8b495f5e0@EX132MBOX1B.de2.local>
 <5469E0AD.6060209@xenomai.org> <20141117131004.GA26613@sisyphus.hd.free.fr>
In-Reply-To: <20141117131004.GA26613@sisyphus.hd.free.fr>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/17/2014 02:10 PM, Gilles Chanteperdrix wrote:
> On Mon, Nov 17, 2014 at 12:49:01PM +0100, Philippe Gerum wrote:
>> On 11/17/2014 11:01 AM, Stoidner, Christoph wrote:
>>>
>>> Hi,
>>>
>>>> you are completely right, we have implemented our own skin. Using
>>>> the debugging functionality mentioned above we have identified a
>>>> function-call that leads to exact the behaviour as described in your post.
>>>>
>>>> Hopefully solving that issue solves our application crash.
>>>
>>> Now the problem "scheduling while atomic" does not occur anymore within API calls of our own skin. However, after some run-time (about 5 minutes or more) it seems to appear in gatekeeper-thread (see below). 
>>>
>>> What is not clear to me is the ipipe_raise_irq() call in backtrace below. I could not identify any according call from within gatekeeper_thread(). Do I overlook something?
>>>
>>
>> You could match the closest routine to the calling PC value (c00aac84)
>> using add2line on your kernel image.
>>
>> e.g. arm-linux-gnueabihf-addr2line -e vmlinux -a c00aac84
> 
> That would rather be:
> arm-none-linux-gnueabi-addr2line
> 
> imx28 is an armv5 (who said that armv4 and armv5 were no longer in
> circulation ?).
> 
> :-)
> just nitpicking.
> 
> If you have a the multiarch binutils version installed, the default
> addr2line should work as well.
> 

"e.g." precisely stands for this, "to be replaced by the command that
fits". I'm not building for v4/5 these days.

-- 
Philippe.

