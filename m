Message-ID: <164332.23281.qm@domain.hid>
References: <188636.66895.qm@domain.hid>
	<1245226197.1443.18.camel@domain.hid>
	<634c78ce0906170240w1ade29b0p904c3468af0866c@domain.hid>
	<4A38C5D6.1050300@domain.hid> <1245278513.19887.37.camel@domain.hid>
Date: Thu, 18 Jun 2009 10:20:13 -0700 (PDT)
From: Guvenc Gulce <gulceg@domain.hid>
In-Reply-To: <1245278513.19887.37.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai-help] Native API rt_pipe_monitor() call can not be
	called from an RT Task in linux userspace ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hi all
Thanks for the replies so far. Maybe I should give some background info regarding my needs and why I have 
asked this question at the first place so that you guys may have some ideas how to solve such a situation 
in an elegant way by using the current APIs of Xenomai.

I am planning to develop a mechanism which allows me to use Linux Network Sockets(send/receive) from an RT Task 
running in linux userspace. (I am aware of the RTNet but I don't really need real timeliness and 
determinism on the wire.) What I need is that my RT Task in the userspace does not lose its real timeliness
at any cost. My Understanding is that calling Linux APIs (e.g. socket(), bind() etc.) from RT Tasks 
disturb the real timeliness of the RT task. 

Is there something already developed to meet such a need in Xenomai context ? 
If not, what would be the best way to approach such a problem ?

Here are few ideas I have :

* RT Task(Userspace) <---Connnected with RT Pipes---> Linux Task(Userspace, does the socket API calls)

The problem with this approach is that RT Pipe API is not fully available in userspace and ugly 
O(n) Algorithms should be used at some places. (Synchron/Serial pipe handling)

* RT Task(Userspace) <---Connected with Posix System Calls--> RTDM (Kernel Space) <-- RT Pipes --> 
Some other Kernel Module(Kernel space, does the Socket API calls)

I am not sure whether such an approach would work at all. Maybe RT Pipes are not necessary at all 
and RTDM can do the Linux Socket API calls, in other words, RTDM would wrap Socket API calls with 
some additional logic. Would such an approach disturb the real timeliness of the original caller RT Task? RT Task 
calls RTDM which then calls some linux stuff which may cause a switch to secondary domain ? 

There are also a lot of similar APIs in Native and Posix skins. Would it be correct to say that one 
of them can be randomly picked, if there aren't concerns of legacy code compatibility issues. They 
are somewhat confusing and it is not really clear which Skin in which case really makes sense. 
Native Skin has RT-Pipes and Queues and on the other hand Posix has only Queues. Can the Queues 
also be used for RT Task <--> Non-RT Task communication as in the case of RT Pipes ? 

Thanks in advance for the comments

Guvenc  






----- Original Message ----
From: Philippe Gerum <rpm@xenomai.org>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org
Sent: Thursday, June 18, 2009 12:41:53 AM
Subject: Re: [Xenomai-help] Native API rt_pipe_monitor() call can not be called from an RT Task in linux userspace ?

On Wed, 2009-06-17 at 12:30 +0200, Gilles Chanteperdrix wrote:
> Peter Soetens wrote:
> > On Wed, Jun 17, 2009 at 10:09, Philippe Gerum<rpm@xenomai.org> wrote:
> >> As you have probably understood already, building a full real-time to
> >> real-time data path using pipes is not possible; this said, this is not
> >> the purpose of this API anyway, which has been designed for real-time to
> >> non-RT communication.
> > 
> > I was hoping to use rt_pipe + select in real-time context to implement
> > a data receiving server for real-time inter-process communication. Is
> > this possible ?
> > What would happen if the real-time clients open the pipes as rt_pipes
> > and start sending
> > data in ? What's the alternative to listen in real-time to many
> > connections from
> > a single thread ?
> 
> Note that posix message queues already work for inter-process
> communications, with support for select. Depending on your needs, this
> may be sufficient: you will need Xenomai threads on both sides, but the
> non real-time one may use the SCHED_OTHER policy.
> 
> I was thinking, maybe we could map the xnpipe to a special flag in mq_open ?
> 

Albeit the message pipes are most of the time used in datagram mode, it
can also be used in byte stream mode, which would not fit the mq
semantics that nicely (I'm a bit afraid of potential overhead as well).

Actually, we do have a pivotal API we could use further, and this is
RTDM. We could have a set of socket-based RTDM drivers that implement
different RT communication domains for IPC, one emulating a real-time
socketpair for local IPC as you mentioned for instance, another one
would bear the message pipe semantics etc.

RTDM already complements all other APIs, so there would be no need to
extend those to get message pipes with select() support, and we could
even go as far as deprecating the existing message pipe API from the
native skin, at some point. Besides, all RTOS emulators we support work
fine side-by-side with either the POSIX or native skins, which in turn
do support the RTDM model. So basically, we write one IPC driver, it
works for the whole set of APIs we have, without any change. Maybe it's
time for ksrc/drivers/ipc or something?

-- 
Philippe.



_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help



      


