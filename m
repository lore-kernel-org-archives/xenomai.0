MIME-Version: 1.0
In-Reply-To: <511BEACC.5030705@xenomai.org>
References: <CAA+HEuk86rVdKy1DDWmzRGjpvNkDpVsAmG+H-R4mg1Bu2RLy+A@mail.gmail.com>
	<511BEACC.5030705@xenomai.org>
Date: Thu, 14 Feb 2013 13:32:47 -0500
Message-ID: <CAA+HEukK5Abf5V1DSu0UN+hpDBXJokdZ9aqTP6HR9wepCn6dRg@mail.gmail.com>
From: Kris Ellis <drfrankencopter@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Segfault error 4 when running latency test (and all
 userspace tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I've now tried Xenomai 2.6.2.1 over Linux 3.2.21 using buildroot, and get
the same result.

The only difference is now dmesg | grep Xenomai shows me v2.6.2.1 (Day At
The Beach) instead of 2.6.1 (Light Years Away)

Still get a segfault. Has anyone had success using buildroot to build a
Xenomai system?

Cheers

Kris

On Wed, Feb 13, 2013 at 2:34 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/13/2013 03:26 PM, Kris Ellis wrote:
>
> > Hi All,
> >
> >
> >
> > I=92m using buildroot to build and configure Xenomai 2.6.1 on Linux 3.2=
.21
> > for an Intel Atom based single board computer.
>
>
> Please try Xenomai 2.6.2.1
>
> --
>                                                                 Gilles.
>
>
