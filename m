Date: Tue, 08 Jan 2013 18:42:20 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <50ec5a7c40d395.38707397@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Dnia Wtorek, 8 Stycznia 2013 14:33 Jan Kiszka <jan.kiszka@siemens.com> napi=
sa=B3(a)=20
> On 2013-01-08 12:12, Mariusz Janiak wrote:
> > Hi GIlles,
> >=20
> > As you suggested, I have prepared simple test case that demonstrate how=
 Xenomai is utilized by OROCOS. This test case behaves exactly the same lik=
e helloword example. Scheduler is chosen before any mutex are processed, so=
 in my opinion it is not the case which you defined. What is really surpris=
ing is that the replacing TM_NONBLOCK with TM_INFINITE, in one before last =
line, do magic and suppress signal generation. Furthermore, there is no cal=
l to 'rt_task_set_mode(0, T_WARNSW, NULL);' so=20
why=20
> > signal is generated? If we enable T_WARNSW in the thread, SIGXCPU is ge=
nerated when mutex is locked first time in the thread.=20
>=20
> This should cure the issue (there was a check for XNTRAPSW missing):
>=20
> diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
> index e10be47..c1465dc 100644
> --- a/ksrc/nucleus/synch.c
> +++ b/ksrc/nucleus/synch.c
> @@ -687,10 +687,11 @@ xnsynch_release_thread(struct xnsynch *synch, struc=
t xnthread *lastowner)
> =20
>  #ifdef CONFIG_XENO_OPT_PERVASIVE
>  	if (xnthread_test_state(lastowner, XNOTHER)) {
> -		if (xnthread_get_rescnt(lastowner) =3D=3D 0)
> -			xnshadow_send_sig(lastowner, SIGDEBUG,
> -					  SIGDEBUG_MIGRATE_PRIOINV, 1);
> -		else
> +		if (xnthread_get_rescnt(lastowner) =3D=3D 0) {
> +			if (xnthread_test_state(lastowner, XNTRAPSW))
> +				xnshadow_send_sig(lastowner, SIGDEBUG,
> +						  SIGDEBUG_MIGRATE_PRIOINV, 1);
> +		} else
>  			xnthread_dec_rescnt(lastowner);
>  	}
>  #endif
>=20
> Thanks for providing the test case.
>=20
> Jan
>=20
> --=20
> Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
> Corporate Competence Center Embedded Linux

Thank you, after this, unexpected SIGXCPU is no longer a problem for my tes=
t case and OROCOS helloword example, as well.=20

Best regards,
Mariusz



