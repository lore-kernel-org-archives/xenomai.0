From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Wed, 8 Feb 2006 16:03:10 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<200602081043.47859.lbocseg@domain.hid> <43E9EEBA.1050405@domain.hid>
In-Reply-To: <43E9EEBA.1050405@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602081603.10267.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Em Quarta 08 Fevereiro 2006 11:14, Jan Kiszka escreveu:

>> ...
>> Jan, actually I didn't like the /dev/zero hack. If someone else is
>> using /dev/zero it will result in a problem... I think it would be better
>> to
>
>Why? It isn't an exclusive device. And I'm only invoking open/close on
>the original instance (which even have no handlers associated, see
>drivers/char/mem.c), mmap gets overloaded.

I'm a little confused here. I noted you have made a backup of the=20
file_operations struct and private_data. So, I've concluded, wrongly, that =

those handlers would be used by every process that called that open handler=
.=20
But, looking at the mem.c code, I think that those data (file_ops and=20
private_data) are different structs each time the user issues a call to ope=
n.=20
If that is true, I don't see any problem in using your approach. But I don'=
t=20
see neither any needs for making that backup...

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



