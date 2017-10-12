References: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
 <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
 <a4c6520f-c201-2006-f530-b921d722c3c1@oss-tech.org>
 <6FABE6F5-B367-4A64-A276-2DC2DF18EBA9@theobroma-systems.com>
From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Message-ID: <d33ebdd9-d449-ca66-e355-f5796378804e@oss-tech.org>
Date: Thu, 12 Oct 2017 11:59:57 -0700
MIME-Version: 1.0
In-Reply-To: <6FABE6F5-B367-4A64-A276-2DC2DF18EBA9@theobroma-systems.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] ipipe: gicv3: [v3] Enable interrupt
	pipelining.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@theobroma-systems.com>
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org

On 10/12/2017 11:16 AM, Christoph M=FCllner wrote:

> That was my first attempt, but that ends up in a hang during bootup.
> I suspect that the .irq_hold() callback must not call ipipe_lock_irq().
> And since I added that call to gic_mask_irq(), I cannot call .irq_mask().
>=20
> Note, that this code equals also the GICv2 implementation in drivers/irqc=
hip/irq-gic.c
> (where I got the idea for the pipeline_lock() macros in [v2] from).
>=20
> Thanks,
> Christoph
>=20
>=20

Yes, that's correct - lock/unlock definitely should not be called from hold=
/release.

This looks ok to me. Thanks!

