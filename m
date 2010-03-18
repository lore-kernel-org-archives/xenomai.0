From: Huan Fang <huanf@domain.hid>
Date: Thu, 18 Mar 2010 16:05:08 +0100
Message-ID: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CE@MAIL02.ug.kth.se>
Content-Language: en-GB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] deadlock for rtdm_mutex
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

Hi,

Sometimes I got below assertion failed:

xenomai/skins/rtdm/drvlib.c:1544 (mutex_owner !=3D curr_thread)

Looking into the code,
/* Redefinition to clarify XENO_ASSERT output */
		#define mutex_owner xnsynch_owner(&mutex->synch_base)
		XENO_ASSERT(RTDM, mutex_owner !=3D curr_thread,
			    err =3D -EDEADLK; goto unlock_out;);

Does it mean if the current owner of mutex is different from the requesting=
 thread, then a -EDEADLK error is returned?(which is not documented in RTDM=
 api doc)
In my case, if one thread tries to lock same mutex twice, the assertion is =
thrown out as well. Could you please explain a bit how does Xenomai detect =
deadlock?
Thanks.

Regards,
Huan=

