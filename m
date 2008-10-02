Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 2 Oct 2008 16:54:15 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F48E4DB5C@trillian.at.omicron.at>
In-Reply-To: <48E48A06.70408@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

> -----Original Message----- From: Gilles Chanteperdrix
>=20
> found the reason for the crash. The system seems to run stable now.
> Here comes the patch.

Great work!

> Could you test it and confirm that there is no problem for you ?

I back ported the patch to 2.6.21 and ran it on an NSLU. I did not see
any trouble. I ran my three "production" user space programs and ran,
at the same time:

    while [ 1 ]; do find /; cat /dev/mem > /dev/null; done

Can you post your stress-testing script?

I will test the new patch on my four other, different IXP boards.

I will have to study the patch to understand what the trouble
was. Perhaps you can explain it a bit?

In any case, I found one huge error in the patch...you mangled my name
;)

+ * Copyright:   (C) 2001, 2002 Adam Wiggins <awiggins@domain.hid>
+ *              (C) 2007 Sebastian Smolorz <ssm@domain.hid>
+ *              (C) 2008 Richard Co            if (next)
+chran
+ *

Richard

