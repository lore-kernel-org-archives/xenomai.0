From: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Date: Thu, 20 Jun 2013 07:31:03 +0000
Message-ID: <49E736B33FAAA645BCAB9FFEC26712E6FD1732@EXDAG0-B0.intra.cea.fr>
References: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
	<b7108896dbd73baf5b1890f4cddc62b0.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD1648@EXDAG0-B0.intra.cea.fr>
	<fb3e91c788e98c96e2c5061a83b96def.squirrel@www.xenomai.org>
	<49E736B33FAAA645BCAB9FFEC26712E6FD16CB@EXDAG0-B0.intra.cea.fr>
	<0012b71cd44fa48b579be970738eb844.squirrel@www.xenomai.org>
In-Reply-To: <0012b71cd44fa48b579be970738eb844.squirrel@www.xenomai.org>
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

"SIGDEBUG received, reason 4: affected by priority inversion". My bad, it w=
asn't in the text file.

I am also talking about the socket passed to the send function that calls t=
he incriminated __wrap_send, it's 896.=20
However I'm not sure what you mean about the return value of the RTDM syste=
m call. Do you mean "rval =3D send(socket, ...); printf("%d", rval)"? I had=
 to place the printf in my signal handler, but rval is never updated (send =
never finishes) and keeps its initial value. I am positive though that send=
 is entered.

I enabled the debug options when I compiled, and this is what I found in /v=
ar/log/kern.log:=20

>Jun 20 09:19:27 alex-Precision-WorkStation-470 kernel: [ 2059.456005] Xeno=
mai: Posix: destroying mutex f8a86200.
>Jun 20 09:19:27 alex-Precision-WorkStation-470 kernel: [ 2059.456005] Xeno=
mai: Posix: destroying mutex f8a86240.
>Jun 20 09:19:27 alex-Precision-WorkStation-470 kernel: [ 2059.456005] Xeno=
mai: Posix: destroying mutex f8a86280.
>Jun 20 09:19:27 alex-Precision-WorkStation-470 kernel: [ 2059.456005] Xeno=
mai: RTDM: closing file descriptor 0.

Thanks to printf's I've narrowed down the signal to the "send" function men=
tioned above, but I don't know how I can go further?=20

Thanks a lot

Flavian

-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Envoy=E9=A0: mercredi 19 juin 2013 16:32
=C0=A0: HAUTBOIS Flavian
Cc=A0: Gilles Chanteperdrix; xenomai@xenomai.org
Objet=A0: RE: [Xenomai] CPU time limit exceeded


HAUTBOIS Flavian wrote:
> Hi Gilles,
>
> I'm using a middleware that arms T_WARNSW by default, I cannot change=20
> that. Plus, I would like to use only RTNet to send this packet, as I=20
> need real-time performances.
> I may be mistaken, but I thought the message stating the reason was=20
> one of the first lines of the files I joined.

Could you simply paste that line in a mail? So we definitely know what caus=
es this signal?


>
> The socket being used by the program is 896 (which equals 1024-128),=20
> so the issue should be somewhere else if I understood you correctly?

I am talking about the socket used by the particular call to __wrap_send wh=
ich gets the signal, not about any other socket. What would be interesting =
next is the return value of the RTDM system call in __wrap_send.

>
> RTNet should be correctly configured and started but I'm not 100%=20
> positive. Here are the outputs of rtconfig and lsmod. (I have two=20
> Ethernet cards in my computer, one uses the e1000e module and the=20
> other one the
> e100 module. The latter one is the one I use with rtnet)
>
> You mentioned other reasons for failure that I can't really=20
> investigate without further precisions, such as wrong kernel-space=20
> options, any more details?

Have you tried enabling debugs to see if you get a message in the kernel lo=
gs? Otherwise, you may add printfs or printks around to see the exact reaso=
n for receiving this signal.

--=20
                    Gilles.


