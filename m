Message-ID: <84a3d09fccb39bf9e9aec78ea5173d4a.squirrel@xenomai.org>
In-Reply-To: <CAPM60ws2F-7PFASr0MkZOn5ZqxnG=GnKUx9vwWteTZEUhxP+VQ@mail.gmail.com>
References: <CAPM60ws2F-7PFASr0MkZOn5ZqxnG=GnKUx9vwWteTZEUhxP+VQ@mail.gmail.com>
Date: Thu, 4 Dec 2014 17:43:29 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?=22C=C3=A9dric=22?= <freecedric@free.fr>
Cc: xenomai@xenomai.org


C=C3=A9dric wrote:
> Do you have the same problem ?

Yes, this is a know issue, the 16550A on BeagleBone has the same register
layout as others 16550A except that its registers offsets must be
multiplied by 4. The Beaglebone driver also access the registers using 16
bits
acccesses, although I suspect this would work as well with 32 bits accesses,
but it probably does not work with byte accesses.

Another problem is that to get that driver working you probably also need to
enable some clocks.

I said I would look into it, but have other things on my plate. Any patch to
fix this will be welcome.

Regards.

--=20
                    Gilles.


