Message-ID: <fd6a47a90602220529l42118430u@domain.hid>
Date: Wed, 22 Feb 2006 14:29:40 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25_13421988.1140614980174"
Subject: [Xenomai-help] Accessing the dev_private field of the RTDM driver
	context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_25_13421988.1140614980174
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The dev_private data field of an rtdm_dev_context is defined as char[0]. Ho=
w
do I access such a field properly (given the fact that I defined a nonzero
context_size in the rtdm_device structure during driver registration) ?

E.g. trying to do:

(struct my_struct *)context->dev_private =3D NULL;

results in:

error: incompatible types in assignment

I _am_ able to compare though:

if ((struct my_struct *)context->dev_private =3D=3D NULL)
...

seems to compile fine.


Jeroen.

------=_Part_25_13421988.1140614980174
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The dev_private data field of an rtdm_dev_context is defined as
char[0]. How do I access such a field properly (given the fact that I
defined a nonzero context_size in the rtdm_device structure during
driver registration) ?<br>
<br>
E.g. trying to do:<br>
<br>
(struct my_struct *)context-&gt;dev_private =3D NULL;<br>
<br>
results in:<br>
<br>
error: incompatible types in assignment<br>
<br>
I _am_ able to compare though:<br>
<br>
if ((struct my_struct *)context-&gt;dev_private =3D=3D NULL)<br>
...<br>
<br>
seems to compile fine.<br>
<br>
<br>
Jeroen.<br>

------=_Part_25_13421988.1140614980174--

