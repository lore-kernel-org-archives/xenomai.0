MIME-Version: 1.0
In-Reply-To: <201010182329.02599.lux-integ@domain.hid>
References: <201010182329.02599.lux-integ@domain.hid>
Date: Tue, 19 Oct 2010 08:27:03 +0200
Message-ID: <AANLkTimE3bjw8AFTyp0oOYTEB8RTTyyoCRiJwY4UBPag@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] comeid inkernel xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luxInteg <lux-integ@domain.hid>
Cc: xenomai@xenomai.org

Hi,

No core functionalities of Xenomai will be altered but do not expect
deterministic behaviour in Comedi applications.

Keep in mind that you should disable the Analogy driver you intend to
use in Comedi (if there is one). Thus, you will be sure nothing can
happen.

Regards,

Alexis.

On Tue, Oct 19, 2010 at 12:29 AM, luxInteg <lux-integ@domain.hid> wrote:
> I am dabbling with xenomai. and kernel2.6.35.7.
> =A0QUESTION:
>
> =A0If one enables comedi in the =A0 (under staging drivers) in kernel
> compilation,
> =A0will this interfere with the functioning of xenomai?
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

