Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel OOps large appl.
Date: Tue, 31 Oct 2006 13:57:21 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D6B9@domain.hid>
In-Reply-To: <1162302894.4996.81.camel@domain.hid>
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

Philippe Gerum wrote:

> Mm, 2.3-devel, so there is no UVM in the picture since the latter
> support has been removed from the trunk/ in favour of the direct
> syscall interfaces. But then, how do you emulate pSOS? Using your own
> POSIX-based emulator (i.e. _not_ Xenomai's pSOS skin)?  =20

No, we are simply not using any pSOS call at all. We replaced everything
with POSIX calls. The remark about pSOS was just a hint from which
background the application is coming.

Regards,

Daniel.

