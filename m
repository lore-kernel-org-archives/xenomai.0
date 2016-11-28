From: "Ramakrishnan, Senthil" <senthil.ramakrishnan@hp.com>
Date: Mon, 28 Nov 2016 17:50:33 +0000
Message-ID: <DF4PR84MB0299F35DC0D923F69E3A07C5F78A0@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
References: <DF4PR84MB0299F84DFCDC76FD7D360B12F7B10@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
 <a22149dd-141c-f148-113e-318f542095ae@xenomai.org>
 <DF4PR84MB0299ABE95D22EE2DF3E6F028F7B70@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
 <c44e8d9f-5be1-ab14-18ad-e67fa8718672@xenomai.org>
In-Reply-To: <c44e8d9f-5be1-ab14-18ad-e67fa8718672@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Help needed regarding compiling/installing Xenomai
 patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for the response, Philippe. We may try the prototype RTDM implementa=
tion at http://git.xenomai.org/rtdm-native.git/ you pointed out.

Regards,
Senthil

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]=20
Sent: Thursday, November 24, 2016 7:44 AM
To: Ramakrishnan, Senthil <senthil.ramakrishnan@hp.com>; xenomai@xenomai.or=
g
Subject: Re: [Xenomai] Help needed regarding compiling/installing Xenomai p=
atch

On 11/23/2016 06:13 PM, Ramakrishnan, Senthil wrote:
> Dear Philippe,
>=20
> Thanks much for the response and you answered all our questions. One more=
 question I have is if there is a Standalone RTDM patch available. Or, if i=
t's possible to apply RTDM changes alone from the Xenomai-Cobalt kernel pat=
ch.

There is a prototype implementation of a native RTDM interface at http://gi=
t.xenomai.org/rtdm-native.git/, which dates back to 2007 (Xenomai 2.2 timef=
rame). This code was neither maintained nor ported to any later Xenomai rel=
ease.

You cannot use the Cobalt incarnation of RTDM over Mercury. This implementa=
tion is specific to a dual kernel configuration, based on the Xenomai kerne=
l API.

--
Philippe.

