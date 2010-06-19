Message-ID: <4C1C8796.1050900@domain.hid>
Date: Sat, 19 Jun 2010 11:02:14 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTinRyxZ-BB_VwB2XPYwIPik8to_eynd-c-nNulQ1@domain.hid>	<4C19EDA4.2030601@domain.hid>
	<4C1A040F.4030209@domain.hid>	<AANLkTikMtR9kMd424sXIUdULJlaRxKIlJ19ElJ4Pt4o1@domain.hid>	<C159A093-EA69-4903-8114-145C4355A0C0@domain.hid>
	<AANLkTim91ABqsvWb_GqMhOwnDlIQNfz1qoE-ABWc3KGE@mail.gmail.com>
In-Reply-To: <AANLkTim91ABqsvWb_GqMhOwnDlIQNfz1qoE-ABWc3KGE@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] application make file
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org, Bruno Rouchouse <brouchouse@domain.hid>

On 06/19/2010 09:34 AM, Everett Wang wrote:
> On Fri, Jun 18, 2010 at 7:40 PM, Bruno Rouchouse <brouchouse@domain.hid> =
wrote:
>> Hi,
>> if you haven't found it yet and if I understood correctly your question,
>> xeno-config is probably what you need here ;)
>> "xeno-config
>> is a script that is used to to display the compiler and linker flags tha=
t are required for building applications that use Xenomai."
>> Regards,
>> --Bruno
>> Le 17 juin 2010 =E0 17:39, Everett Wang a =E9crit :
>>
>> On Thu, Jun 17, 2010 at 7:16 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>
>> Gilles Chanteperdrix wrote:
>>
>> Everett Wang wrote:
>>
>> Hi All,
>>
>> Now my application based user space xenomai has a few files and I want
>>
>> to construct a Makefile to compile them. I looked at the
>>
>> Makefiles in examples folder. It is not straight forward to modify one
>>
>> for myself. I have c files and header files.  It is possible to get
>>
>> a makefile with minor changes so it can automatically find the
>>
>> dependence of c and h files?
>>
>> You can do this quite easily with GNU make.
>>
>> Namely:
>>
>> http://www.gnu.org/software/make/manual/html_node/Automatic-Prerequisite=
s.html#Automatic-Prerequisites
>>
>> --
>>
>>                                            Gilles.
>>
>>
>> Thanks Gilles,
>>
>> I can construct a Makefile for a non realtime application
>> with multiple files. What I don't know are the extra flags
>> for compiling and linking that xenomai requires. My
>> thinking is that after I have a normal (non xenomai) Makefile,
>> I can just add the compile flags when I compile each of the files
>> and add linking flags to produce a real time final program.
>>
>> Everett
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>>
>=20
> Thanks for the help. I touched cross-link.c then a "make -n" to find out =
the
> xenomai flags.  I added these flags to my normal make file. It compiles
> and runs fine now.
>=20
> compiler flags:
> CFLAGS_XENO =3D -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
> -pipe -D__XENO__
>=20
> linker flags:
> LDFLAGS_XENO =3D -L/usr/xenomai/lib -lxenomai -lpthread  -lnative -lrtdm
> -Xlinker -rpath -Xlinker /usr/xenomai/lib
>=20
> Hopefully it can be useful for new xenomai users.

You should use *xeno-config* in your Makefile to get the proper compiler
and linker flags.

Wolfgang,

