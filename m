Message-ID: <4E4E29DB.3070904@domain.hid>
Date: Fri, 19 Aug 2011 11:16:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>
In-Reply-To: <CAHoMn5rnGNWdfOCkdSX_E=v=3gxxZ+Mm8AM69J5Togg6-aSpXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] building xenomai for AT91SAM9263
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yi zheng <yizheng23@domain.hid>
Cc: xenomai@xenomai.org

On 08/19/2011 07:29 AM, yi zheng wrote:
> Hi,all
>       i am a newer to xenomai.Now i want to build xenomai for my target=

> platform with AT91SAM9263 ARM and linux kernel vision 2.6.25.I use
> arm-linux-gcc 3.4.1 for compiler,
> is it suitable for build
> xenomai=EF=BC=9Fwhich xenomai vision is better for me?

Xenomai 2.5.6 is the latest stable release, it should work. But I-pipe
patches for later linux kernel releases have support for FCSE, which
greatly improves latencies. As for the version of gcc, I have only been
using gcc 4 for a long time.

--=20
					    Gilles.


