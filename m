Message-ID: <4A38C5D6.1050300@domain.hid>
Date: Wed, 17 Jun 2009 12:30:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <188636.66895.qm@domain.hid>
	<1245226197.1443.18.camel@domain.hid>
	<634c78ce0906170240w1ade29b0p904c3468af0866c@domain.hid>
In-Reply-To: <634c78ce0906170240w1ade29b0p904c3468af0866c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Native API rt_pipe_monitor() call can not
 be	called from an RT Task in linux userspace ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai@xenomai.org

Peter Soetens wrote:
> On Wed, Jun 17, 2009 at 10:09, Philippe Gerum<rpm@xenomai.org> wrote:
>> As you have probably understood already, building a full real-time to
>> real-time data path using pipes is not possible; this said, this is not
>> the purpose of this API anyway, which has been designed for real-time to
>> non-RT communication.
> 
> I was hoping to use rt_pipe + select in real-time context to implement
> a data receiving server for real-time inter-process communication. Is
> this possible ?
> What would happen if the real-time clients open the pipes as rt_pipes
> and start sending
> data in ? What's the alternative to listen in real-time to many
> connections from
> a single thread ?

Note that posix message queues already work for inter-process
communications, with support for select. Depending on your needs, this
may be sufficient: you will need Xenomai threads on both sides, but the
non real-time one may use the SCHED_OTHER policy.

I was thinking, maybe we could map the xnpipe to a special flag in mq_open ?

-- 
                                          Gilles


