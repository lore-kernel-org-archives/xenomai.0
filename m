Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 May 2007 14:11:02 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB0C9@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Problem with Message queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>, xenomai@xenomai.org

Perrine Martignoni wrote:
[..]
>int DESTRUCT=3D0;
=A0
I'm always nervous to see global variables shared among threads without
a volatile keyword. An explicit memory barrier would be better, as it
has been re-explained in a LWN article lately (wait Thursday for free =
access)
http://lwn.net/Articles/233479/

But the problem in routine2 is somewhere else:

void routine2 (void * cookie){
	int ret;=20
	struct sched_param param =3D {.sched_priority =3D 10 };
	pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
	for(;;){
		affich(2);
		ret =3D mq_send(mq2, buf2, MSG_SIZE, 0);
		printf("send mq2 returned %d, errno %s\n", ret, errno );
ouch!                                           ^^          ^^^^^
		ret =3D mq_receive(mq1, buf1, MSG_SIZE, NULL );
		printf("receive mq1 returned %d, errno %s\n", ret, errno);=20
ouch!                                              ^^          ^^^^^
=A0

This should be either
		printf("receive mq1 returned %d, errno %d\n", ret, errno);
or
		printf("receive mq1 returned %d, errno %s\n", ret, strerror(errno));

--=20
Stephane

