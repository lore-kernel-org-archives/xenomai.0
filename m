Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Feb 2009 16:10:44 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F704346@domain.hid>
In-Reply-To: <498B0BC5.3060808@domain.hid>
References: <4B3F8896E1733D4787DDB0EA1C7FF91F6B58D5@domain.hid>
	<4988830A.7070800@domain.hid>
	<4B3F8896E1733D4787DDB0EA1C7FF91F6B58DC@ukmail.uk.wirelessworld.airvananet.com>
	<498B0BC5.3060808@domain.hid>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: Re: [Xenomai-help] IRQ reservation and config
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

> Mike McTernan wrote:
> > Hi,
> >=20
> > Right - I want the interrupt to be handled in realtime.
> >=20
> > Is there a way to configure the interrupt as level sensitive under
> > Xenomai?  I can't see how to do it, hence the thought of using
> > request_irq(), which can do that.
> >
>
> rtdm_irq_request() assumes that the platform-dependent code did set
the
> correct IRQ type/sense already.

Cool.  So I think you are saying it is valid to first request_irq() to
setup and config the interrupt, then hook it with rtdm_irq_request() for
the realtime handler afterwards.=20

I was unsure about mixing calls to the rtdm with the normal APIs, but it
sounds like in this case it is not a problem and the recommended method.

Many Thanks,

Mike


