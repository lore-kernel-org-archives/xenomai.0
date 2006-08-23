Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] how to port to xenomai
Date: Wed, 23 Aug 2006 09:24:04 +0200
Message-ID: <1299EF3181B10F479D85C3280132852422DAF5@domain.hid>
In-Reply-To: <44DC3C82.3060704@domain.hid>
From: "GUARDIOLA-FALCO Sebastien 204282" <Sebastien.GUARDIOLA-FALCO@domain.hid>
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

Hi,

I'm trying to understand the better way to port my linux program to =
xenomai.
It has only one linux syscall : mmap(). To emulate this call, can I use =
native or posix skin? and how can I do (xxx_mmap()?)?
Do I have to set task mode to primary after this call?

The second issue of my code is to handle/modify task priority. In fact, =
I want to set maximum priority for the task. How do you do this with =
Xenomai?

Thanks a lot,

S=E9bastien Guardiola Falco.

