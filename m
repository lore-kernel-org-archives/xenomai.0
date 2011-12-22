Message-ID: <4EF2FFAA.7030904@domain.hid>
Date: Thu, 22 Dec 2011 11:00:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADwQ9Q49sG+7tDDaEMV0gOGBEYEuzN9y7mH5UV6MYeHpwfMgTQ@mail.gmail.com>	<4EEF222B.7050602@domain.hid>
	<CADwQ9Q5U8Eftm4ok_x_YHSAHY36ah=WsYwDcvuVzpKMdXvAjKw@domain.hid>
In-Reply-To: <CADwQ9Q5U8Eftm4ok_x_YHSAHY36ah=WsYwDcvuVzpKMdXvAjKw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to Adapt ARM I-pipe patch to S3C6410
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?6ZmI5pmT?= <chenzl92@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 12/22/2011 03:37 AM, =E9=99=88=E6=99=93 wrote:
> The kernel version is 2.6.37.6 I-pipe patch is 2.6.0-rc4,

2.6.0-rc4 is a xenomai version, not an I-pipe version. And xenomai
2.6.0-rc4 is obsolete and superseeded by xenomai 2.6.0.

I tried the
> howto ,but I couldn't find the variables and functions in irq.c ,but
> some of  the  functions and variables in time.c were here because of
> the patch.  I want to know whether all the function need to be add by
> myself ? because some of it exist when I patch the ipipe-patch.
> And the tip "Implementing a high-resolution counter.",I modified the
> CONFIG file and use the second way "Decrementer  See s3c24xx
> implementation."
> The complie work was finished with no error. Is there any patch t
> adpat  to the board?
> Thank you !

As indicated by the howto: "In the rest of this document we will call
these files time.c and irq.c, even though they may have another name for
your board. "

Anyway, irq demuxing is done differently with current versions of the
I-pipe, the howto is out of date. For each irq demux (the callbacks
registered with set_irq_chained_handler), the demux function should call
ipipe_handle_chained_irq instead of generic_handle_irq.

However, if the bug happens before start_kernel, the bug has probably
nothing to do with the modifications you made for the I-pipe. But are
you sure that the bug happens before start_kernel? Have you noted that
printk does not work as early as in start_kernel, you have to enable
early printk or use the printascii trick mentioned in the "tips and
tricks" section of the howto.

Please no private mails.

--=20
					    Gilles.


