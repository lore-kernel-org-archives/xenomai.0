Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] pthread_setname_np
Date: Wed, 15 Nov 2006 17:02:31 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0154F04D@is-hdq-exchange.marel.net>
In-Reply-To: <455B3B6B.1030109@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

Gilles Chanteperdrix wrote:

> The problem is that we would have to store this additional
> information in the pthread_attr_t structure. And in order to allow
> users to include and use the Xenomai API and the native pthread API
> at the same time, Xenomai use the same definition for all the
> pthread_* types as the native pthread API, and we do not know if the
> native API has room for an additional string.    =20

Which are the space constraints here ? Do we have a fixed amount of
bytes that maybe inside the pthread_t structure ? Is there a
compatibility issue to older Xenomai versions ?

I find the function pthread_attr_set_name_np() more natural than the
other function, because normally one decides upon the name of a thread
at startup time, not afterwards. Having both options should be enough
for everybody, and is somehow consistent with the VxWorks API that you
support as well.


Best regards,

Daniel Schnell.

