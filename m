From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Wed, 18 Jan 2006 19:03:27 -0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601181903.27928.lbocseg@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] blocked or not blocked call on snippet/shared_mem.c?
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

I was looking at the xenomai snippets and found the shared_mem.c snippet=20
confused.

Here's a snippet from the snippet ;)

/* ...The call will block us until such heap
       is created with the expected name... */

    err =3D rt_heap_bind(&heap_desc,"SomeShmName",TM_NONBLOCK);

I'm confused. Did you really mean TM_NONBLOCK?
Am I missing something?

Thanks in advance,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



