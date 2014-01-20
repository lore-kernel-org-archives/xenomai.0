From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Mon, 20 Jan 2014 17:18:27 +0100
References: <201401141315.38870.leo@alaxarxa.net>
 <52D54836.3070203@xenomai.org>
In-Reply-To: <52D54836.3070203@xenomai.org>
MIME-Version: 1.0
Message-Id: <201401201718.28484.leo@alaxarxa.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xddp port questions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

A Dimarts, 14 de gener de 2014, Philippe Gerum va escriure:
> On 01/14/2014 01:15 PM, Leopold Palomo-Avellaneda wrote:
> > Hi,
> >
> > in the example xddp-label a two realtime task are connected with a non-
> > realtime time. They share the same port where one rt task receive from =
the
> > non-rt task and the other send to rt-task.
> >
> > The regular thread read and write in the same devname
> > (/proc/xenomai/registry/rtipc/xddp/XDDP_PORT_LABEL). One rt thread list=
en =

from
> > that port.
> >
> > I don't understand how is possible that both (non-rt and rt threads) =

listen
> > from the same port and could not have collisions  if two threads (non-r=
t =

and
> > rt) try to write in the same port.
> >
> > Could not be better to separate it?
> >
> =

> No, that would defeat the purpose of the illustration.
> =

> XDDP is a wrapper over Xenomai's message pipe support, offering a =

> socket-based interface to applications. Each XDDP port is mapped to a =

> given /dev/rtp device minor, but the communication endpoints between RT =

> and NRT are different internally.
> =

> [XDDP-port] <---> xnpipe #<port>
>                       ^
>                       |
>                       |  * input queue:  /dev/rtp -> xnpipe
>                       |  * output queue: xnpipe -> /dev/rtp
>                       |
>                       v
>                 /dev/rtp<port>
> =

> So, when NRT reads from /dev/rtp<port>, it does not actually listen to =

> the same endpoint/queue than RT, because message pipes are =

> bi-directional. Likewise, NRT and RT never write to the same queue, =

> since the purpose of message pipes is to cross the RT/NRT domain boundary.

Ok,

in the example the same thread open a device for write and read from the sa=
me =

device. From your answer about the endpoints, I understand that when the NR=
T =

open for read, read from the RT world, and when the NRT writes to the RT =

world.

So, could I have a NRT function (thread) that open the device to just read =

from the RT world and _another_ that send to the RT world? =


Because I have to one the same device, and I don't know that I could do it =
at =

the same time.
 =

Regards,

Leopold

-- =

--
Linux User 152692
Catalonia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140120/e730351=
a/attachment.sig>
