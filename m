MIME-Version: 1.0
Date: Tue, 3 May 2011 14:07:28 +0200
Message-ID: <BANLkTikzGAMXZ--TaxmxXZDsoYJSesC26g@domain.hid>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec51a8172e6476f04a25dfb70
Subject: [Xenomai-help] reading/writing registers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec51a8172e6476f04a25dfb70
Content-Type: text/plain; charset=ISO-8859-1

hello,

I am writing a little test. I put all my RT things in a module : one ISR and
one RT task.
in init_module I call :

drv->data.regs = ioremap(0x04000000, 64*1024*1024);
drv->data.gpio = ioremap(0x40E00000, 64*1024*1024);
this is to acces registers

rthal_irq_request(8, my_rt_isr, NULL, &(drv->data));
rthal_irq_enable(8);
for the ISR

in my interrupt routine I use : writel(1, data->gpio + 0x48); for hardware
interrupt acknowledge

but when my interrupt routine is called linux is freezing so i think that I
am never going out of the ISR (I am 99.9% sure).
I am not sure but I think that It is due to the hardware interrupt
aknoledge...

my question is :
can I call "writel(1, data->gpio + 0x48);" in my ISR?
is it good or not?
is there an other way to access registers?

thanks for your answers.

PS firstly I was calling : "GEDR0 = 0x1;" but in RT task this macro doesn't
work

--bcaec51a8172e6476f04a25dfb70
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello,<br><br>I am writing a little test. I put all my RT things in a modul=
e : one ISR and one RT task.<br>in init_module I call :<br><br>drv-&gt;data=
.regs =3D ioremap(0x04000000, 64*1024*1024);<br>drv-&gt;data.gpio =3D iorem=
ap(0x40E00000, 64*1024*1024);<br>
this is to acces registers<br><br>rthal_irq_request(8, my_rt_isr, NULL, &am=
p;(drv-&gt;data));<br>rthal_irq_enable(8);<br>for the ISR<br><br>in my inte=
rrupt routine I use : writel(1, data-&gt;gpio + 0x48); for hardware interru=
pt acknowledge<br>
<br>but when my interrupt routine is called linux is freezing so i think th=
at I am never going out of the ISR (I am 99.9% sure).<br>I am not sure but =
I think that It is due to the hardware interrupt aknoledge...<br><br>my que=
stion is : <br>
can I call &quot;writel(1, data-&gt;gpio + 0x48);&quot; in my ISR? <br>is i=
t good or not? <br>is there an other way to access registers?<br><br>thanks=
 for your answers.<br><br>PS firstly I was calling : &quot;GEDR0 =3D 0x1;&q=
uot; but in RT task this macro doesn&#39;t work<br>

--bcaec51a8172e6476f04a25dfb70--

