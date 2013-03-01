References: 
Message-ID: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>
Date: Fri, 1 Mar 2013 15:33:02 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] kvm freeze with ipipe patch for kernel 3.x
Reply-To: Gabriele Moabiti <gabmoa@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0AI'm using an XP guest with qemu+kvm (vmx) on linux host (kernel 3.2.21 +=
 ipipe patch + xenomai version 2.6.2.1)=0Aand I'm experiencing many system =
freezes when the vm is active.=0AI think then problem is in the 3.x (3.2,3.=
4,3.5) ipipe patch (ipipe-core-3.2.21-x86-5.patch):=0A=0A:=0A=0Adiff --git =
a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c=0A=0A=0A....=0A=0A@@ -5749,13 +57=
95,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)=0A=A0=A0=A0=A0 =
=A0*/=0A=A0=A0=A0=A0 smp_mb();=0A=0A-=A0=A0=A0 local_irq_disable();=0A-=0A=
=A0=A0=A0=A0 if (vcpu->mode =3D=3D EXITING_GUEST_MODE || vcpu->requests=0A=
=A0=A0=A0=A0 =A0=A0=A0 || need_resched() || signal_pending(current)) {=0A=
=A0=A0=A0=A0 =A0=A0=A0 vcpu->mode =3D OUTSIDE_GUEST_MODE;=0A=A0=A0=A0=A0 =
=A0=A0=A0 smp_wmb();=0A-=A0=A0=A0 =A0=A0=A0 local_irq_enable();=0A+=A0=A0=
=A0 =A0=A0=A0 hard_cond_local_irq_enable();=0A=A0=A0=A0=A0 =A0=A0=A0 preemp=
t_enable();=0A=A0=A0=A0=A0 =A0=A0=A0 kvm_x86_ops->cancel_injection(vcpu);=
=0A=A0=A0=A0=A0 =A0=A0=A0 r =3D 1;=0A=0A=0A....=0A=0A=0A=0A=0Alocal_irq_ena=
ble() should be enabled after hard_cond_local_irq_enable (as in the 2.6.38 =
patch), in this way:=0A=0A=0A=0A...=0A-=A0=A0=A0 local_irq_disable();=0A-=
=0A=A0=A0=A0=A0 if (vcpu->mode =3D=3D EXITING_GUEST_MODE || vcpu->requests=
=0A=A0=A0=A0=A0 =A0=A0=A0 || need_resched() || signal_pending(current)) {=
=0A=A0=A0=A0=A0 =A0=A0=A0 vcpu->mode =3D OUTSIDE_GUEST_MODE;=0A=A0=A0=A0=A0=
 =A0=A0=A0 smp_wmb();=0A+=A0=A0=A0 =A0=A0=A0 hard_cond_local_irq_enable();=
=0A=A0=A0=A0=A0 =A0=A0=A0 local_irq_enable();=0A=A0=A0=A0=A0 =A0=A0=A0 pree=
mpt_enable();=0A....=0A=0AI've done some tests and now the system runs fine=
.=0A=0AGabriele Moabiti

