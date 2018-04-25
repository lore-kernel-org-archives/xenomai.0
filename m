From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Date: Wed, 25 Apr 2018 08:54:30 +0000
Message-ID: <b2cbe5362c38461d9a2eb817b78fb633@EDB3.wapice.localdomain>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <1542961.KC98kqrEBl@wirbelwind>
 <cad2a4c9f8b749109afff86f3ef0f201@advaoptical.com>
 <80155073.HUEqfJo2pc@wirbelwind>
In-Reply-To: <80155073.HUEqfJo2pc@wirbelwind>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "Philippe Gerum <rpm@xenomai.org> (rpm@xenomai.org)" <rpm@xenomai.org>
Cc: Adnan Ali <adnan.ali@wapice.com>, Sakari Junnila <sakari.junnila@wapice.com>

On Mon, Apr 02, 2018 at 12:56:39PM +0000, Sagi Maimon wrote:
> Hi all,
> I am working with: Powerpc e300 SOC.
> I am using: xenomai-2.6.4 version
>=20
> I am experiencing this exception on my Linux :
> Unrecoverable FP Unavailable Exception 801 at c0003858
> Oops: Unrecoverable FP Unavailable Exception, sig: 6 [#1]
>=20
> This happens during "alignment exception" (600)

Hello

We have also seen this issue recently with Xenomai 2.6.4 and i-pipe 3.1.10-=
powerpc-2.13-06.

We have been investigating this and Adnan found that the issue seems to be =
in arch/powerpc/kernel/process.c: enable_kernel_fp().

In this function the irqs are disabled and enabled by calling local_irq_sav=
e_hw_cond() and local_irq_restore_hw_cond(). In between the FP bit is enabl=
ed and written to MSR in giveup_fpu(). However, the local_irq_restore_hw_co=
nd() restores the previous MSR which does not have the FP bit enabled and t=
his leads to the exception 801.

We have briefly tested that the exception 801 does not occur with the follo=
wing patch:

--- a/arch/powerpc/kernel/process.c	2018-04-24 15:54:10.164558970 +0300
+++ b/arch/powerpc/kernel/process_new.c	2018-04-24 15:53:30.635567659 +0300
@@ -114,6 +114,11 @@ void enable_kernel_fp(void)
 #else
 	giveup_fpu(last_task_used_math);
 #endif /* CONFIG_SMP */
+	/*
+	 * giveup_fpu sets the FP bit in MSR, toggling it off would cause
+	 * unavailable FP kernel panic. So, keep it on if it was set.
+	 */
+	flags |=3D (mfmsr() & MSR_FP);
 	local_irq_restore_hw_cond(flags);
 }
 EXPORT_SYMBOL(enable_kernel_fp);

It seems that the implementation is quite similar also in the current I-pip=
e branch ipipe-4.9.y (only the FP bit is set by msr_check_and_set() and not=
 in giveup_fpu). Therefore the problem seems to exist also in the latest i-=
pipe.

Is our fix correct or have we missed something?

BR,
Jouko Haapaluoma
Wapice Ltd
Finland

