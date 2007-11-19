Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Nov 2007 16:11:55 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE09170@domain.hid>
In-Reply-To: <47419F33.7040203@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write error: "Cannot allocate memory ";
	bug or feature ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> > When running the attached programm for a while I get an=20
> "Cannot allocate memory" error with the function rt_queue_write.
>=20
> What is the exact size of the message rt_queue_write() fails=20
> to send, as
> displayed by your trace?

Here is the output of my programm :

WriteQueue 529 1116951692
WriteQueue 282 594405035
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :282 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 612 1291961188
WriteQueue 765 1617804041
WriteQueue 842 1781076386
WriteQueue 263 553963391
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :263 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 308 648658497
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :308 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 394 830909457
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :394 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 965 2040427517
WriteQueue 304 641396835
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :304 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 697 1472466673
WriteQueue 543 1146244746
WriteQueue 253 531620889
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :253 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 66 136664073
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :66 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 456 962746131
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :456 return : -12
---- qtest1q NMsg:0 Size:12288 used:0



As you can see I make a queue_inquire after the write fails and it
allways says "No Messages" "No Used Memory".


>=20
> Message buffers are simply obtained from a memory pool managed as a
> nucleus heap. rt_queue_write() allocates a message block from the pool
> to hold the emitted data, and pushes it to the pending message queue,
> rt_queue_read() then pops the next available message from this queue,
> copies the payload data to the user-space buffer, and frees=20
> the message
> block.

But the allocated block keeps bounded to a spezial block size and if
some other
blocksize is needed an other block is alloctated ?


>=20
> I have the impression the problem of my program results from some kind
> of heap fragmentation,
> as I write very differnt buffersizes to a quite small queue (see code
> line 59-62).
> >=20
>=20
> It's unlikely, since the consumer thread has absolute=20
> priority (50) over
> the producer in your code (30); in such a case, the buffer pool should
> only have a single busy message block at any given time.

As you can see by the queue_inquire output no messages is in the queue

>=20
> You may want to display /proc/xenomai/registry/native/queues/qtest1q
> periodically, while your test program is running, and check=20
> the usedmem
> field. If it indeed decreases over time, then there is a memory leak
> somewhere.
>=20

Again, the output from queue_inquire shows, there is no leak.=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

