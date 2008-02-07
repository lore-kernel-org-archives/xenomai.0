Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 7 Feb 2008 14:40:32 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB02AF4D89@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3769DF@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D3769D5@domain.hid><2ff1a98a0802070043n7c78e397i9345f3de1229f6bf@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769DF@slcmail.slc.mew.int>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] SIGTRAP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

How do you debug ? Are you using remote debugger or native debugger on
target ? Which debugger version and glibc version are you using ? And
which kernel ?

Ciao,

Daniel.

Steven Seeger wrote:
> That's what I thought, but I randomly get one and the application
> dies while debugging. I don't even have breakpoints set. I just hope
> to see where it crashes. =20
>=20
> Steven
>=20
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Thursday, February 07, 2008 1:44 AM
>> To: Steven Seeger
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] SIGTRAP
>>=20
>> On Thu, Feb 7, 2008 at 5:19 AM, Steven Seeger
>> <sseeger@domain.hid> wrote:
>>>=20
>>>=20
>>>=20
>>>=20
>>> Is there anything that would cause me to get spurious SIGTRAPs
>>> while running a xenomai app in userspace?
>>=20
>> AFAIK, SIGTRAP is an internal signal used when debugging.
>>=20
>> --
>>                                                Gilles Chanteperdrix
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--=20
                                 |
                                 | www.marel.com
Tel: +354 563 8000 Fax: +354 563 8001
Iceland

