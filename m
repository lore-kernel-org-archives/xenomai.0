Message-ID: <4A38BC7D.9090301@domain.hid>
Date: Wed, 17 Jun 2009 11:50:53 +0200
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

No, currently, select works with posix skin descriptors and RTDM
descriptors, and rt-pipes is a native skin interface, both were not
meant to be mixed.

So, there are several ways to fix this:
- add a mapping of the xnpipe API to the posix skin (or RTDM), I do not
really know how to do this, probably the best thing would be a special
kind of socketpair, which returns both descriptors;
- add a mapping of the xnselect API to the native skin, this would allow
us the freedom to implement an interface without the long scan of the
fd_set in application which scales badly, though scalability may not be
an issue with select due to the limit of 1024 descriptors;
- have a great unified file descriptor support, which would allow to mix
interfaces.

> What would happen if the real-time clients open the pipes as rt_pipes
> and start sending
> data in ? What's the alternative to listen in real-time to many
> connections from
> a single thread ?
> 
> Peter
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
                                          Gilles


