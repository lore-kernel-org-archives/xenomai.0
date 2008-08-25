Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Aug 2008 08:30:53 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E564324F6@domain.hid>
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
	<48ABEF11.6060307@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
	<48AC6BA0.9010306@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56432274@domain.hid>
	<48AF0378.3030001@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello Philippe,

<<
Both the maintenance and the -devel branches have been updated with
changes that make the non-RT write side block until enough memory is
available from the pool (unless O_NONBLOCK is set). The work-around will
still work, but the return value from the NOBUF event handler is now
discarded; the nucleus will retry to get memory automatically.
>>
Thanks.

<<
cookie args are prone to clutter the API and introduce useless overhead
for carrying them, therefore we don't want to=20
add more of them. The preferred way is something like: ...
>>
Yes, you are right, I will update my code following your advice.  Thanks
for investigating my case.

Best regards,
Filip

