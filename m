Message-ID: <20100413101346.17138iq2ov0lt2ns@domain.hid>
Date: Tue, 13 Apr 2010 10:13:46 +0200
From: Michel He <michel.he@domain.hid>
References: <20100331143432.44386sa8ez2p2q2o@domain.hid>
	<4BB34F3A.3060105@domain.hid>
In-Reply-To: <4BB34F3A.3060105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hello Jan,

      Thank you for your answer so quickly. The last time, I find out =20
that the IPC (Xenomai) has strong correlation to the rpc =20
implementation but it lacks the network addressing. If we look into =20
the codes, we can not specifiy the remote destination in a variable =20
like the sipc_address(not existing). So I imagine that AF_IPC is =20
something purely local like the shared memory or the queues. Is it =20
possible to make a remote connection in xenomai with the ipc protocols?

thanks

Jan Kiszka <jan.kiszka@domain.hid> a =E9crit=A0:

> Michel He wrote:
>> Hello all,
>>
>>     I'm currently trying to port xrtai-lab to xenomai, inside of it
>> there's the netrpc interface used to make communication between tasks.
>> However, there is no equivalent for Xenomai, which makes the port
>> quite impossible !
>
> Nothing is impossible. :)
>
>> So is there any chance to fulfill that, and with/or
>> without RTNet ? To do that, it should have something to do with socket
>> programming. Any experience encountered it is welcomed.
>
> Well, you could start with mapping the existing RTAI API calls in
> xrtai-lab on local Native calls. That will already give you a
> non-distributed port.
>
> But there is also no magic behind netrpc. It just uses RTnet for remote
> calls, and that works for Xenomai at least equally well. You could
> simply write a RPC API extension for libnative (a pure user space job).
> That lib would do the routing, encapsulate and forward non-local calls
> to some sockets provided via the RTDM API.
>
> BTW, the same should be feasible for a POSIX-based API extension, which
> would have the advantage of making the result easier portable to plain
> Linux.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT T DE IT 1
> Corporate Competence Center Embedded Linux
>



