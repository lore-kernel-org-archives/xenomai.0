Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <528CCE14.2040505@xenomai.org>
Date: Wed, 16 Jul 2014 09:24:57 -0600
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA93FD47-509E-441A-AFCF-38882E2DC609@mah.priv.at>
References: <A4FA4D76-58FD-4DB4-AE7F-5B2D3D20FF35@mah.priv.at>
 <528CCE14.2040505@xenomai.org>
Subject: Re: [Xenomai] integrate event signaled by RT thread into non-RT
	event loops (poll, select, eventfd..)?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 20.11.2013 um 07:58 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:

> On 11/20/2013 03:33 PM, Michael Haberler wrote:
>> I'm looking for a simple method to post an event from an RT thread so
>> a userland non-RT thread can wait for, and pick it up via a file
>> descriptor (without switching the originating thread to primary
>> domain, of course)
>>=20
>> event context can be minimal since the userland handler can figure;
>> actual data transfer not required - event number or mask a plus
>>=20
>> purpose would be integration into existing event loops; only
>> RT->userland signalling needed
>>=20
>> if it's possible from a kernel RT context, it's a plus
>>=20
>> ---
>>=20
>> one scheme I thought of was: using rt_event services, monitor the
>> event flag in a userland shadow thread and post to an eventfd whose
>> other side could be integrated into an event loop. Making sense?
>>=20
>> thanks in advance,
>>=20
>> Michael
>>=20
>> ps: this needs to be portable across RT kernel variants; my approach
>> for RTAI would be to use rt_request_srq() and post to an eventfd from
>> the Linux context
>=20
> You may use XDDP IPC for that, see:
> =
http://www.xenomai.org/documentation/xenomai-2.6/html/api/xddp-echo_8c-exa=
mple.html

in the RT thread, I'd need to do a non-blocking read of the XDDP socket =
or test in some way if a message is present (man 2 recvfrom indicates by =
default it blocks until data available)

what would be the right/fastest way to do this - do the recvfrom() with =
the MSG_DONTWAIT option?

- Michael


