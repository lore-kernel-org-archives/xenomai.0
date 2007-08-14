From: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Date: Tue, 14 Aug 2007 23:31:32 +0200
Message-ID: <000001c7deba$7c6fbf10$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <46BF49EB.5050705@domain.hid>
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
	threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Hello Jan,

thanks for your immediate answer on my posting. The reason for this
posting is that I spent some more time on thinking about RTOS
architectures, and I got some deeper insights, which I would like to
communicate with the aim that it will be a help for further advances of
Xenomai.

My conclusion is still that another kind of priority inheritance for the
synchronous message passing principle of Xenomai could be very relevant
for some application designs, but I totally agree, the loss of
efficiency must be kept as low as possible - if possible the loss should
be zero, of course.

I know that this posting is quite long again, and I don't expect anybody
to answer extensively. If it is too much, take it as inspiriting
discussion of a "freaking RTOS-user"... ;-) ;-) But again, please tell,
if some of the discussion statements are wrong.

I found a paper, which discusses the subjects of our recent mailings:

U. Steinberg, J. Wolter, and H. Haertig. Fast component interaction for
real-time systems. Proceedings of the 17th Euromicro Conference on
Real-Time Systems, pages: 89-97, 2005.

The paper can be downloaded at

http://os.inf.tu-dresden.de/papers_ps/steinberg_ecrts2005.pdf.

The authors of the paper propose a mechanism for the fast interaction of
interdependent components in real-time systems. Although it treats
L4-micro-kernel architectures, the basic subject of discussion is the
same and it can be transferred to Xenomai. Here a short segment of the
work:

>From "Fast component interaction for real-time systems":
>
>"[...] Most real-time kernels that focus on minimality use a simple
fixed->priority scheduling algorithm, which on one hand does not provide
temporal >isolation and on the other hand is prone to priority-inversion
problems >when component interaction creates a dependency between two
schedulable >entities. In this paper we introduce a reservation-based
approach to >provide temporal isolation. We discuss the problems related
to component >interaction, such as priority inversion and correct
accounting of consumed >time, and demonstrate how our mechanism can be
used to implement priority >inheritance and stack-based priority
ceiling. [...] the basic message->passing mechanisms must be designed
such that well-known methods to avoid >priority inversion, namely
priority inheritance and stackbased priority >ceiling, are supported
without sacrificing performance. [...]"
>

As far as I understood the Xenomai kernel, I conclude that the last part
of this citation has not been realized in the Xenomai kernel. Whether
the approach can be transferred to Xenomai is not clear to me; Again, I
don't understand myself as an operating system developer/specialist. At
first glance I'd say the suggested principle could be embedded in the
Xenomai kernel, but after reading the paper more precisely I understood
that a possible implementation would be anything but easy work for me.
If this should really become interesting for the Xenomai project, I
guess that someone with _big_ kernel experiences has to implement a
solution for this. The approach of the paper is to use a donation scheme
in combination with message passing; two different kinds of context are
necessary, which then finally results in efficient communication without
priority inversion and miss-accounting.

>Jan Kiszka wrote:
>My point is that worst-case is not much different if the receiver gets
>the required static priority right from the beginning. You just add the
>management overhead in the dynamic case (which is noticeable if message
>handling is short).
>
>
>BTW, did you already asked yourself why your receiver has to handle
>messages of different priority with the same thread? If there is
>actually something important aside unimportant stuff to transmit from A
>to B, you may as well let B provide two endpoints with two threads: one
>to handle to important messages and the other the rest. Please don't
>tell me too quickly, you need far too many classification levels for
>this. Check it thoroughly first! Too many priorities are a good sign
for
>indeterministic and inefficient system design.
>
>Note that this pattern can have a nice advantage: lower worst-case
>latency. As you can now let the two threads of B synchronise on the
>_real_ critical section, ie. where shared data is handled, and not
where
>whole messages get parsed etc., that section often gets shorter! (A
>reason why microkernel-like server design doesn't scale that well.)

You are absolutely right, and the issue of worst-case latency has to be
observed by the system developer in all use cases. I think this
advantage of low worst-case latency is _extremely important_, but there
are also cases, in which this could lead to disadvantages (e.g.
_inflexibility_). A good latency is not the only attribute of a good
system. I think a system development engineer should be able to decide
freely, which system architecture and which overall system attributes he
aspires for his application; it should not be dictated by the system but
by the application. And therefore the (efficient) avoidance of priority
inversions when doing synchronous message passing seems to be _very
relevant_. Of course, I agree that if this problem cannot be solved
really efficiently, it will be much better to leave the
send/receive/reply-principle as it is in order keep the latencies low.

In the following paragraphs I would like to point out these statements.

A simple sample situation, where it is indispensable that a high
priority task receives messages from other high-priority tasks as well
as from other low-priority ones, could be the following one:

Suppose a digital I/O card, of which some ports are important and
require hard real-time capabilities, while soft-real-time behavior is
sufficient for some other ports. If a task is the only one in the entire
system that has access to the hardware registers via the RTDM (device
flag 'RTDM_EXCLUSIVE' set), and if the hardware registers contain
important and unimportant I/O bits, the task, which has access to the
registers, needs to fulfill real-time conditions, but it must
furthermore enable low-priority tasks to access the unimportant bits.

To solve this, many design possibilities arise. I think it really
depends on the individual application and it cannot be generalized,
since low latencies are always _really desirable_, but not for any
price. I'm not speaking about soft real-time here - worst-case execution
times have to be predictable in any case! To clarify this I present a
further discussion on example for transferring information from a
high-priority task H to a low-priority one L or vice versa (as in your
example above). Three basic options arise:
=20
-------------
1. The information is located in a shared-memory area of H and L. This
area is protected by a mutex for example, such that the PIP would rule.
When calculating the worst-case latency for H, we can calculate the
maximum time, L needs within the critical section (L would inherit the
priority of H regarding the PIP). During L is in the critical section it
has several basic possibilities to get the data, e.g.:

a. It can send the data directly to another low-priority task by using
pipes, message queues, or synchronous message passing.
=20
b. It can copy data into another area of shared memory (which might be
shared with another other low-priority task).

c. It can copy the data into its own address space.

Each of these three exemplary possibilities has its advantages and
disadvantages. Option c would definitely deliver the lowest worst-case
execution time (and therewith the lowest worst-case latency for H), but
in each case we are able to determine the maximum execution times until
L releases the mutex for the memory area shared with H. Depending on our
preferences and architectural goals, we can not say whether one of these
alternatives is worse than another one. Sure, option (a) would probably
have the greatest worst-case latency, but this must _not necessarily_
mean to be a bad design.=20

2. The high-priority task sends the information cyclically to the
low-priority task (=E1 la publish/subscribe). This way the information =
can
be led to many clients very efficiently.

3. L requests data from H (e.g. via synchronous message passing). If we
only consider the common case of data exchange, the worst-case latency
would not be higher than in (1a). And regarding _transparency_ and
_flexibility_ this might the favorite solution.
-------------

Depending on individual requirements, each alternative should be
possible. Regarding my understanding for the implementation of Xenomai,
the realization of option (3) is currently not possible when real-time
conditions have to be upheld.

Again, I don't want to criticize any part of the Xenomai
implementations. Application programmers just have to be aware of using
synchronous message passing, because its behavior - in particular its
priority inversion behavior - is RTOS-implementation dependent. For me
this was not self-evident before.

I think it should be a general aim of any RTOS with
send/receive/reply-messaging API, that this behavior becomes
generalized, because this matter is an unforeseeable source of errors.
Besides, portability would be further simplified. In my concrete case it
means that I have to port an application to Xenomai, which uses the
posix skin and consists of several tasks that strongly use synchronous
message passing for intercommunication. This brings me to the conclusion
that I cannot implement an _efficient_ solution as long as the priority
inheritance behavior during synchronous message passing operations of
any skin remains as it is.

>Jan Kiszka wrote:
>If you are seriously interested in prio-inheritance for the native
>message passing API, the best you can do is to work actively on a patch
>proposal. This would
>
> - demonstrate how unintrusive this addition could be (preferably, PI
>   will be optional and use existing low-level services), while being
>   so useful for certain scenarios
>
> - accelerate the testing cycle (_you_ have the scenario at hand)
>
> - raise the chances that Xenomai gains this feature soon (core
>   developers are generally busy with many things)
>
>Posting patches early will allow you gain concrete feedback on the
>design. And we will not sit there and watch you pulling hairs while
>you're stuck. But hacking some Xenomai skin is also no black magic,
>given the well defined nucleus API. Give it a try!

I am seriously interested in priority inheritance for the message
passing API, but I don't consider myself as an expert in this field and
nor as an operating system developer. My employer/my client does not
give me time for such kind of system engineering, hence I will remain as
a user - all I can do is to tell about my desires and experiences.

Ok, now I'm coming to the end. I hope this posting was a bit interesting
for any reader and that someone goes for further words on this...

...any comment and further discussion is highly appreciated again! :-)


Torsten


