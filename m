From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Tue, 24 Jan 2006 20:19:05 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200601242019.05696.lbocseg@domain.hid>
Subject: [Xenomai-help] RTDM and possible bug
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

Hi Jan,

I'm getting the following message from kernel:
Xenomai: RTDM: no non-RT close handler
Error registering RTDM device

But I am using only a RT open handler and a RT close handler. The=20
documentation states:
"rtdm_close_handler_t 	close_nrt=09
 	Close handler for non-real-time contexts, optional if close_rt is non-NUL=
L."
which is my case.

Am I missing something?

I'll take a closer look at RTDM source-code, but maybe you can enlight me=20
until there.

Thanks,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



