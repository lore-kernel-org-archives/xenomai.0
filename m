Message-ID: <5550A807.1010504@free.fr>
Date: Mon, 11 May 2015 15:00:55 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <554B0C27.5010802@free.fr>
 <20150507090719.GC2099@hermes.click-hack.org> <554B6C3D.6040101@free.fr>
 <20150507153225.GD2099@hermes.click-hack.org>
In-Reply-To: <20150507153225.GD2099@hermes.click-hack.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] v3 heap mem-pool-size
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

On 07/05/2015 17:32, Gilles Chanteperdrix wrote:
> On Thu, May 07, 2015 at 03:44:29PM +0200, Stéphane ANCELOT wrote:
>> On 07/05/2015 11:07, Gilles Chanteperdrix wrote:
>>> On Thu, May 07, 2015 at 08:54:31AM +0200, Stéphane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> Is there a better way to raise mem-pool-size other than specifying in
>>>> cmdline ?
>>>>
>>>>     0"007.389| WARNING: [main] heapobj_init() failed for 470 bytes, raise
>>>> --mem-pool-size?
>>> A command line option is nice, it allows you to do basically
>>> anything you want by calling your program from a script. What is it
>>> you want to do that can not be achieved this way?
>>>
>> It is a nice idea, however I understand everybody needs are not the same.
> You asked for a "better way", I just tried and guessed what it
> means, despite the fact that it was yet another unjustified critic
> of Xenomai. Maybe if the question had been precise like "is there a way
> to programmaticaly set "mem-pool-size", would you have get an answer
> to your question.
>
Hi,

In reply to the latest question :

"""What is it you want to do that can not be achieved this way? """

My last complete answer was :

"""
  It is a nice idea, however I understand everybody needs are not the same.

Regarding my application, I setup dynamically my heap once. But this 
heap size depends will depend on some external parameters and will vary. 
And the only way to know the size to allocate is to "count" the 
databytes in my C programing structures. Honestly, I am sure a computer 
will better do it than my mind.

eg. These external parameters may depend on how many motors in my 
machine, and so on.

"""

It bothers megetting these kinds of personal judgement in reply, 
furthermore out of topic and in a wrong context. Furthermore a waste of 
time.

I would suggest a bit of sagacity on both sides, as I do, e.g. trying to 
understand :
why we need to round up small heap sizes to at least 2048 bytes ?
why heaps are not allocated if I setup 0 size in rt_heap_alloc() ?
why I have to  setup mem-pool-size in xenomai v3 ?
and so on ....

I am pretty sure that there are good reasons , in some contexts. 
Unfortunately, not in my context, may be not in bob's or alice's context 
too....
Precisely, my last question was asking if either I need to make a 
program for computing estimate heap space needed and set it in cmdline,
or if there is a workaround to programmatically set cmdline 
mem-pool-size option?
And in the first case, I think there is unfortunately  some regression .

Regards,
Steph.











