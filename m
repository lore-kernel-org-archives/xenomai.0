Message-ID: <4AA77F8D.3090709@domain.hid>
Date: Wed, 09 Sep 2009 12:12:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <793108.19562.qm@domain.hid>	<4AA691B8.4090204@domain.hid>	<394564.56258.qm@domain.hid>	<4AA6D85C.8040707@domain.hid>	<982599.63991.qm@domain.hid>	<4AA6DE47.8010804@domain.hid>
	<934774.26170.qm@domain.hid>
In-Reply-To: <934774.26170.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: xenomai@xenomai.org

Guvenc Gulce wrote:
> rt_net is nice but then all network participants have to use rt_net otherwise 
> the realtime communication is not guaranteed on the wire.. in some cases 
> the real-timeliness on the wire may not be needed but the determinism 
> of the rt-task may still be an issue..
> 
> I think it is a great flexibility to give an rt task the chance to communicate 
> with non rt_net clients and servers in the network without worrying about 
> losing its determinism. 

To achieve this, you just need to set up a low-prio Xenomai server task
that accepts to-be-transmitted data from the RT task sends it out,
collects replies and dispatches them back to the sender. You may use
queues or shared memory as IPC mechanisms for the RT<->proxy
communication. They just have to be Xenomai provided. The effect will be
that the proxy is switching back and forth between primary (Xenomai) and
secondary (Linux) mode, but your RT task will stay in primary mode.

As you do not care about determinism of the network communication, you
also do not need RTnet. It would only introduce the risk that non-RT
network participant overload your box. And this load would show up in
the RT domain because RTnet would have to handle it.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

