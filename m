Message-ID: <4AA777C9.2010301@domain.hid>
Date: Wed, 09 Sep 2009 11:39:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <793108.19562.qm@domain.hid>	<4AA691B8.4090204@domain.hid>	<394564.56258.qm@domain.hid>	<4AA6D85C.8040707@domain.hid>	<982599.63991.qm@domain.hid>	<4AA6DE47.8010804@domain.hid>	<934774.26170.qm@domain.hid>	<4AA76628.3080901@domain.hid>
	<563297.36460.qm@domain.hid>
In-Reply-To: <563297.36460.qm@domain.hid>
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
> How can I do that with rt_net ? Any pointers, any examples ? rt_net documentation 
> talks about the hard real-timeliness on the wire.. can I separate rt_net and rt_mac ? 
> I don't need real-timeliness on the wire why should I pollute my Network 
> with the MAC level ethernet packets sent by rt_mac to guarantee the 
> real-timeliness which I don't need ?

Use the nomac module. But it is true that it is not really what rtnet
was designed to do, which is probably why it is not documented.

-- 
                                          Gilles


