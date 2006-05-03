From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] Have condition variables Priority Inheritance
	Protection (PIP)?
Date: Wed, 3 May 2006 13:15:01 -0300
References: <200604281736.28169.lbocseg@domain.hid>
	<200605020936.00576.lbocseg@domain.hid> <4458625C.5020808@domain.hid>
In-Reply-To: <4458625C.5020808@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200605031315.01583.lbocseg@domain.hid>
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
Cc: xenomai@xenomai.org

Em Quarta 03 Maio 2006 04:57, Jan Kiszka escreveu:

>> ...Or should I use other IPC mechanism for sharing resource with
>> PIP?
>
>Mutexes were invented for such resource access control :). They have a
>strict ownership concept, thus allowing to apply PIP as well.

Yes, however I can't figure out how could I use mutexes as counting=20
semaphores, for instance. They have different meanings. However I could thi=
nk=20
in semaphores protected by PIP in singular cases, although I couldn't figur=
e=20
out how to do it in a systematic approach so that it could be used in a=20
realtime framework such as Xenomai...

Rodrigo.

	=09
_______________________________________________________=20
Abra sua conta no Yahoo! Mail: 1GB de espa=E7o, alertas de e-mail no celula=
r e anti-spam realmente eficaz.=20
http://br.info.mail.yahoo.com/


