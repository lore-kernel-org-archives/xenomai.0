Date: Fri, 12 Oct 2012 09:11:40 +0200
From: "Petr Cervenka" <grugh@centrum.cz>
References: <20121011170958.40C8E372@centrum.cz> <50771645.6020705@xenomai.org>
In-Reply-To: <50771645.6020705@xenomai.org>
MIME-Version: 1.0
Message-Id: <20121012091140.E3CB5F90@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Shared interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> Od: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> Komu: Petr Cervenka <grugh@centrum.cz>
> Datum: 11.10.2012 20:56
> P=C5=99edm=C4=9Bt: Re: [Xenomai] Shared interrupts
>
> CC: xenomai@xenomai.org
>On 10/11/2012 05:09 PM, Petr Cervenka wrote:
>> I'm using xenomai 2.5.6, adeos 2.6.38.8-x86-2.10-01
>
>>=20
>> My primary questions: Is there a possibility to have the rtdm driver
>> compatible with both cases?
>
>
>Well, yes, enable CONFIG_XENO_OPT_SHIRQ, and pass RTDM_IRQTYPE_SHARED
>when registering the irq handlers. And do not return XN_ISR_PROPAGATE.

Of course, I have enabled CONFIG_XENO_OPT_SHIRQ and I have passed RTDM_IR=
QTYPE_SHARED flag.
But I can make running only one of those rt - nrt device combinations at =
a time.
Two rt devices with shared IRQ work for me only when I do NOT return XN_I=
SR_PROPAGATE.
Combination of rt and nrt device works only when I return XN_ISR_PROPAGAT=
E.

Do I have something wrong in the other settings? Because it seems that an=
 interrupt is spread among all rt devices (with same IRQ) and (perhaps) w=
hen there is one who doesn't handle it, it is propagated to linux and dis=
abled. (In other words: one rt device handles interrupt, one not and than=
 interrupt is disabled)

I think I want propagation of interrupt to linux, because if there is (ra=
rely) a nrt device sharing same IRQ, it is usually critical for the PC to=
 run.

Petr

