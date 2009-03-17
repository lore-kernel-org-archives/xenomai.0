From: "Charlton, John" <john.charlton@domain.hid>
Date: Tue, 17 Mar 2009 11:38:56 -0400
Message-ID: <CF7FB0793253794F9F45991443E5FE200513A0636F@us194mx002.tycoelectronics.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Port rtai rt_request_srq to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am porting an rtai linux 2.4 kernel driver to xenomai-2.4.6.1 patched lin=
ux 2.26.27.7 kernel.  I have done a fair amount of searching for the rtai f=
unctions: rt_request_srq()/rt_free_srq() and have not found an equivalent i=
n xenomai. Would appreciate advice on how this can be done in xenomai or if=
 the equivalent of this is not available in xenomai. It looks like rthal_ap=
c_alloc() may be what I am looking for.

--John




