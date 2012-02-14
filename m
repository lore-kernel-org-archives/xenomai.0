Message-ID: <4F3AAA52.6060802@domain.hid>
Date: Tue, 14 Feb 2012 19:39:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
In-Reply-To: <CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Freeze while running examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?T3NjYXIgRMOhdmlsYQ==?= <odavilar@domain.hid>
Cc: xenomai@xenomai.org

On 02/14/2012 06:54 PM, Oscar D=C3=A1vila wrote:
> I compiled Xenomai succesfully, but when i try to run an example it fre=
ezes
> / machine look up, any help will be apreciated, thanks.
>=20
> Here is some info about the system, its a Debian 6.0 with a
> kernel 2.6.35.9, xenomai-2.6.0, the adeos
> patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the
> nmi_watchdog=3D2 in the boot kernel options.

Please reproduce the bug:
- in text mode, so as to have the full bug trace;
- with frame pointers enabled;
- with highest kernel verbosity for BUGs and backtraces.

And post the full bug text here.

Alternatively, if you have another computer, you can redirect the
console on a serial port (see Documentation/serial-console.txt in the
kernel sources) or via network (see
Documentation/networking/netconsole.txt in the kernel sources). This
will allow handling traces which are larger than a screen.

--=20
					    Gilles.


