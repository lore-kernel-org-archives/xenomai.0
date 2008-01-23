From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Wed, 23 Jan 2008 20:31:14 +0100
Message-ID: <2220D86D21B55040AB683933DBD97B5A014A26202B@FND-MAILB03.VIA.DK>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Calling rt_task_start with cookie not NULL
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

The rt_task_start has the following signature:

int rt_task_start (RT_TASK * task, void(*)(void *cookie) entry, void * cook=
ie);

but I have not been able to find any example where the cookie parameter is =
not NULL.

I am programming an example, where the entry function need some parameters =
(five).

Can someone tell me how to do that?

Regards
Hans



