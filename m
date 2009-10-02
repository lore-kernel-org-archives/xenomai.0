MIME-Version: 1.0
In-Reply-To: <4AC5E2B7.9020701@domain.hid>
References: <4AC5E2B7.9020701@domain.hid>
Date: Fri, 2 Oct 2009 13:58:45 +0200
Message-ID: <b88603c30910020458n62c14adfp4bf27b63bb801425@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] FCSE patch.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Gilles,

We are using the FCSE on our at91sam9263 boards because we need the
lowest latency. Our measurements show almost a factor of 2 in latency
reduction, which is very similar to what you presented at the XUM.

Are there any known issues with FCSE at the moment as included for the
2.6.28 kernel? Let's hope the patch gets picked up and maintained by
the kernel developers. If not, will Xenomai keep supporting it for
upcoming kernels?

And as many other, I also want to state again that I think the
XUM-2009 was very successful event! Hope to meet again next year!

Henri.

On Fri, Oct 2, 2009 at 1:23 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Hi,
>
> for those interested into the FCSE patch, as told in the paper presented
> to the XUM (but that is a detail which I forgot to mention in the
> presentation), the FCSE patch was split into several parts (10 actually)
> and submitted to the linux arm kernel mailing list.
>
> You may find the post here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001638=
.html
>
> If you use the patch and it works for you, now is the time to speak up!
>
> Thanks in advance.
> Regards.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>

