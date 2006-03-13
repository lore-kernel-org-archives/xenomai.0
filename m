From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Mon, 13 Mar 2006 16:19:02 -0300
References: <200603091443.25714.lbocseg@domain.hid>
	<200603131415.49256.lbocseg@domain.hid>
	<200603131458.09074.lbocseg@domain.hid>
In-Reply-To: <200603131458.09074.lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603131619.02367.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Actually, I noted a minor typo error in the documentation:

" of the this service" should be " of this service"

Best Regards,

Rodrigo.
____________________________________________________________
Em Segunda 13 Mar=3DE7o 2006 14:58, Rodrigo Rosenfeld Rosas escreveu:

>Sorry Jan, I was looking at a different documentation. Now I read the right
>one. It is good. But I didn't understand why didn't you keep the latter
> note: "The nucleus timer has to be started to obtain valid results." I
> would include it before the other note.
>
>Thank you,
>
>Rodrigo.
>
>____________________________________________________________
>
>Em Segunda 13 Mar=3DE7o 2006 14:15, Rodrigo Rosenfeld Rosas escreveu:
>>____________________________________________________________
>>
>>Em Segunda 13 Mar=3DE7o 2006 11:54, Rodrigo Rosenfeld Rosas escreveu:
>>>I liked the note, but I would include another one:
>>>"When in periodic mode, the time resolution is limited to the tick set to
>>> the system timer" or something like. Maybe:
>>>"[If using periodic mode, note that ]The time resolution is limited by t=
=3D
he
>>>system timer tick". Well my English is not that good, so I think you cou=
=3D
ld
>>>give a better description, but I really need this note is very useful.
>>
>>Actually, I would add them to rtdm_task_busy_sleep() documentation too.
>>
>>Rodrigo.
>>
>>
>>_______________________________________________________
>>Yahoo! Acesso Grtis - Internet rpida e grtis. Instale o discador agora!
>>http://br.acesso.yahoo.com
>>
>>
>>_______________________________________________
>>Xenomai-core mailing list
>>Xenomai-core@domain.hid
>>https://mail.gna.org/listinfo/xenomai-core
>
>_______________________________________________________
>Yahoo! Acesso Grtis - Internet rpida e grtis. Instale o discador agora!
>http://br.acesso.yahoo.com
>
>
>_______________________________________________
>Xenomai-core mailing list
>Xenomai-core@domain.hid
>https://mail.gna.org/listinfo/xenomai-core

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



