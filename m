From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A38C5D6.1050300@domain.hid>
References: <188636.66895.qm@domain.hid>
	<1245226197.1443.18.camel@domain.hid>
	<634c78ce0906170240w1ade29b0p904c3468af0866c@domain.hid>
	<4A38C5D6.1050300@domain.hid>
Content-Type: text/plain
Date: Thu, 18 Jun 2009 00:41:53 +0200
Message-Id: <1245278513.19887.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

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



