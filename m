From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] RTDM and Timer functions
Date: Mon, 13 Mar 2006 14:15:49 -0300
References: <200603091443.25714.lbocseg@domain.hid> <44155BFD.300@domain.hid>
	<200603131154.13627.lbocseg@domain.hid>
In-Reply-To: <200603131154.13627.lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603131415.49256.lbocseg@domain.hid>
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

____________________________________________________________
Em Segunda 13 Mar=3DE7o 2006 11:54, Rodrigo Rosenfeld Rosas escreveu:

>I liked the note, but I would include another one:
>"When in periodic mode, the time resolution is limited to the tick set to
> the system timer" or something like. Maybe:
>"[If using periodic mode, note that ]The time resolution is limited by the
>system timer tick". Well my English is not that good, so I think you could
>give a better description, but I really need this note is very useful.

Actually, I would add them to rtdm_task_busy_sleep() documentation too.

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


