MIME-Version: 1.0
In-Reply-To: <201010202246.40024.lux-integ@domain.hid>
References: <201010202246.40024.lux-integ@domain.hid>
Date: Thu, 21 Oct 2010 08:24:04 +0200
Message-ID: <AANLkTimV=NchWEgTt5SsSroNmF82O0Latu9ciKgmYn07@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] analogy on 9812/9112 daq cards
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

On Wed, Oct 20, 2010 at 11:46 PM, luxInteg <lux-integ@domain.hid> wrote:
> Greetings,
>
> I had a cursory non-expert =A0look at analogy and noticed the supported c=
ards
> are all by NI. =A0I want to dabble a little with =A0with xenomai and as a=
 starter
> with these two daq-cards:-
>
>
> http://www.adlinktech.com/PD/web/PD_detail.php?sg-daq&pid=3D29
>
> and
>
> http://www.adlinktech.com/PD/web/PD_detail.php?pid=3D566
>
> (both have the amcc5933 PCI intrface)
>
> is there a =A0 template =A0with =A0the needed =A0subroutines =A0( or =A0f=
unctions )
> necessary =A0have a go at writing a driver for analogy
> for devices of the above types?

A good start would be to have a look at the driver "analogy_fake"
which is just a test driver. Concerning the API for driver
development, it is described in the Doxygen doc (Modules -> Analogy
API -> Driver API -> *) at:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html

Regards,

Alexis.
>
> regards
> lusInteg
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

