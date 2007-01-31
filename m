Message-Id: <s5c0a36c.096@domain.hid>
Date: Wed, 31 Jan 2007 14:12:02 +0100
From: "Marc LE DOUARAIN" <m.ledouarain@domain.hid>
Subject: =?ISO-8859-1?Q?R=E9p.=20:=20[Xenomai-help]=20ISA/PC-104=20interf?=
	=?ISO-8859-1?Q?acing?=
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, imranbashirbhatti@domain.hid

Perhaps because it is quite easy to read/write to i/o of an ISA card...

I am here talking of the easiest way, without making a driver, when you =
just have to read/write some registers of a specific hardware directly in =
your application:

First you must let your application to access to the addresses required =
with
	ioperm( start_adress, lenght, 1 );
OR
	iopl(3);

Secondly, to read :

value =3D inb( address );

and to write :

outb( value, address);


Voil=E0 !


>>> mani bhatti <imranbashirbhatti@domain.hid> 24.01 18:04 >>>
Hi all
If any one can please tell me some sources about ISA  interfacing and =
programming i would be very thankful because there are only few resources =
and the resources which are available are not very helpful and friendly =
written,Some simple examples would be really helpful.Thanks.

=20
---------------------------------
It's here! Your new message!
Get new email alerts with the free Yahoo! Toolbar.


