From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Wed, 5 Apr 2006 15:38:29 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200604051538.29233.lbocseg@domain.hid>
Subject: [Xenomai-core] rt_task_delete(NULL) started crashing on SVN
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

Hi Philippe,

I'm not sure of the exact SVN revision the problem arised, but my program u=
sed=20
to work 2 weeks ago, I guess, that was the last time I have tested it...=20
Since some revision not before 2 weeks ago, rt_task_delete(NULL) was causin=
g=20
my program to crash.

Please, could you see what is going on? Remember something that was changed=
 in=20
rt_task_delete code or some path that could affect this call in this way?

Thanks in advance,

Rodrigo.

P.S: I tested on last SVN version today after a failure with the previous s=
vn=20
version I had installed. Unfortunately, I do not remember which was the=20
previous revision, but I believe I've updated it yesterday. I think this=20
information will not help very much, so, if you cannot reproduce the bug, I=
=20
can try to write a minimal application where the bug appears.

	=09
_______________________________________________________=20
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!=20
http://br.acesso.yahoo.com


