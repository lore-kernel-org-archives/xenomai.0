From: Dirk Roloff <roloff@domain.hid>
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
Date: Thu, 18 Mar 2004 14:11:29 +0100
References: <200403110326.33694.roloff@domain.hid> <200403130000.34021.roloff@domain.hid> <20040315085343.GA3821@domain.hid>
In-Reply-To: <20040315085343.GA3821@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200403181411.29292.roloff@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hi Vitor,

many thanks - your code works fine. And the jitters are gone after disablei=
ng the
SMI.

Also many thanks to all the other helping me to find out whats going on.
That i had never find on my own.

Dirk


Am Montag, 15. M=E4rz 2004 09:53 schrieb Vitor Angelo:
> Hi Dirk,
>
> # Any updates on INTEL 82801EB I/O Controller Hub (ICH5)
> #
> # Dirk
>
> could you please test the attached code? You should do a
>
> echo enable > /proc/smi/global
>
> and a
>
> echo disable > /proc/smi/global
>
> to test if the "global SMI bit" changes anything for you.
>
> The other entries under /proc/smi are not important, unless you want to
> test changes in BIOS or ACPI, doing a "cat /proc/smi/...". The "global
> SMI bit" should override everything.
>
> Regards,
>
> Vitor.


