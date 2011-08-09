Date: Tue, 09 Aug 2011 17:40:31 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-Id: <20110809174031.7B1346B2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] rt_queue_bind() returns -EACCES
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


Hello everyone.

I'm trying linux kernel 2.6.38.8 together with xenomai 2.5.6.
My application tries to reuse already created rt_queue shared between cou=
ple of similiar applications.
When I try to recreate already existing rt_queue by rt_queue_create i get=
 -EEXIST error (as I expected).
But if I try to bind it immediately with rt_queue_bind(&queue, QUEUE_NAME=
, TM_NONBLOCK) I get -EACCES error.
This error code is not in documentation and with the previously used vers=
ion (kernel 2.6.32.6, xenomai 2.4.10) it was working fine.
Do you have any advice or suggestion?
Thanks in advance.

Petr Cervenka

