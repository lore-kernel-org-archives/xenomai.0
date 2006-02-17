Message-ID: <fd6a47a90602170454q1cc93f23h@domain.hid>
Date: Fri, 17 Feb 2006 13:54:23 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
In-Reply-To: <000a01c63304$94ee5190$1e01a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9332_6788013.1140180863486"
References: <43F447AF.4020604@domain.hid>
	<000a01c63304$94ee5190$1e01a8c0@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Russell Johnson <rjohnson@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_9332_6788013.1140180863486
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> I tried this patch and it doesn't solve the issue I'm facing. With and
> without this patch, my symptoms are the same.


I tested (and intended) the patch for MSI (w/o maskbits), not MSI-X. What
e1000 chip are you using exactly? Easiest way to tell is by using
'/sbin/lspci'. I may be able to help you out with MSI-X as well, but in tha=
t
case, I have no hardware platform to test on.

You can check whether or not MSI is actually being used by doing
'/sbin/lspci -v' and look for the Capability: Message Signalled Interrupt.
When the driver is running in MSI mode, it should read 'Enable+' instead of
'Enable-'.

Finally, verify how interrupts are dispatched. Have a look at
/proc/interrupts for this (cat /proc/interrupts').

I'm running a Dell 2850, dual CPU machine.


As it's a Dell, I assume there's two Intel Penium CPU's inside. Are you
running with SMP enabled ?

  When I build a kernel without
> Adeos then things are fine.  When I build with Adeos and MSI enabled the
> following occurs:
>
> 1) If BIOS has USB disabled then the system will hang without even a
> num-lock respose (i.e. tapping the num-lock key doesn't toggle the light)=
.
> The hang occurs just about the time the E1000 driver would load and enabl=
e
> an MSI interrupt.
>
> 2) If BIOS has USB enabled then the system will run much longer but may
> hang
> during heavy interrupt load on the E1000 driver.


Are you using the e1000 driver in NAPI mode ? It is recommended to do this,
especially on the preemptible kernel, as it may significantly reduce the
interrupt volume. In that case, I think it is doubtful if using MSI would
give you any benefit at all over normal, shared IRQs.

My assumption based on past experience is that no num-lock response means a=
n
> infinite interrupt loop.


The local (internal) CPU APIC hasn't been informed that the interrupt has
been dealt with and it will therefore allow no other interrupts anymore to
arrive in the CPU (including your keyboard's). In fact, your CPU is idle.

[The original 8259 was designed to detect the IRET instruction bit pattern
on the databus and use that as an acknowledge signal. Upon arrival of the
second 8259 in the PC/AT, this could no longer be done. I don't know if the
APIC could do it today (it seems possible, theoretically). ]

When I build a kernel with Adeos but disable MSI then the system works fine

> for the most part.  There is one scenario where the system will still han=
g
> doing disk and network accesses under a moderate load of I/O.


Hm. That may indicate another issue.

Both of these tests are just to get a stable kernel before I really start
> using Adeos.  So Adeos is in its default configuration and I haven't
> loaded
> Xenomai modules when these hangs occur.
>
> I'm currently running the 2.6.14.4 kernel with the 2.6.14-1.0-12 patch of
> adeos and then I included your msi.c patch from the previous e-mail.  If
> you
> have any further hints or suggestions I'll try them.  Meanwhile I'm tryin=
g
> different versions of various drivers (e1000 and scsi) as well as updatin=
g
> the patch level of the kernel itself.


Try upgrading the kernel. The kernel usually comes with updated drivers as
well. Currently I'm running 2.6.16-rc2, which I had to patch manually for
Adeos (about 3 'hunks' from the 2.6.15-i386-1.2-00 patch didn't apply
properly). By using 2.6.16-rc2, I got much better Intel (especially i865
graphics) chipset support than 2.6.15. Note, however, that I did the bug
fixing in this thread on a plain 2.6.15, though (and the msi.c code is
nearly identical).

I would recommend upgrading to 2.6.15 with the latest Adeos patch and try t=
o
get a stable system before enabling MSI.

Jeroen.

------=_Part_9332_6788013.1140180863486
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I tried this=
 patch and it doesn't solve the issue I'm facing. With and<br>without this =
patch, my symptoms are the same.
</blockquote><div><br>
I tested (and intended) the patch for MSI (w/o maskbits), not MSI-X.
What e1000 chip are you using exactly? Easiest way to tell is by using
'/sbin/lspci'. I may be able to help you out with MSI-X as well, but in
that case, I have no hardware platform to test on.<br>
<br>
You can check whether or not MSI is actually being used by doing
'/sbin/lspci -v' and look for the Capability: Message Signalled
Interrupt. When the driver is running in MSI mode, it should read
'Enable+' instead of 'Enable-'.<br>
<br>
Finally, verify how interrupts are dispatched. Have a look at /proc/interru=
pts for this (cat /proc/interrupts').<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I'm running=
 a Dell 2850, dual CPU machine.</blockquote><div><br>
As it's a Dell, I assume there's two Intel Penium CPU's inside. Are you run=
ning with SMP enabled ? <br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&nbsp;&nbsp=
;When I build a kernel without<br>Adeos then things are fine.&nbsp;&nbsp;Wh=
en I build with Adeos and MSI enabled the
<br>following occurs:<br><br>1) If BIOS has USB disabled then the system wi=
ll hang without even a<br>num-lock respose (i.e. tapping the num-lock key d=
oesn't toggle the light).<br>The hang occurs just about the time the E1000 =
driver would load and enable
<br>an MSI interrupt.<br><br>2) If BIOS has USB enabled then the system wil=
l run much longer but may hang<br>during heavy interrupt load on the E1000 =
driver.</blockquote><div><br>
Are you using the e1000 driver in NAPI mode ? It is recommended to do
this, especially on the preemptible kernel, as it may significantly
reduce the interrupt volume. In that case, I think it is doubtful if
using MSI would give you any benefit at all over normal, shared IRQs. <br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">My assumpti=
on based on past experience is that no num-lock response means an<br>infini=
te interrupt loop.
</blockquote><div><br>
The local (internal) CPU APIC hasn't been informed that the interrupt
has been dealt with and it will therefore allow no other interrupts
anymore to arrive in the CPU (including your keyboard's). In fact, your
CPU is idle.<br>
<br>
[The original 8259 was designed to detect the IRET instruction bit
pattern on the databus and use that as an acknowledge signal. Upon
arrival of the second 8259 in the PC/AT, this could no longer be done.
I don't know if the APIC could do it today (it seems possible,
theoretically). ]<br>
&nbsp;</div>When I build a kernel with Adeos but disable MSI then the syste=
m works fine<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">for the most part=
.&nbsp;&nbsp;There is one scenario where the system will still hang<br>doin=
g disk and network accesses under a moderate load of I/O.
</blockquote><div><br>
Hm. That may indicate another issue.<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Both of the=
se tests are just to get a stable kernel before I really start<br>using Ade=
os.&nbsp;&nbsp;So Adeos is in its default configuration and I haven't loade=
d
<br>Xenomai modules when these hangs occur.<br><br>
I'm currently running the <a href=3D"http://2.6.14.4">2.6.14.4</a> kernel w=
ith the 2.6.14-1.0-12 patch of<br>adeos and then I included your msi.c patc=
h from the previous e-mail.&nbsp;&nbsp;If you<br>have any further hints or =
suggestions I'll try them.&nbsp;&nbsp;Meanwhile I'm trying
<br>different versions of various drivers (e1000 and scsi) as well as updat=
ing<br>the patch level of the kernel itself.</blockquote><div><br>
Try upgrading the kernel. The kernel usually comes with updated drivers
as well. Currently I'm running 2.6.16-rc2, which I had to patch
manually for Adeos (about 3 'hunks' from the 2.6.15-i386-1.2-00 patch
didn't apply properly). By using 2.6.16-rc2, I got much better Intel
(especially i865 graphics) chipset support than 2.6.15. Note, however,
that I did the bug fixing in this thread on a plain 2.6.15, though (and
the msi.c code is nearly identical). <br>
<br>
I would recommend upgrading to 2.6.15 with the latest Adeos patch and try t=
o get a stable system before enabling MSI.<br>
</div><br></div>Jeroen.<br>
<br>

------=_Part_9332_6788013.1140180863486--

