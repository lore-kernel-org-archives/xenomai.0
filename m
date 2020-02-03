MIME-Version: 1.0
References: <CAKP50V4e5Np-wFPzOLPHiVtKhwxnLreg18zTZRYs6-pTTqTN4Q@mail.gmail.com>
 <8e2ed529-3c99-3f3b-bb29-430645870df2@siemens.com>
In-Reply-To: <8e2ed529-3c99-3f3b-bb29-430645870df2@siemens.com>
From: Matheus Leitzke <senseipinto@gmail.com>
Date: Mon, 3 Feb 2020 15:42:07 -0300
Message-ID: <CAKP50V5MBY2KHZWFVzEqNa3x6Lo2+Lhhfu6ve-9z0GG_60AnVg@mail.gmail.com>
Subject: Re: What is the highest value returned by rt_timer_read?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

I am using a Raspberry Pi 3 B+.
I want to know that value because it is needed to correctly calculates
difference of time when occurs counting overflow.
For example:

...
now =3D rt_timer_read();
if(now >=3D before)
{
     diff =3D now - before;
}
else
{ // in case of counting overflow
     diff =3D MAX_TIME - now +  before;
}
before =3D now;
...

So, as you said MAX_TIME =3D (1 << 64) - 1?


Em ter., 28 de jan. de 2020 =C3=A0s 06:16, Jan Kiszka <jan.kiszka@siemens.c=
om>
escreveu:

> On 24.01.20 20:02, Matheus Leitzke via Xenomai wrote:
> > Hello,
> >
> > As I didn't find it in the API manual, I'm using the list to clear my
> > doubts.
> > What is the highest value returned by rt_timer_read function on Xenomai=
 3
> > Alchemy skin?
>
> Type-wise, it's a 64-bit value, thus (1 << 64) - 1. But we are reading
> from arch-dependent TSCs that may have a smaller range, specifically
> after converting their values to nanoseconds. About which platform are
> we talking here?
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>


--=20
_________________________________________________

Prof.  *Matheus Leitzke Pinto*

Instituto Federal de Santa Catarina - IFSC / Campus Chapec=C3=B3
Endere=C3=A7o: Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 =E2=
=80=93 SC
CEP: 89813-000
Celulares: (53) 81189999 (Tim, Whats App); (49) 89143113 (Claro)
Curr=C3=ADculo Lattes:
http://buscatextual.cnpq.br/buscatextual/visualizacv.do?id=3DK8793291J7

Emails: matheus.pinto@ifsc.edu.br; lpinto.matheus@gmail.com;
senseipinto@gmail.com <senseipinto@gmail.com>
