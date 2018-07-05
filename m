From: Johann Obermayr <johann.obermayr@sigmatek.at>
Date: Thu, 5 Jul 2018 14:08:20 +0000
Message-ID: <VI1PR0801MB18548FC46353D8A7836127A2F5400@VI1PR0801MB1854.eurprd08.prod.outlook.com>
References: <6b3f6665-d424-9350-837f-cad1b3b54c7c@gmx.at>
 <d72ffe7c-500d-4fa2-8643-ac82fbe619f1@xenomai.org>
In-Reply-To: <d72ffe7c-500d-4fa2-8643-ac82fbe619f1@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] context switch minimize
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



> -----Urspr=FCngliche Nachricht-----
> Von: Xenomai [mailto:xenomai-bounces@xenomai.org] Im Auftrag von
> Philippe Gerum
> Gesendet: Donnerstag, 5. Juli 2018 15:05
> An: jimmyo <jimmyo@gmx.at>; xenomai@xenomai.org
> Betreff: Re: [Xenomai] context switch minimize
>=20
> On 07/05/2018 11:37 AM, jimmyo wrote:
> > Hello,
> >
> > we have a running system on mx6 with Kernel 3.10.x and Xenomai 2.6.4.
> > i known, it's very old.
> > now we have to make some optmization.
> > In one xenomai task we need to check, if a TCP/UDP socket handle has
> > data to receive.
> > at this time we use select to detect if there are data available and
> > with ioctl & FIONREAD we get count of data.
> >
> > Now we must search a way, to do this in the primary domain, without
> > switching to secondary domain.
> >
> > Is there a way to solve it ?
> >
> > we have a exists rtdm interface to a own kernel module.
> > And we use rt_dev_ioctl to communicate with this module.
> >
>=20
> A plain thread could select() these file descriptors in userland, posting=
 a
> Xenomai-managed semaphore which your rt thread would trywait() on.
>=20
> - semaphores can be posted by any thread, including those unknown to
> Xenomai
> - sem_trywait() would poll for the event without switching mode.
>=20
> --
> Philippe.
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

Hello,

We also thought about our own thread but wanted to know if there is a bette=
r solution.

Thank you very much.
  Jimmy

