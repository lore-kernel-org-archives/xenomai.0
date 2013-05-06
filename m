Message-ID: <1367884025.7491.YahooMailNeo@web161401.mail.bf1.yahoo.com>
Date: Mon, 6 May 2013 16:47:05 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] priority of alarm handler?
Reply-To: Tom Z <tomz30@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi, I have question regarding using=0Aint rt_alarm_create =A0=A0=A0 ( =A0=
=A0=A0 RT_ALARM *=A0 =A0=A0=A0 alarm,=0A=A0=A0=A0 =A0=A0=A0 const char *=A0=
 =A0=A0=A0 name,=0A=A0=A0=A0 =A0=A0=A0 rt_alarm_t=A0 =A0=A0=A0 handler,=0A=
=A0=A0=A0 =A0=A0=A0 void *=A0 =A0=A0=A0 cookie=A0=A0=A0 =A0=0A=A0=A0=A0 ) =
=A0=A0=A0 =0A=0AIf I installed a kernel-space handler to an RT_ALARM object=
, then when this handler is executing, will this handler be preempted by ot=
her higher-priority interrupts? If yes, can I prevent this from happening?=
=0A=0A=0AThanks,=0ATom
