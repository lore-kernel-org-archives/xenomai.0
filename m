Message-ID: <45E80028.9040801@domain.hid>
Date: Fri, 02 Mar 2007 11:44:56 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] can getstate
References: <45E80379.6000502@domain.hid>
In-Reply-To: <45E80379.6000502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: xenomai@xenomai.org

St=E9phane ANCELOT wrote:
> Hi,
> Can somebody provide me with a programming example on how to retrieve=20
> state using rt_dev_ioctl .

The following (untested) code snippet should work:

     struct ifreq  ifr;
     can_state_t *pstate;
     ...
     pstate =3D (can_state_t *)&ifr.ifr_ifru;
     ret =3D rt_dev_ioctl(fd, SIOCGCANSTATE, &ifr);
     if (ret) {
	perror("rt_dev_ioctl");
	return;
     }
     printf("Current state =3D %d\n", *pstate);

RT-Socket-CAN allows a very flexible error handling. Please have a look=20
to=20
http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#g45=
1ba35aa4d0bef48cb7b0416f5b4367

Wolfgang,


