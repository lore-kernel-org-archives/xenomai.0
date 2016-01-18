From: Thomas Axelsson <Thomas.Axelsson@cybercom.com>
Date: Mon, 18 Jan 2016 17:39:15 +0000
Message-ID: <7b891fffe5e04fc5838f1acd8de1a7e1@mmambx3.global.ad>
References: <08349b9576164b1daad6e10748bdc0be@mmambx3.global.ad>
 <569BC5C9.9030202@xenomai.org> <569CD209.7040008@xenomai.org>
In-Reply-To: <569CD209.7040008@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai-3.0.1 inter-process rt_queue_receive segfault
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Max Popescu <Max.Popescu@cybercom.com>

> On 01/17/2016 05:48 PM, Philippe Gerum wrote:
> > On 01/15/2016 05:34 PM, Thomas Axelsson wrote:
> >> Hi,
> >>
> >> We are trying to use Alchemy RT Message Queues between two different
> >> processes in Xenomai 3.0.1. However, our receiving process segfaults
> >> when it receives a message. Using gdb, we see that the SIGSEGV occurs
> >> in
> >> rt_queue_receive_timed() when doing  "ret =3D (ssize_t)msg->size;"
> >> (queue.c:851). Can you help us solve the problem?
> >
> > The alchemy code is wrong, it should use offset-based references in
> > this case since the message crosses address spaces. I will have a look
> > and suggest a patch for testing. Thanks for reporting.
> >
>=20
> Please pull from the stable-3.0.x branch, the commits below should fix th=
e
> issue:
>=20
> c23b72e alchemy/queue: disable buffer-to-buffer transfer in broadcast
> mode
> fef8ca3 alchemy/queue: care for messages crossing address spaces fa4cdcc
> boilerplate/scope: add helpers for nullable reference
>=20
> --
> Philippe.

We can confirm that the new code fixes the issue. Thanks!

//Thomas

