Message-ID: <563297.36460.qm@domain.hid>
References: <793108.19562.qm@domain.hid>
	<4AA691B8.4090204@domain.hid>
	<394564.56258.qm@domain.hid>
	<4AA6D85C.8040707@domain.hid>
	<982599.63991.qm@domain.hid>
	<4AA6DE47.8010804@domain.hid>
	<934774.26170.qm@domain.hid>
	<4AA76628.3080901@domain.hid>
Date: Wed, 9 Sep 2009 02:26:53 -0700 (PDT)
From: Guvenc Gulce <gulceg@domain.hid>
In-Reply-To: <4AA76628.3080901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: xenomai@xenomai.org

How can I do that with rt_net ? Any pointers, any examples ? rt_net documentation 
talks about the hard real-timeliness on the wire.. can I separate rt_net and rt_mac ? 
I don't need real-timeliness on the wire why should I pollute my Network 
with the MAC level ethernet packets sent by rt_mac to guarantee the 
real-timeliness which I don't need ?

Guvenc

 



----- Original Message ----
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: xenomai@xenomai.org
Sent: Wednesday, September 9, 2009 10:24:08 AM
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue

Guvenc Gulce wrote:
> rt_net is nice but then all network participants have to use rt_net otherwise 
> the realtime communication is not guaranteed on the wire.. in some cases 
> the real-timeliness on the wire may not be needed but the determinism 
> of the rt-task may still be an issue..
> 
> I think it is a great flexibility to give an rt task the chance to communicate 
> with non rt_net clients and servers in the network without worrying about 
> losing its determinism. 

You can do that with rtnet.

-- 
                                          Gilles


      


