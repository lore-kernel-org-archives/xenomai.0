References: <8612d9e224a0f91950a3.1480491048@devws148.be.alcatel-lucent.com>
 <561d42f3-a35f-b076-fdee-c09a695912a4@xenomai.org>
 <CAMJ=MEeGB8xj4dcmVCVaQfv_Y-voP7-Nfr0=q5HYmZaeYmAokg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <570bd102-f34d-1d43-a850-64c70dea9135@xenomai.org>
Date: Sun, 4 Dec 2016 11:26:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEeGB8xj4dcmVCVaQfv_Y-voP7-Nfr0=q5HYmZaeYmAokg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] copperplate/mercury: introduce weak function
 to get OS max thread priority
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 12/03/2016 09:39 PM, Ronny Meeus wrote:
> On Sat, Dec 3, 2016 at 6:18 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 11/30/2016 08:30 AM, Ronny Meeus wrote:
>>> This patch introduces a weak function in the mercury copperplate code
>>> that allows to put an upper limit on the priority used by the created thread
>>> objects.
>>>
>>> Before this patch the complete OS scheduler's FIFO range was used and it was
>>> not possible to restrict it. Restricting it can be useful in case other
>>> activities (typically platform related things) need to get a higher priority
>>> than the application threads.
>>>
>>> The example below shows what needs to be implemented in the application to
>>> restrict the range.
>>
>> This looks weird. Any reason not to fix up the priority of your
>> application threads?
>>
> 
> Philippe,
> 
> this is not only about the application threads. We also need to lower
> the priorities
> used by the copperplate for the timer-thread and the task-lock priority.
> The reason for this is that we need to run certain Linux kernel
> threads at a higher
> priority than any of the application threads, including Xenomai.
> 

That means that your system is running in some sort of sandboxed non-rt
environment that may be subject to priority throttling by other parts of
the system even for critical events, which is an interesting concept,
but makes the Xenomai system inherently non-rt in this case. Such
approach is not transposable to the Cobalt core running natively on the
hw, and that is another issue in my eyes.

I don't like the idea at all, but I will think of it anyway, to figure
out whether this is compatible with some basic assumptions in Mercury.
Bottom line is that adding yet another weak routine to get this is not
the way to go, that would prevent multiple tuning points to co-exist
into a single executable. At the very least, that would have to be a
copperplate tunable.

On a general note, let's reserve weak bindings for alternate versions of
internal code or data, not part of the user interface.

-- 
Philippe.

