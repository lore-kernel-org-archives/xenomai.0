From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 2 Feb 2009 16:54:49 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2004E3E954FF@us194mx002.tycoelectronics.net>
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<200901071828.31323.Sebastian.Smolorz@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>
	<4965D651.5010808@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
	<496605F2.1080306@domain.hid>
In-Reply-To: <496605F2.1080306@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Socketcan-users] rtcanconfig rtcansend rtcanrecv
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Oliver Hartkopp <socketcan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

Thank you for the tip.  I need to add the socketcan drivers to my linux ker=
nel.  I have linux-2.6.27.7 currently patched for xenomai-2.4.6.1 to which =
I added a rtcan_tscan1.c module to support the TS_CAN1 interface I am using=
.  It looks like the rtcan modules only support CAN_RAW frames and I would =
like to use your IP point to point tunnel and other utils so I can send IP =
packets over the CAN interface for performance testing.  I built the linux =
kernel using OpenEmbedded cross compiler based on the org.openembedded.stab=
le angstrom-2007.1 build but I am currently building org.openembedded.dev u=
sing the angstrom-2008-1 distro.

In your README.isotp at http://svn.berlios.de/svnroot/repos/socketcan/trunk=
/README.isotp
You say that you got 27kbyte/sec which translates to 0.216Mbit/sec so that =
suggests about 2 times that with a 1 Mbit/sec CAN bus.

--John

-----Original Message-----
From: Oliver Hartkopp [mailto:socketcan@domain.hid
Sent: Thursday, January 08, 2009 8:56 AM
To: Charlton, John
Cc: Sebastian Smolorz; xenomai@xenomai.org; socketcan-users@domain.hid.=
de
Subject: Re: [Socketcan-users] [Xenomai-help] rtcanconfig rtcansend rtcanre=
cv

Charlton, John wrote:
> Since my primary goal at present is to test and compare CAN IP performanc=
e with ethernet IP performance, I am going to shift to the lincan driver.  =
We are planning to use xenomai in the near future so I would like to fix th=
e rtcan_tscan1.c module to work correctly.
>
>

> Sebastian Smolorz wrote:
>
>
> However, as Wolfgang already suggested, there is at least one driver avai=
lable for plain Linux which should work with your CAN controller. If you te=
sted this driver successfully you could take a look into its source to get =
further hints for your Xenomai driver.
>

Hi John,

i don't know what your planning to test with IP over CAN but i implemented =
a proof-of-concept for an IP tunnel over ISO-TP (ISO
15765-2) on CAN. This is on plain (non-RT) Linux 2.6 and available in the S=
ocketCAN SVN (source and tools).

Maybe you would like to take a look on it:

http://svn.berlios.de/svnroot/repos/socketcan/trunk/README.isotp

Regards,
Oliver


