MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18279.34821.686364.791683@domain.hid>
Date: Tue, 18 Dec 2007 09:42:45 +0100
In-Reply-To: <47677A8C.3060107@domain.hid>
References: <47677A8C.3060107@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] migrating task code from rtai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

St=E9phane ANCELOT wrote:
 > Hi,
 > I have got a rtai task created as follow, it creates and deletes itself :
 >=20
 >=20
 > void *callbacktask(void *)
 > {
 >=20
 > rt_task_init(...)
 >=20
 >=20
 > while (!stopped)
 > 	{
 > 	....
 > 	}
 >=20
 > rt_task_delete(...)
 >=20
 > }
 >=20
 > what are the replacement functions I could use in xenomai to do the same
 > thing avoiding breaking lot of code?
 >=20
 > Note: I can not use RTAI skins in this xeno system .

If you want to use the Xenomai native API, then you should use
rt_task_shadow and rt_task_delete.

If you want to use the posix API, then you should use
pthread_setschedparam (though pthread_create, called to create the task
would probably have already made it real-time) and pthread_exit.

Note that Xenomai comes with a documentation which you can even read
on-line.

Here for trunk:
http://www.xenomai.org/documentation/trunk/html/api/index.html
And here for version 2.4:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html


--=20


					    Gilles Chanteperdrix.

