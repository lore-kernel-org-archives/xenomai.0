Message-ID: <551975C4.8050501@web.de>
Date: Mon, 30 Mar 2015 18:11:48 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CADvZd9aaGmA38b+zx-jFB-0S6yn7KPEzy58kXEdX4HoyKxe=Cg@mail.gmail.com>	<CADvZd9af58_fHQYDMpQ+g3caew0_W144kCKGeCpFi7uGP3FD1A@mail.gmail.com>	<5519149C.4030505@xenomai.org>
 <CADvZd9YfYVnYQhpsS933kZ_XyG+1G0W4qYWn04weQDm3TCOZHg@mail.gmail.com>
 <55191E4E.9020803@xenomai.org>
In-Reply-To: <55191E4E.9020803@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Q: LTTNG & xenomai status
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 2015-03-30 11:58, Philippe Gerum wrote:
> On 03/30/2015 11:51 AM, Michael Haberler wrote:
>>
>>
>> 2015-03-30 11:17 GMT+02:00 Philippe Gerum <rpm@xenomai.org
>> <mailto:rpm@xenomai.org>>:
>>
>>     On 03/30/2015 10:58 AM, Michael Haberler wrote:
>>     > 2015-03-26 23:37 GMT+01:00 Michael Haberler <haberlerm@gmail.com <=
mailto:haberlerm@gmail.com>>:
>>     >
>>     >> what is the status on using LTTNG tracepoints in an RT thread? th=
e last
>>     >> discussion has been a while back, like 2010ish
>>     >>
>>     >> LTTNG 2.5.1 is in the debian jessie stream. Can I use that as-is?
>>     >>
>>     >> Any special precautions I need to take, or do the stock instructi=
ons for
>>     >> LTTNG apply?
>>     >>
>>     >
>>     > noting that CONFIG_FTRACE was disabled for performance reasons:
>>     > http://www.xenomai.org/pipermail/xenomai/2013-January/027272.html
>>     >
>>     > that would suggest *functionally* it is not an issue, and LTTng la=
yers
>>     > ontop of CONFIG_FTRACE for kernel tracing
>>     >
>>     > or am I overlooking something?
>>     >
>>
>>     Functionally it is not an issue, but the LTT core for any given LTT
>>     version might not be entirely safe for running over a kernel with
>>     pipelined interrupts. Fixing this is part of the usual process of
>>     merging LTTng and the I-pipe.
>>
>>
>> given that there is no code pertaining to LTTng in xenomai-2.6, I assume
>> you consider this the responsibility of the LTTng maintainers?
>>
>> I will inquire on the lttng-dev list, but does "usual" imply they
>> usually take care of this?
>>  =

> =

> No, this implies that people have to take care of this when they need
> it. By "usual", I mean "each time I had to do this".
> =


We used to integrate Xenomai with LTTng back then but gave up as LTTng
made no progress towards upstream and the efforts became too high. These
days you get Xenomai kernel instrumentation via ftrace, at least in 3.0.
Maybe give that a try first and then tell us what is missing.

For 2.6, we have some out-of-tree ftrace patches for x86-64 as well. Can
refresh our queue [1] if needed.

Jan

[1] http://git.xenomai.org/xenomai-jki.git/log/?h=3Dqueues/ftrace

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150330/ad27fa3=
2/attachment.sig>
