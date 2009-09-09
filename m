Message-ID: <4AA79BDD.8090002@domain.hid>
Date: Wed, 09 Sep 2009 14:13:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <793108.19562.qm@domain.hid>	<4AA691B8.4090204@domain.hid>	<394564.56258.qm@domain.hid>	<4AA6D85C.8040707@domain.hid>	<982599.63991.qm@domain.hid>	<4AA6DE47.8010804@domain.hid>
	<934774.26170.qm@domain.hid>
	<4AA77F8D.3090709@domain.hid> <4AA799AD.9070402@domain.hid>
	<4AA79A88.7070500@domain.hid>
In-Reply-To: <4AA79A88.7070500@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> As you do not care about determinism of the network communication, you
>>> also do not need RTnet. It would only introduce the risk that non-RT
>>> network participant overload your box. And this load would show up in
>>> the RT domain because RTnet would have to handle it.
>> You can solve that by limiting the non real-time traffic to a maximum
>> rate, and always keep some bandwidth for the real-time traffic. This is
>> a bit more complicated than nomac, but not that much. But of course if
>> you do not need packets to be sent ASAP, I agree that rtnet is overkill.
> 
> Right. But the problem, err, challenge is that this rate limiting has to
> be installed either into the switch/router that your RT box is attached
> to or into all nodes that may talk to it.

Right, you can not do this on RX traffic. But if you accept that the RT
packets have some way to be recognized (VLAN, IP TOS field, mac address,
whatever), you can configure the switches to give a higher priority to them.

-- 
                                          Gilles


