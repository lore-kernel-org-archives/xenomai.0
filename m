From: Matti Suominen <matti.suominen@wapice.com>
Date: Fri, 1 Apr 2016 09:36:26 +0000
Message-ID: <b4574450a1cb4481a78b097febc538c2@EDB3.wapice.localdomain>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160331104409.GC4744@hermes.click-hack.org>
 <20160331162235.GD4744@hermes.click-hack.org>
In-Reply-To: <20160331162235.GD4744@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: =?iso-8859-1?Q?Lassi_Niemist=F6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: 31. maaliskuuta 2016 19:23
To: Matti Suominen <matti.suominen@wapice.com>
Cc: Lassi Niemist=F6 <lassi.niemisto@wapice.com>; xenomai@xenomai.org
>> TCP is disabled in Xenomai 3 rtnet. The main problem is that creating=20
>> a socket in Xenomai 3 requires switching to secondary mode, so the=20
>> "accept" service seems hard to implement without leaving primary mode.=20
>> Given the fact that TCP can not be a deterministic protocol, I planned=20
>> to drop TCP support in the next RTnet iteration.
>> If you require to send messages over TCP from a thread running in=20
>> primary mode, you should rather pass the message using an XDDP socket=20
>> to a thread running in secondary mode and using plain linux TCP=20
>> sockets. You will not get more determinism with TCP in RTnet.
>
>The question I guess, is, why do you need rttcp ? If you really need it,=20
>then we will have to find a solution for the "accept" problem.
>Keeping a pool of sockets ready for instance.
>

Sorry to hear that you are planning to drop support for rttcp. It's a=20
useful feature. TCP can be used by deterministic way if your connection is=
=20
point to point and thus retransmission is clearly a sign for error in =20
connection. Rttcp is also significantly faster than regular tcp.

For demonstration, I ran some test in a setup with rttcp client and two=20
server implementations; one rttcp and one with regular sockets. Our tests=20
are showing that average round-trip-time for same server application is=20
half when using rttcp instead of normal Linux sockets (470 =B5s vs. 960 =B5=
s).=20
Maximum rtt in our case is 4 ms for rt and easily over 10 ms for normal=20
Linux sockets. Each send/recv call with regular sockets drops to secondary=
=20
mode so there is no way the rtt maximum could be deterministic. Dropping=20
does not happen in rttcp.

In many applications it isn't a problem when accept drops to secondary=20
mode, because creating a connection surely doesn't need to be a real time=20
operation when connection serving is still real time. Of course accept=20
which drops to secondary mode is kind a blemish when you think a big=20
picture of real time kernel, but definitely isn't a reason to drop rttcp=20
away.

>From my point of view it is clearly useful feature if same application=20
(for example Modbus/TCP) can be used from rt and pc clients, and I thus do=
=20
not need to maintain two protocols.

Matti

