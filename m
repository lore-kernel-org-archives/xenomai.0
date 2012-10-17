Message-ID: <507E05B4.2040704@xenomai.org>
Date: Wed, 17 Oct 2012 03:11:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507D7A0C.7090209@gmail.com>
In-Reply-To: <507D7A0C.7090209@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Installing Xenomai Newbie
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U2ViYXN0acOhbiBQYXZleg==?= <sebastian.pavez.t@gmail.com>
Cc: xenomai@xenomai.org

On 10/16/2012 05:15 PM, Sebasti=C3=A1n Pavez wrote:

> Hi,
>=20
> My name is Sebastian and I'm a chilean student from PUCV. Currently I=20
> have to develop a RT proyect, but the problem is that I dont have=20
> experience with Linux and a lot less with Xenomai. Nevertheless i=20
> arrived to install xenomai  2.6.0 on Ubuntu 12.04, but when I try to=20
> execute ubuntu with the xenomai kernel the screen goes black=20


Please remove "quiet" from Linux command line, and make sure that you
have all the drivers necessary for the your system to boot, including:
- video display driver
- root file system device driver
- root file system driver

--=20
                                                                Gilles.


