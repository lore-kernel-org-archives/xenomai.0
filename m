Date: Fri, 10 Aug 2007 17:12:55 +0200 (CEST)
From: Herman Bruyninckx <Herman.Bruyninckx@domain.hid>
In-Reply-To: <000c01c7db59$181f8680$c124a986@domain.hid>
Message-ID: <Pine.LNX.4.64.0708101703480.29815@domain.hid>
References: <000c01c7db59$181f8680$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-230091106-1186758775=:29815"
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
 threads in other processes
Reply-To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Cc: xenomai@xenomai.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-230091106-1186758775=:29815
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Aug 2007, Torsten Kr=F6ger wrote:

> to summarize my discussion form yesterday:
>
> 1. I would like to implement 'real' synchronous message passing using
> the posix skin. 'Real' synchronous message passing shall mean that a
> receiver _always_ inherits the priority of the sender. Right now, I
> think this is not possible. Please let me know, if anyone knows a
> possibility.
>
> 2. 'Real' synchronous message passing could be realized with the native
> skin, because here a sender RT_TASK is able to change the priority of a
> blocked receiver RT_TASK before sending a message to it. Is this
> correct? If yes, I might consider changing the skin.
>
> 3. Is there a possibility of using the native skin and the posix skin at
> the same time?
>
> 4. I guess, it more a philosophical question: wouldn't another concept
> of send/receive/reply-messaging lead to a general avoidance of priority
> inversion? This is surely not an easy point regarding its
> implementation, but when looking at long-term aims of the Xenomai
> project, this might be a point, which worth to discuss about -
> especially when heading for distributed systems, where
> send/receive/reply-messaging is one of the key methodologies for
> real-time systems.
>
>
> Any reply posting is highly appreciated again :-)

One simple answer: if your distributed system relies on priority inversion
"solutions" and "real" synchronous message passing the way you describe,
it's a bad design!

And don't expect your RTOS to solve that bad design by adding more and more
"features", especially "priority inversion" features... Priority inversion
efficiency and determinism simply don't scale with increased distribution.

As soon as you want to use message passing in a distributed environment,
design your system such that it is _robust_ against priority inversions. if
it is not, your system will not survive future extensions, ports to newer
hardware etc.

What you want to achieve (I think) with "real" synchronous message passing
is that the receiver handles a message as soon as the sender has sent it,
right? Well, if your specification involves _really_ this form of coupling
between sender and receiver, the _only_ good solution is to serialize them
both in the same thread... Taking this discussion a bit further, this
synchronous message passing issue is key to the longlasting discussion
between micro-kerels and monolithic kernels: the former can be more
_robust_ in a distributed way but in practice don't achieve the
_efficiency_ of the monolithic kernel.

Herman

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm


--8323329-230091106-1186758775=:29815--

