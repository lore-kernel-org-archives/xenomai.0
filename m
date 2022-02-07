Date: Mon, 07 Feb 2022 15:14:19 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: UDD with shared interrupts?
Message-ID: <yf7HzSAMs1MelG2CeD900qXVYeWyihg3vs11HwH0gHG1u4kFzZJ9S3Ihr46eggA7JFYjYTlLNQED_jjfvvCePV_BmjK03xLaVvHwvY8_Alg=@codecraftsmen.org>
In-Reply-To: <c6a0fa05-8348-dfff-fc1e-938795a1f266@siemens.com>
References: <A9p1YZoCjJLY022S76mAXuvt70QWpXy_dZ-qDq4aUPqDLINgdbSY7qUhHeUmAa0FML6gZWvd7_q2SUQyTBNVeq2r-liU6CnL_ZrzuesB0dc=@codecraftsmen.org>
 <c6a0fa05-8348-dfff-fc1e-938795a1f266@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

------- Original Message -------
On Monday, February 7th, 2022 at 1:21 AM, Jan Kiszka <jan.kiszka@siemens.co=
m> wrote:
> On 02.02.22 17:12, Jeff Webb via Xenomai wrote:
>
> > I am updating and reworking a UDD driver stub and happened to notice a =
difference
> > between the UDD and UIO APIs. It looks like udd_register_device() alway=
s passes "0"
> > as the rtdm_irq_request() "flags" argument, whereas uio_register_device=
() allows
> > flags to be passed in to request_irq(). Does this mean that shared inte=
rrupts are
> > not currently possible with UDD drivers? Is there a reason for this dif=
ference in
> > the UDD and UIO APIs?
>
> You can add RTDM_IRQTYPE_SHARED as flag - but note that this will only
> give you sharing between RT devices. Cross-domain sharing would break
> determinism.
>
> Jan

Thanks for confirming that there is nothing preventing shared interrupts (b=
etween real-time drivers) from working with UDD, Jan.

I think my question was not completely clear, though, so let me try again.

I realize that I could modify the source of udd.c to add RTDM_IRQTYPE_SHARE=
D in place of "0" in the excerpt of udd_register_device() below:

=09=09ret =3D rtdm_irq_request(&ur->irqh, udd->irq,
=09=09=09=09       udd_irq_handler, 0,
=09=09=09=09       dev->name, udd);

I was wondering why there is not a way to pass in RTDM_IRQTYPE_SHARED to ud=
d_register_device()?  Maybe no one has needed this yet?  I see that Linux U=
IO's uio_info struct has an irq_flags field for passing in IRQF_SHARED, whi=
ch is passed along to request_irq(). Would it make sense to add a similar f=
ield to the udd_device structure for this purpose?

Thanks,

-Jeff


