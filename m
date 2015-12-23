MIME-Version: 1.0
In-Reply-To: <56795E20.1010102@isc.cnr.it>
References: <56795E20.1010102@isc.cnr.it>
Date: Wed, 23 Dec 2015 16:45:00 +0100
Message-ID: <CAPydA0Hb73k0kO_ueqVnTMeDCxpffDeU0AEUWxZFBKbG9RCY1Q@mail.gmail.com>
From: Orestes Mas <masorestes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Programming Xenomai+analogy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

If you know some french, you may have useful the book "Solutions temps r=C3=
=A9el
sous Linux"  [1]. The book itself is not free, but examples are available
on its web site (I've no relation with its author).

It covers Xenomai at a basic level, among other basic realtime programming
concepts.

[1] http://www.blaess.fr/christophe/livres/solutions-temps-reel-sous-linux/

Regards,

Orestes.

On Tue, Dec 22, 2015 at 3:28 PM, GianPiero Puccioni <
gianpiero.puccioni@isc.cnr.it> wrote:

> Hi,
>
> I am trying to use xenomai to accomplish a, I think, simple task, but I
> have never used real time programs before so I have some problems.
>
> What I need is to use a  National Instruments PCI-MIO-16E-4 AD/DA to
> read data from the AD, do some simple operations on it, and output the
> result on the DA at the fastest possible frequency, with as little jitter
> as possible.
>
> I set up a machine for this with Xenomai3 (cobalt) and everything seems t=
o
> work.
> I can run "latency" with max latency around 3-4 us. the analogy
> libraries are installed, the board is recognized and the test programs
> are able to read and write to it.
>
> The problem is how to write a realtime program for this task. Is there
>  documentation at the basic level on howto do that or some place where I
> can find examples for similar programs?
>
> Thanks,
>
> GianPiero
> --
> GianPiero Puccioni               |Istituto dei Sistemi Complessi-CNR
> gianpiero.puccioni@isc.cnr.it    |Via Madonna del Piano, 10
> T:+39 0555226682 F:+39 0555226683|50019 Sesto F. (Firenze) ITALY
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>
