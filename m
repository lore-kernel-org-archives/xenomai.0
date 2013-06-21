From: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Date: Fri, 21 Jun 2013 07:31:42 +0000
Message-ID: <49E736B33FAAA645BCAB9FFEC26712E6FD1920@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
	<fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD16CB@EXDAG0-B0.intra.cea.fr>
	<0012b71cd44fa48b579be970738eb844.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1732@EXDAG0-B0.intra.cea.fr>
	<41d414a76f40aa6f246bc60d89a11394.squirrel@www.xenomai.org>
In-Reply-To: <41d414a76f40aa6f246bc60d89a11394.squirrel@www.xenomai.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

Running "make install" solved the problem. Now I can see that the "send" fu=
nction calls __wrap_send in rtdm.c
Now it gets interesting : __real_send is never called, because __wrap_send =
detects correctly that this is indeed a valid RT socket.=20
The SIGCPU signal is sent when trying to run the following line:

ret =3D set_errno(XENOMAI_SKINCALL3(__pse51_rtdm_muxid, __rtdm_sendmsg, fd =
- __pse51_rtdm_fd_start, &msg, flags));

For indication, values are (in order of the arguments): (65536, 8, 0, (addr=
ess), 0);

Seems like the problem stems from XENOMAI_SKINCALL3, but this macro is pret=
ty hard to figure out...

Flavian

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Envoy=E9=A0: jeudi 20 juin 2013 15:22
=C0=A0: HAUTBOIS Flavian
Cc=A0: Gilles Chanteperdrix; xenomai@xenomai.org
Objet=A0: RE: [Xenomai] CPU time limit exceeded


HAUTBOIS Flavian wrote:
> Hi Gilles,
>
> "SIGDEBUG received, reason 4: affected by priority inversion". My bad,=20
> it wasn't in the text file.

It means that __wrap_send switches to secondary mode (probably by calling _=
_real_send), while your application holds a mutex.

>
> I am also talking about the socket passed to the send function that=20
> calls the incriminated __wrap_send, it's 896.
> However I'm not sure what you mean about the return value of the RTDM=20
> system call. Do you mean "rval =3D send(socket, ...); printf("%d",=20
> rval)"? I

No, I mean in __wrap_send implementation put a printf after the RTDM system=
 call and before the call to __real_send to know the reason for calling __r=
eal_send. Alternatively, you can put some printk around in kernel code to k=
now why send fails.

Regards.

--=20
                    Gilles.


