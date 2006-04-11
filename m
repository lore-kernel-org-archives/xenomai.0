From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Fixs doxygen doc on rt_queue_read
	=?iso-8859-1?q?in=09ksrc/native/queue=2Ec?= (for SVN version)
Date: Tue, 11 Apr 2006 09:54:56 -0300
References: <200604101640.04255.lbocseg@domain.hid> <443BA12F.9020505@domain.hid>
In-Reply-To: <443BA12F.9020505@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200604110954.56680.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Maybe NULL is defined diferently in kernel mode and in userspace? Maybe it=
=20
would be good to test the function against 0 (zero) in both code just for=20
making sure...

Rodrigo.

____________________________________________________________
Em Ter=E7a 11 Abril 2006 09:29, Jan Kiszka escreveu:

>Rodrigo Rosenfeld Rosas wrote:
>> BTW, please, could someone confirm the rt_task_delete(NULL) bug in SVN?
>
>Half-confirmed, there is something fishy. I'm struggling with the
>debugger ATM, not sure yet who's wrong ;). It tells me rt_task_delete of
>the skin module is entered with task !=3D NULL...
>
>Jan

		
_______________________________________________________ 
Novidade no Yahoo! Mail: receba alertas de novas mensagens no seu celular. Registre seu aparelho agora! 
http://br.mobile.yahoo.com/mailalertas/ 
 



