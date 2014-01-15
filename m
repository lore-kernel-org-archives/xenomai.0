From: Asier Tamayo <asier.tamayo@onaedm.com>
Date: Wed, 15 Jan 2014 15:45:43 +0000
Message-ID: <4F6C25B906613147991AA0B688C61D1F1D9F3A9C@SRVEXCHANGE.ona-electroerosion.com>
References: <4F6C25B906613147991AA0B688C61D1F1D9F082C@SRVEXCHANGE.ona-electroerosion.com>
 <52D68FF0.6040504@siemens.com>
In-Reply-To: <52D68FF0.6040504@siemens.com>
Content-Language: es-ES
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Accessing an EtherCAT master from a Xenomai driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Jan,

Thank you for your support. I think you're right when you say the Xenomai p=
art of the EtherLab master is not finely tuned.

I may finally create a Xenomai task that accesses the EtherCAT RTDM driver,=
 and let the other tasks communicate with the first one. However, I preferr=
ed the driver solution: better latency and better system structure (I could=
 call the RTDM driver from another driver, both being at the same level).

If this solution doesn't work, I may try fixing the master myself.

> The right address for your request remains the EtherLab Master project -
>
I completely agree with you. As I wrote in my previous e-mail, I had alread=
y asked it there.

Best regards,

Asier Tamayo Arbide
Dpto I+D
R&D Department
=20
ONA Electroerosi=F3n, s.a.
=20
t      (34) 946 200 800
m    (34) 600 910 522
f      (34) 946 818 548
e      asier.tamayo@onaedm.com
w    www.onaedm.com
=20
=20
=20
=20
> -----Mensaje original-----
> De: Jan Kiszka [mailto:jan.kiszka@siemens.com]
> Enviado el: mi=E9rcoles, 15 de enero de 2014 14:41
> Para: Asier Tamayo; xenomai@xenomai.org
> Asunto: Re: Accessing an EtherCAT master from a Xenomai driver
>=20
> On 2014-01-15 09:55, Asier Tamayo wrote:
> > Hello all,
> >
> > I'm using IgH EtherCAT master for Linux, from EtherLab. I have a proble=
m
> with accessing the master from a RTDM driver.
> >
> > I've already asked this question in the EtherLab list, but have receive=
d
> no response, so I'm posting it here in case someone has worked with
> EtherLab but is no more in the mailing list.
> >
> > My problem is the following:
> >
> > I can access the EtherCAT master from a Xenomai user task, but have
> found no way to do it from a RTDM driver. In my tests, I have tried to
> follow the functions from the Xenomai example, but I find some problems I
> can't see how to resolve.
> >
> > For instance, the Xenomai example (user space application) calls
> ecrt_master_activate(), which eventually calls rtdm_mmap_to_user(): in th=
e
> RTDM driver, rtdm_mmap_to_user() is called with a user_info value set to
> NULL, and it crashes. Also, some functions have to be called in non-RT
> context. For example, ecrt_master_slave_config(), which allocates memory
> by causing a page fault.
> >
> > I hope this time I'll have better luck. Best regards,
>=20
> The right address for your request remains the EtherLab Master project -
> or you need to fix it yourself. Probably, their RTDM driver is not well
> prepared for being used by other drivers and requires adaptions. Or
> there are some details missing in the API documentation, e.g. that you
> do not need to invoke that service which performs rtdm_mmap_to_user.
> Moreover, from a quick look over it, EtherLab contains several
> conceptual bugs /wrt RTDM API usage, so I would look carefully at the
> whole thing.
>=20
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux

