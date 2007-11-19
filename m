Message-ID: <47419F33.7040203@domain.hid>
Date: Mon, 19 Nov 2007 15:35:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE09111@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE09111@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write error: "Cannot allocate memory ";
 bug or feature ?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik.Wildenburg@domain.hid wrote:
> When running the attached programm for a while I get an "Cannot allocate =
memory" error with the function rt_queue_write.

What is the exact size of the message rt_queue_write() fails to send, as
displayed by your trace?

> I can=B4t see any obvious mistake in my code, so I don=B4t have an simple=
 explanation for this behavior but just a suspicion (see below). Could some=
body be so kind to try to reproduce this problem, so I can determine whethe=
r this is a problem of my context or of xenomai.=20
> I use Xenomai 2.3.2 with an 2.4.25 kernel on PPC.
>=20
> Or, even better, could somebody explain to me the functionality of heap a=
llocation of native queues.

Message buffers are simply obtained from a memory pool managed as a
nucleus heap. rt_queue_write() allocates a message block from the pool
to hold the emitted data, and pushes it to the pending message queue,
rt_queue_read() then pops the next available message from this queue,
copies the payload data to the user-space buffer, and frees the message
block.

I have the impression the problem of my program results from some kind
of heap fragmentation,
as I write very differnt buffersizes to a quite small queue (see code
line 59-62).
>=20

It's unlikely, since the consumer thread has absolute priority (50) over
the producer in your code (30); in such a case, the buffer pool should
only have a single busy message block at any given time.

You may want to display /proc/xenomai/registry/native/queues/qtest1q
periodically, while your test program is running, and check the usedmem
field. If it indeed decreases over time, then there is a memory leak
somewhere.

--=20
Philippe.

