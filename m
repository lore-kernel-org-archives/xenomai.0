MIME-Version: 1.0
Date: Thu, 15 May 2008 15:50:56 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <2ff1a98a0805150612x62f8a1a9te843a27911244e72@domain.hid>
References: <2ff1a98a0805150612x62f8a1a9te843a27911244e72@domain.hid>
Message-ID: <955c7c82b3624040fbf69ee97e7177dc@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?_Re=3A__Re=3A_Re=3A_Re=3A_VxWorks_skin_p?=
 =?utf-8?q?roblem_concerning_WIND=5FTCBstructure?=
Reply-To: matthieu.connaulte_xenomai@domain.hid
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



On Thu, 15 May 2008 15:12:32 +0200, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, May 15, 2008 at 11:28 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On Thu, May 15, 2008 at 8:10 AM, Matthieu
>> <matthieu.connaulte_xenomai@domain.hid> wrote:
>>  I think
>>> that VxWorks Task Control Block ,implemeted by  WIND RIVER, is keepin=
g
> the
>>> context in hard real-time. That's why I would like to know if there a=
re
>>> other possibilities ?
>>
>> Yes, there are possibilities: fix your code not to use such internal
>> data as the WIND_TCB members.
>=20
> Even VxWorks documentation considers accessing WIND_TCB directly as a
> bad practice. See the doc of taskInfoGet at:
>=20
>
http://spacegrant.colorado.edu/~dixonc/vxworks/docs/vxworks/ref/taskShow.=
html
>=20
> So, what I would agree we can do is implement taskInfoGet.
>=20
> --
>  Gilles

Well, what a great issue for me...

But can I use other API implements of such kind of Tasks information, as
it's possible to mix APIs ? I think about Task Status or Thread State Fla=
gs
?

Matthieu



