References: <CAMJ=MEe2+CS0nbjz+nQsFn4TDbKYjP7OQBBmOnbLtksjS-NDDA@mail.gmail.com>
 <CAMJ=MEca95rQbVJhT8XBeVAAU4pN7Eh=vsNQoLNtXk+GzcyKGA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <52ca2255-ebd7-388a-8f4f-cd6fb8c64dbe@xenomai.org>
Date: Thu, 14 Sep 2017 17:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEca95rQbVJhT8XBeVAAU4pN7Eh=vsNQoLNtXk+GzcyKGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Port of ThreadX to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 09/11/2017 08:43 AM, Ronny Meeus wrote:
> On Thu, Sep 7, 2017 at 12:24 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
>> Hello
>>
>> has threadX ever been considered as a candidate to be simulated by Xenomai?
>> Or does somebody already have a private implementation available that
>> has good enough quality to be upstreamed?
>>
>> Any information related to this is much appreciated.
> 
> I have been working on a prototype last Friday and there seems to be a rather
> straight-forward mapping possible between the ThreadX API and the Alchemy
> interface provided by Xenomai. I used the Mercury core for my testing.
> 
> For some functionality, like task creation, adaptations are needed but for most
> functionality only error interface translation, like parameters and
> error codes, is
> needed.
> 
> If we would continue with this, I wonder what would be the best approach either
> we build a layer on top of the Alchemy layer or we create a kind of
> copy of the Alchemy
> layer and do the needed adaptations there.
> So this would mean that we have a ThreadX skin next to the pSOS and
> VxWorks skins
> in Xenomai, while the first solution would be outside Xenomai I assume.
> 
> Feedback is welcome.
> 
> For the people that do not know ThreadX, a full interface description
> can be found here:
> http://rtos.com/images/uploads/ThreadX_User_Guide_V5.pdf
> 

Building a new RTOS API on top of an existing emulator is discouraged.
The basic motivation for having libcopperplate provide RTOS building
blocks is to allow new RTOS APIs to be implemented only by adding
"windows dressings" to those generic services.

Because most of those building blocks are fairly high-level
abstractions, there is not much to factor out by reusing an existing
API. On the other hand, I see a potential for clumsiness in trying to
squeeze in significant variations on top of alchemy. Here are a few
concerns:

- the performance services can't be stacked on the alchemy code; there
is a need for accessing inner info which may not be available from the
alchemy API level. This concerns all ThreadX service groups (mem,
events, sem etc).

- the event mechanism is not callback-based on alchemy, so carrier
threads may be required for dispatching the events to callbacks. That
means yet another indirection.

- no provision for dynamically selecting the sleeping priority order
with mutexes on alchemy (i.e. tx_mutex_prioritize), just like there is
no such thing with POSIX. There is no way to implement this on top of
alchemy, a specific mutex API would have to be implemented from scratch
on top of copperplate to follow the ThreadX semantics anyway.

- queue space allocation won't match between ThreadX and alchemy. The
later allocates it internally, the former sees this as a user-provided
parameter.

At a glance, there are many more differences which can't be expressed as
non-overlapping incremental changes from alchemy to ThreadX. At the end
of the day, I don't think option #1 would be best.

At the end of the day, it looks like a ThreadX emulator should be a
copperplate-based API in its own terms, not a variant of any existing
emulator.

-- 
Philippe.

