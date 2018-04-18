Message-ID: <1524043270.2300.2.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Wed, 18 Apr 2018 11:21:10 +0200
In-Reply-To: <627da48b-4a8d-e8e4-b521-a3fe99304cae@xenomai.org>
References: <1523454871.2312.15.camel@smigroup.net>
 <e0a935b3-8f75-484f-5324-9c5694476bfc@xenomai.org>
 <1523457598.2312.18.camel@smigroup.net>
 <627da48b-4a8d-e8e4-b521-a3fe99304cae@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_task_wait_period() does not return -EWOULDBLOCK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@xenomai.org>

On Wed, 2018-04-11 at 16:42 +0200, Philippe Gerum wrote:
> On 04/11/2018 04:39 PM, Mauro Salvini wrote:
> > On Wed, 2018-04-11 at 16:20 +0200, Philippe Gerum wrote:
> > > On 04/11/2018 03:54 PM, Mauro Salvini wrote:
> > > > Hi,
> > > >=20
> > > > I'm facing an unexpected behavior of rt_task_wait_period().
> > > >=20
> > > >=20
> >=20
> > ...
> >=20
> > > Please try this and let me know if the situation gets any better:
> >=20
> > Yes, now it works as expected.
> >=20
> > Thank you Philippe.
> >=20
> > Best regards.
> >=20
> > Mauro
> >=20
> >=20
>=20
> Ok, upstreamed. Thanks.
>=20

Hi Philippe,

I resume this thread because when I tried your patch I tried only the
case that didn't work, that is with SET_PERIOD undefined
(so=C2=A0rt_task_set_periodic() not called), and didn't re-test also the
code with rt_task_set_periodic() call. Sorry, my fault.

With this patch applied, when I call rt_task_set_periodic() (SET_PERIOD
defined), rt_task_wait_period() returns -EWOULDBLOCK as if
rt_task_set_periodic() was never called.

Thanks in advance, regards

Mauro


