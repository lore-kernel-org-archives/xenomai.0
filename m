MIME-Version: 1.0
In-Reply-To: <AANLkTikTyH5R8oMS-f-1jcJqryAwT-DKfzxNf1YROALK@mail.gmail.com>
References: <AANLkTikTyH5R8oMS-f-1jcJqryAwT-DKfzxNf1YROALK@mail.gmail.com>
Date: Wed, 28 Jul 2010 15:15:02 -0300
Message-ID: <AANLkTinvhF72tWwCEy85jT3Kk2cQZwRyCtBZNcSZk-yA@mail.gmail.com>
From: Rodolfo Oliveira <rodolforomao@domain.hid>
Content-Type: multipart/alternative; boundary=001636417fa3b30b36048c7698c1
Subject: [Xenomai-core] Bug - Can 2 devices.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--001636417fa3b30b36048c7698c1
Content-Type: text/plain; charset=ISO-8859-1

Hello friends,

I am developing a project and I'm using two CAN. The Can one is working, but
the CAN 2 is not, i 'm recompile the kernel enabled the can 2, but I can not
make it work.
Scenario:
- I can print the frames in CAN 2, I get in the kernel log (dmesg) and the
frames are correct.
- CAN 2 works normally if I disable the CAN 1 and recompile the kernel.

Problem:
In the "rtcan_raw.c" in function "void rtcan_rcv (struct rtcan_device * dev,
struct rtcan_skb * skb)" there is a verification "while (recv_listener! =
NULL) " and the problem is that the variable "recv_listener" is equal to
NULL . This variable comes from the function "static int
rtcan_mscan_interrupt (rtdm_irq_t irq_handle *)" (which is on file
rtcan_mscan.c) this function passes a struct as a parameter "dev = (struct
rtcan_device *) rtdm_irq_get_arg (irq_handle, void)" to "rtcan_rcv" and it
contains the recv_listener = dev-> recv_list.

Soon the CAN2 is working but there are some configuration issues in this
code.

Can anyone help me with this problem?

Thank you.

--001636417fa3b30b36048c7698c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><span><span style=3D"background-color: rgb(2=
55, 255, 255);" title=3D"Ola amigos,">Hello friends,
<br>
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"E=
stou desenvolvendo um projeto e estou utilizando duas CAN.">I am developing=
 a project and I&#39;m using two CAN. </span><span style=3D"background-colo=
r: rgb(255, 255, 255);" title=3D"A Can 1 esta funcionando, por=E9m a CAN 2 =
n=E3o esta, recompilei o kernel habilitado por=E9m n=E3o consigo faze-la fu=
ncionar.">The Can one is working, but the CAN 2 is not, i &#39;m recompile =
the kernel enabled the can 2, but I can not make it work.
<br></span><span title=3D"Cen=E1rio:">Scenario:
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"-=
 Eu consigo imprimir os frames que recebo na CAN 2 no log do kernel ( dmesg=
 ) e os frames est=E3o corretos.">- I can print the frames in CAN 2, I get =
in the kernel log (dmesg) and the frames are correct.
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"-=
 A CAN 2 funciona normalmente caso eu desabilite a CAN 1 e recompile o kern=
el.">- CAN 2 works normally if I disable the CAN 1 and recompile the kernel=
.
<br>
<br></span><span title=3D"Problema:">Problem:
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"N=
o arquivo &quot;rtcan_raw.c&quot;, na fun=E7=E3o &quot;void rtcan_rcv(struc=
t rtcan_device *dev, struct rtcan_skb *skb)&quot; existe a verifica=E7=E3o =
&quot;while (recv_listener !=3D NULL )&quot; eo problema =E9 que a vari=E1v=
el &quot;recv_listener&quot; =E9 igual a NULL">In
the &quot;rtcan_raw.c&quot; in function &quot;void rtcan_rcv (struct rtcan_=
device *
dev, struct rtcan_skb * skb)&quot; there is a verification &quot;while
(recv_listener! =3D NULL) &quot; and the problem is that the variable &quot=
;recv_listener&quot; is equal to NULL </span><span title=3D".">. </span><sp=
an style=3D"background-color: rgb(255, 255, 255);" title=3D"Esta vari=E1vel=
 vem da fun=E7=E3o &quot;static int rtcan_mscan_interrupt(rtdm_irq_t *irq_h=
andle)&quot; (que est=E1 no arquivo rtcan_mscan.c ) esta fun=E7=E3o passa c=
omo parametro a struct &quot;dev =3D (struct rtcan_device *)rtdm_irq_get_ar=
g(irq_handle, void)&quot; para &quot;rtcan_rcv&quot;">This
variable comes from the function &quot;static int rtcan_mscan_interrupt
(rtdm_irq_t irq_handle *)&quot; (which is on file rtcan_mscan.c) this
function passes a struct as a parameter &quot;dev =3D (struct rtcan_device =
*)
rtdm_irq_get_arg (irq_handle, void)&quot; to &quot;rtcan_rcv&quot; </span><=
span style=3D"background-color: rgb(255, 255, 255);" title=3D"e ela cont=E9=
m o recv_listener =3D dev-&gt;recv_list.">and it contains the recv_listener=
 =3D dev-&gt; recv_list.
<br>
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"L=
ogo a CAN2 esta funcionando por=E9m h=E1 algum problemas de configura=E7=E3=
o neste c=F3digo.">Soon the CAN2 is working but there are some configuratio=
n issues in this code.
<br>
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"A=
lgu=E9m pode me ajudar com este problema?">Can anyone help me with this pro=
blem?
<br>
<br></span><span title=3D"Obrigado.">Thank you.</span></span>
</div><br>

--001636417fa3b30b36048c7698c1--

