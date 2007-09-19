Message-ID: <15570.194.114.62.37.1190205583.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0709190519i233cb94dq5e26fafb33e07262@domain.hid>
References: <31254.194.114.62.37.1190202620.squirrel@domain.hid>
	<2ff1a98a0709190519i233cb94dq5e26fafb33e07262@domain.hid>
Date: Wed, 19 Sep 2007 14:39:43 +0200 (CEST)
From: "Nadym Salem" <Kaiman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] SMI on other than intel chipsets
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

On Wed, September 19, 2007 14:19, Gilles Chanteperdrix wrote:

>> still having my latency problems, I have some general question about t=
he
>> SMI problems.
>> The SMI workaround only works with intel chipsets, because of lack of
>> documentation by other vendors, right ?
> I am pretty sure we can find VIA chipsets documentation, the SMI
> workaround only works for Intel chipset because it is the only one
> implemented, but you could implement the workaround for other
> chipsets.

Ok, I misunderstood Jan in this point...

>> Does that mean, that Xenomai can only work as a realtime system either
>> with intel chipsets or with older boards not having the SMI ?
> SMI already existed on pentium II, so the question is not the board
> age, but rather the choices made by the board manufacturer to use or
> not to use SMI.

Ok, tx for information. Should be easier to chose an intel board :)

Greets, Nadym


