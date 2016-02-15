MIME-Version: 1.0
In-Reply-To: <20160215125941.GD9903@hermes.click-hack.org>
References: <CAMgLWPm3z5h-aLw5X5LdU+6ULQoqHTN2ebwR0Y4=z1F+qFVsKA@mail.gmail.com>
 <20160215125941.GD9903@hermes.click-hack.org>
Date: Mon, 15 Feb 2016 14:37:23 +0100
Message-ID: <CAMgLWPk0iR9OgAWOm1EzyHvmGS2O2T98WAtR6YZQv4+HxgugnA@mail.gmail.com>
From: "GEORGE, Laurent" <laurent.george@esiee.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Problem with rt_igb driver for I210 card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>"It does not work" is a bit vague. Do you wait for the link to be up
>before sending the solicit? Does it return an error? Does it
>send a packet but receive no answer? Some other case?

Some precisions on the problem:

1) I load all the required modules (like rtnet, rt_igb, etc)- No error
2) I make the rteth0 interface up - No error
3) rtifconfig -a shows rteth0 interface - No error
4) I then run ./rtroute solicit ip_address dev rteth0 - No Error
5) I then check whether the device is solicited using ./rtroute - Error (It
doesn't show that IP which I had just solicited - In normal Conditions, it
shows when there is no error)

Best regards,
Laurent.


2016-02-15 13:59 GMT+01:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On Mon, Feb 15, 2016 at 01:48:57PM +0100, GEORGE, Laurent wrote:
> > Hi,
> >
> > I have dowloaded and tested the stable version of Xenoma=C3=AF 3 includ=
ing a
> > support for the I210 (Intel) card, available at the following git:
> >
> >
> https://git.xenomai.org/xenomai-3.git/commit/?h=3Dnext&id=3D8268c5e87cf0a=
c5223d98a86918b9420a0e94382
> >
> > I have the following problem:
> >
> > The Installation of Xenomai went well. When I load rt_igb.ko module, th=
e
> > rteth0 interface for Intel i210 NIC goes up well but there are followin=
g
> 2
> > issues:
> >
> > a) when I try the rtsolicit command to add devices in network, it doesn=
't
> > work
>
> "It does not work" is a bit vague. Do you wait for the link to be up
> before sending the solicit? Does it return an error? Does it
> send a packet but receive no answer? Some other case?
>
> > b) When I try to remove rt_igb module after taking down rteth0 interfac=
e
> it
> > hangs and the only way to get back is a hard restart by pressing the
> > restart button on PC.
>
> Maybe the kernel crashed and capturing the console ideally via
> serial port, failing that via netconsole would help?
>
> Regards.
>
> --
>                                             Gilles.
> https://click-hack.org
>
