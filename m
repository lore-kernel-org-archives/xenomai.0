From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Mon, 13 Mar 2006 16:25:41 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603131458.09074.lbocseg@domain.hid> <4415B8C2.6000806@domain.hid>
In-Reply-To: <4415B8C2.6000806@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603131625.41508.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Em Segunda 13 Mar=3DE7o 2006 15:24, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> Sorry Jan, I was looking at a different documentation. Now I read the
>> right one. It is good. But I didn't understand why didn't you keep the
>> latter note: "The nucleus timer has to be started to obtain valid
>> results." I would include it before the other note.
>
>Well, it's no longer relevant for Xenomai: you can't load a driver
>without the timer being started - loading xeno_rtdm will do this.
>
>On the other hand, you are right when considering RTAI where you still
>face this obstacle. I will re-introduce the note below, but the strategy
>will remain that it's up to the user (application) to resolve this.
>
>"The system timer has to be started to obtain valid results. If this
>happens automatically or is controlled by the application depends on the
>RTDM host environment, see related documentation of the real-time Linux
>extension."

I would add a little, but significant comment with:
"The system timer has to be started to obtain valid results. If this
happens automatically (as it does on Xenomai) or is controlled by the=3D20
application depends on the RTDM host environment, see related documentation=
=3D
=3D20
of the real-time Linux extension."

Regards,

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


