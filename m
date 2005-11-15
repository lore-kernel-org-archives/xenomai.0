Message-ID: <437A0FAF.5050303@domain.hid>
Date: Tue, 15 Nov 2005 17:41:19 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>	<4378B391.5030306@domain.hid>
	<4378B824.5050708@domain.hid> <4379E194.2050202@domain.hid>
In-Reply-To: <4379E194.2050202@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: [Xenomai-core] More on rt pipes usage
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Philippe Gerum wrote:

> Ignacio Garc=EDa P=E9rez wrote:
>
>> Hi,
>>
>> Suppose I have a kernel rt task that samples data at a certain rate and
>> writes it as messages into a rt pipe, from which it is read by a user
>> space non rt program.
>>
>> I want to limit the number of messages that are put into the pipe,
>> because otherwise if the user space program dies, it will grow endlessly
>> till it exausts the rt heap.
>>
>> What I want to do is to have a pipe that can hold a limited number of
>> messages such that rt_pipe_write will fail if it is full.
>>
>> Is there a way to know how many messages are there in the pipe?
>>
>> Even if there is a way, to prevent a (harmless) race condition, I would
>> need to lock the pipe between checking the number of messages and
>> calling rt_pipe_write. As far as I know, pipe locking belongs to the
>> nucleus and I'd like to stay in the native skin as much as possible.
>>
>> Another method would be to count how many messages I write, but then I'd
>> need some hook that notifies me when the user space program reads a
>> message so I can decrement the count.
>>
>> Any ideas?
>
>
> The plan is to be able to tell the pipe manager to use a user-provided
> heap instead of the system one; this way, exhausting the local heap
> (*) in RT space would be a clear sign that non-RT must be allowed to
> consume the pending data first. A simple interface to do that is
> missing, but the pipe manager already works with a variable heap pointer.

That mechanism would work only if you allow a local heap for *each* pipe
(otherwise one abused pipe may clobber others).

Personally, I need this feature to manage extreme error cases (the user
process dying). There is no point in knowing when the non-RT processing
is overwhelmed, because if that happens there is nothing you can do.

If you are producing more RT data that your non-RT processes can
consume, then you'll exhaust storage sooner or later. If you have RT
data production peaks, it's your responsibility to allocate enough
storage to provide for the worst case.

In other words. RT processes may *never* have to wait for non-RT
processes, because then they would become also non-RT.

So, the only use I can think of for limited pipe storage (be it in
message count or used memory) is to detect fatal error conditions, such
as the case of no one consuming data. And at least in my case, I
absolutely need this feature (if the non-RT process dies for any reason,
the system must not collapse).

>
> (*) Using the overall available memory seems a better metric than the
> number of pending messages, since it may often happen that messages
> have different sizes.
>
Mmm... yeah, you are probably right. I mentioned the number of messages
because I noticed the elems field in the queue structure and though it
would be easier to implement using it.

However, being this limitation just an "electric fence" for out of hand
scenarios, the way you express the limit is not critial. If no one is
consuming data from non-RT space, the limit will be reached no matter if
you express it as messages or as memory.

Nacho.



