Message-ID: <52345AE4.3010806@web.de>
Date: Sat, 14 Sep 2013 14:47:32 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CAD1EtojVmN2YVhTXswREuxaue2gzZe=Hgsxhnfksop6YRghWrA@mail.gmail.com>
In-Reply-To: <CAD1EtojVmN2YVhTXswREuxaue2gzZe=Hgsxhnfksop6YRghWrA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] cat /proc/rtcan/sockets gives "Bad address"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 2013-09-13 00:17, Daniel M. Drucker, Ph.D. wrote:
> $ cat /proc/rtcan/sockets
> cat: /proc/rtcan/sockets: Bad address
> =

> Other than this, our Xenomai and CAN systems are working just fine. This
> used to work. Any idea why we'd be getting that?

Does it fail with the most recent xenomai git version? Or with the
latest release? What is your target platform? Is there anything reported
on the kernel console as well?

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130914/38f7791=
3/attachment.pgp>
