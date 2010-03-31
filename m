Message-ID: <4BB34F3A.3060105@domain.hid>
Date: Wed, 31 Mar 2010 15:33:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100331143432.44386sa8ez2p2q2o@domain.hid>
In-Reply-To: <20100331143432.44386sa8ez2p2q2o@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] netrpc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

Michel He wrote:
> Hello all,
> 
>     I'm currently trying to port xrtai-lab to xenomai, inside of it  
> there's the netrpc interface used to make communication between tasks.  
> However, there is no equivalent for Xenomai, which makes the port  
> quite impossible !

Nothing is impossible. :)

> So is there any chance to fulfill that, and with/or  
> without RTNet ? To do that, it should have something to do with socket  
> programming. Any experience encountered it is welcomed.

Well, you could start with mapping the existing RTAI API calls in
xrtai-lab on local Native calls. That will already give you a
non-distributed port.

But there is also no magic behind netrpc. It just uses RTnet for remote
calls, and that works for Xenomai at least equally well. You could
simply write a RPC API extension for libnative (a pure user space job).
That lib would do the routing, encapsulate and forward non-local calls
to some sockets provided via the RTDM API.

BTW, the same should be feasible for a POSIX-based API extension, which
would have the advantage of making the result easier portable to plain
Linux.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

