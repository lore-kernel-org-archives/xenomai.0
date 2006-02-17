Message-ID: <fd6a47a90602170757q15fed14x@domain.hid>
Date: Fri, 17 Feb 2006 16:57:33 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <43F5CAE8.9010905@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_11020_25028006.1140191853722"
References: <43F447AF.4020604@domain.hid>
	<000a01c63304$94ee5190$1e01a8c0@domain.hid>
	<fd6a47a90602170454q1cc93f23h@domain.hid>
	<43F5CAE8.9010905@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_11020_25028006.1140191853722
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> Could you post the patch you are successfully using to boot your box? TIA=
,



--- linux-2.6.15/drivers/pci/msi.c      2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-ipipe/drivers/pci/msi.c        2006-02-17 16:48:
21.000000000 +0100
@@ -185,10 +185,20 @@
        spin_unlock_irqrestore(&msi_lock, flags);
 }

+#if defined(CONFIG_IPIPE)
+/* Attention: only MSI without maskbits is currently fixed for I-PIPE */
+static void ack_msi_irq_wo_maskbit(unsigned int vector)
+{
+       __ack_APIC_irq();
+}
+#endif /* CONFIG_IPIPE */
+
 static void end_msi_irq_wo_maskbit(unsigned int vector)
 {
        move_native_irq(vector);
+#if !defined(CONFIG_IPIPE)
        ack_APIC_irq();
+#endif /* !CONFIG_IPIPE */
 }

 static void end_msi_irq_w_maskbit(unsigned int vector)
@@ -244,7 +254,11 @@
        .shutdown       =3D shutdown_msi_irq,
        .enable         =3D do_nothing,
        .disable        =3D do_nothing,
+#if defined(CONFIG_IPIPE)
+       .ack            =3D ack_msi_irq_wo_maskbit,
+#else /* CONFIG_IPIPE */
        .ack            =3D do_nothing,
+#endif /* !CONFIG_IPIPE */
        .end            =3D end_msi_irq_wo_maskbit,
        .set_affinity   =3D set_msi_irq_affinity
 };


Jeroen.

------=_Part_11020_25028006.1140191853722
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Could you po=
st the patch you are successfully using to boot your box? TIA,</blockquote>=
<div>
<br>
<br>
--- linux-2.6.15/drivers/pci/msi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-01-03=
 04:21:10.000000000 +0100<br>
+++ linux-2.6.15-ipipe/drivers/pci/msi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 2006-02-17 16:48:21.000000000 +0100<br>
@@ -185,10 +185,20 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;msi_=
lock, flags);<br>
&nbsp;}<br>
<br>
+#if defined(CONFIG_IPIPE)<br>
+/* Attention: only MSI without maskbits is currently fixed for I-PIPE */<b=
r>
+static void ack_msi_irq_wo_maskbit(unsigned int vector)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ack_APIC_irq();<br>
+}<br>
+#endif /* CONFIG_IPIPE */<br>
+<br>
&nbsp;static void end_msi_irq_wo_maskbit(unsigned int vector)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; move_native_irq(vector);<br>
+#if !defined(CONFIG_IPIPE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ack_APIC_irq();<br>
+#endif /* !CONFIG_IPIPE */<br>
&nbsp;}<br>
<br>
&nbsp;static void end_msi_irq_w_maskbit(unsigned int vector)<br>
@@ -244,7 +254,11 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .shutdown&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =3D shutdown_msi_irq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D do_nothing,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D do_nothing,<br>
+#if defined(CONFIG_IPIPE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.ack&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D ack_msi_irq_wo_maskbit,<br>
+#else /* CONFIG_IPIPE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D do_nothing,<br>
+#endif /* !CONFIG_IPIPE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D end_msi_irq_wo_maskbit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_affinity&nbsp;&nbsp; =3D se=
t_msi_irq_affinity<br>
&nbsp;};<br>
<br>
</div></div><br>
Jeroen.<br>

------=_Part_11020_25028006.1140191853722--

