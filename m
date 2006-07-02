Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 2 Jul 2006 16:51:05 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A66771@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
Subject: [Xenomai-help] upgrading versions of xenomai 2.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



-----Original Message-----
From: xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid Behalf Of
xenomai-help-request@domain.hid
Sent: Friday, June 30, 2006 1:02 PM
To: xenomai@xenomai.org
Subject: Xenomai-help Digest, Vol 9, Issue 19


Send Xenomai-help mailing list submissions to
	xenomai@xenomai.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://mail.gna.org/listinfo/xenomai-help
or, via email, send a message with subject or body 'help' to
	xenomai-help-request@domain.hid

You can reach the person managing the list at
	xenomai-help-owner@domain.hid

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Xenomai-help digest..."


Today's Topics:

   1. static linking of posix demo (Roderik_Wildenburg@domain.hid)
   2. Re: static linking of posix demo (Gilles Chanteperdrix)
   3. pthread_mutex_destroy in 2.2 rc2 (Landau, Bracha)
   4. Re: pthread_mutex_destroy in 2.2 rc2 (Gilles Chanteperdrix)
   5. Re: [Adeos-main] User space,	level triggered interrupt
      (Jan Kiszka)


----------------------------------------------------------------------

Message: 1
Date: Thu, 29 Jun 2006 15:50:35 +0200
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] static linking of posix demo
To: <xenomai@xenomai.org>
Message-ID:
	<5D63919D95F87E4D9D34FF7748CE2C2A3BC849@domain.hid>
Content-Type: text/plain;	charset=3D"US-ASCII"

when I try to link the posix demo satch.c statically by inserting a
"-static" option to the LDFLAGS ( %_rt: LDFLAGS=3D -static $(LDFLAGS_RT) =
)
I get a lot of Errors about undefined references :
e.g.:
undefined reference to `__wrap_timer_settime'
relocation truncated to fit: R_PPC_REL24 __wrap_timer_settime=20

Does anybody know what I have done wrong, or is static linking not
supposed to be used.

Thank you for your help
Roderik



------------------------------

Message: 2
Date: Thu, 29 Jun 2006 17:20:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] static linking of posix demo
All,

I have encountered trouble upgrading from xenomai-2.2 rc2 to xenomai 2.2 =
rc3.
If the "prepare-script" file encounters a kernel which already has the "x=
enomai" directories included (from a previous version of xenomai), the "p=
repare-kernel" script will not do anything.

In order to bypass this problem I had to search for all the "xenomai" sub=
directories in the linux tree and rename them. (I searched for the "patch=
_link" commands inside "prepare-kernel" in order to know what had to be r=
e-patched.)

Is there a way you can indicate that you want to upgrade your kernel?

Also, for some reason I had to comment out "unset CDPATH" in the "prepare=
-kernel" script (2nd line) to get it to do anything.

Bracha



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

