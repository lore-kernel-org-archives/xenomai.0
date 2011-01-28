From: "Wayne Call" <wcall@domain.hid>
Date: Fri, 28 Jan 2011 13:27:53 -0700
Message-ID: <002601cbbf29$d77f4e40$867deac0$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0027_01CBBEEF.2B207640"
Content-Language: en-us
Subject: [Xenomai-help] RT context
Reply-To: wcall@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

This is a multi-part message in MIME format.

------=_NextPart_000_0027_01CBBEEF.2B207640
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

In the heartbeat example, there is the following comment:

 

                /* Note: The I-pipe patch for blackfin ensures that
gpio_set_value

                * (among other services) can safely be called from RT
context. */

 

So this states that the gpio_set_value can be called from an RT context.

 

What about an I2C driver, or an SPI driver?  There are linux kernel drivers
to support these devices.  Does it make sense to continue to use these
drivers in the linux kernel, and somehow have an RT context that can tap
into this data?  Does an RT context take precedence over the linux kernel
I2C and SPI drivers?  The Xenomai is its own kernel and somehow interacts
and works together with the linux kernel.  Do I have to re-structure a linux
kernel I2C driver completely into a Xenomai I2C driver?

 

In the past I have written a linux kernel driver on top of the I2C driver to
collect I2C data into a buffer.  I also wrote a Xenomai driver that makes
calls into this top level linux kernel I2C driver to get the data.  And
there is a Xenomai user application, running an RT context, that gets the
data from the Xenomai driver.

 

Is there a particular strategy I should be using for the I2C and SPI
interfaces?

 

Wayne

 

 


------=_NextPart_000_0027_01CBBEEF.2B207640
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>In the =
heartbeat example, there is the following comment:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Note: The I-pipe patch for =
blackfin ensures that gpio_set_value<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  * (among other services) can safely =
be called from RT context. */<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>So this =
states that the gpio_set_value can be called from an RT =
context.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>What about an I2C driver, or an SPI driver?&nbsp; =
There are linux kernel drivers to support these devices.&nbsp; Does it =
make sense to continue to use these drivers in the linux kernel, and =
somehow have an RT context that can tap into this data?&nbsp; Does an RT =
context take precedence over the linux kernel I2C and SPI drivers?&nbsp; =
The Xenomai is its own kernel and somehow interacts and works together =
with the linux kernel.&nbsp; Do I have to re-structure a linux kernel =
I2C driver completely into a Xenomai I2C driver?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>In the past =
I have written a linux kernel driver on top of the I2C driver to collect =
I2C data into a buffer.&nbsp; I also wrote a Xenomai driver that makes =
calls into this top level linux kernel I2C driver to get the data.&nbsp; =
And there is a Xenomai user application, running an RT context, that =
gets the data from the Xenomai driver.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Is there a =
particular strategy I should be using for the I2C and SPI =
interfaces?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Wayne<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_0027_01CBBEEF.2B207640--


