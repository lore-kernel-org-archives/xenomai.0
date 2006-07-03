Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2
Date: Mon, 3 Jul 2006 18:26:07 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A6677E@ILEX5.IL.NDS.COM>
From: "Landau, Bracha" <BLandau@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

The patch works, thanks.

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Monday, July 03, 2006 4:15 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2


Landau, Bracha wrote:
 > As you suggested, I've upgraded to xenomai 2.2 rc3.
 > I still see the same phenomenon.
 > I'm attaching code that will reproduce the error.
 > (When you ^c out of the main loop, the pthread_cleanup_pop is called, =
and the call to pthread_mutex_destroy returns 0x10.)

Thanks for the piece of code. The error was due to a missing
initialization, that got unseen under simulation because simulator
allocated memory was always zero. It is now fixed in the repository. You
can apply the attached patch to 2.2 rc3 to fix it.

--=20


					    Gilles Chanteperdrix.

*** NDS IL IT scanned this email for malicious content ***
*** IMPORTANT: Do not open attachments from unrecognized senders  ***
*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

