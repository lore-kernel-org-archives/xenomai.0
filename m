MIME-Version: 1.0
Date: Mon, 24 Jan 2011 20:33:58 -0600
Message-ID: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba1819da6c2505049aa28c84
Subject: [Xenomai-help] Segmentation Fault when writing in registers
	(AT91SAM - ARM9)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--90e6ba1819da6c2505049aa28c84
Content-Type: text/plain; charset=ISO-8859-1

Hi.

I  was testing Xenomai on my AT91SAM9G20-based board and tried to adapt the
code found here:
http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs .
The only difference between my code and theirs was the access to hardware. I
used open("/dev/mem", ...) and mmap().
The program compiles fine and both functions are executed. However,  when I
place values in PIO registers, I get Segmentation Fault.

I tested my code without Xenomai and it does what it is suppose to do.

Here's the configuration of my system:
Processor: AT91SAM9G20
Xenomai version: 2.5.5.2
Kernel: 2.6.33-5
GCC 4.3.2 (I compile the code on the board)

----------------  Code snippet  -------------------
unsigned char *pioa_base, *aic_base;

void open_controller(){


    if((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1)
    {
    ....
    }
    printf("/dev/mem opened.\n");

    /* mapping of PIOB */
    aic_base =  mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
AT91C_BASE_PIOB & (~MAP_MASK));
    piob_base = aic_base + AT91C_BASE_PIOB - AT91C_BASE_AIC;

    if( (pioa_base == (void *) -1)) {
        ...
    }

     *((unsigned int *) (piob_base + PIO_IDR ))  = 1<<0; // Segmentation
Fault occurs here
     *((unsigned int *) (piob_base + PIO_PER))  = 1<<0;
     ...
}
---------------------------------------------------------

Thank you,
R.

--90e6ba1819da6c2505049aa28c84
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.<br><br>I=A0 was testing Xenomai on my AT91SAM9G20-based board and tried=
 to adapt the code found here: <a href=3D"http://www.armadeus.com/wiki/inde=
x.php?title=3DXenomai:Blinking_LEDs">http://www.armadeus.com/wiki/index.php=
?title=3DXenomai:Blinking_LEDs</a> .<br>
The only difference between my code and theirs was the access to hardware. =
I used open(&quot;/dev/mem&quot;, ...) and mmap(). <br>The program compiles=
 fine and both functions are executed. However,=A0 when I place values in P=
IO registers, I get Segmentation Fault.<br>
<br>I tested my code without Xenomai and it does what it is suppose to do.<=
br><br>Here&#39;s the configuration of my system:<br>Processor: AT91SAM9G20=
<br>Xenomai version: 2.5.5.2<br>Kernel: 2.6.33-5<br>GCC 4.3.2 (I compile th=
e code on the board)<br>
<br>----------------=A0 Code snippet=A0 -------------------<br>unsigned cha=
r *pioa_base, *aic_base; <br><br>void open_controller(){<br><br><br>=A0=A0=
=A0 if((fd =3D open(&quot;/dev/mem&quot;, O_RDWR | O_SYNC)) =3D=3D -1) <br>=
=A0=A0=A0 {<br>=A0=A0=A0 ....<br>
=A0=A0=A0 }<br>=A0=A0=A0 printf(&quot;/dev/mem opened.\n&quot;); <br>=A0 <b=
r>=A0=A0=A0 /* mapping of PIOB */<br>=A0=A0=A0 aic_base =3D=A0 mmap(0, MAP_=
SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, AT91C_BASE_PIOB &amp; (~MAP_M=
ASK));<br>=A0=A0=A0 piob_base =3D aic_base + AT91C_BASE_PIOB - AT91C_BASE_A=
IC;<br>
=A0=A0=A0 <br>=A0=A0=A0 if( (pioa_base =3D=3D (void *) -1)) {<br>=A0=A0=A0=
=A0=A0=A0=A0 ...<br>=A0=A0=A0 }<br><br>=A0=A0=A0=A0 *((unsigned int *) (pio=
b_base + PIO_IDR ))=A0 =3D 1&lt;&lt;0; // Segmentation Fault occurs here<br=
>=A0=A0=A0=A0 *((unsigned int *) (piob_base + PIO_PER))=A0 =3D 1&lt;&lt;0;<=
br>
=A0=A0=A0=A0 ...<br>}<br>--------------------------------------------------=
-------<br><br>Thank you,<br>R.<br><br><br><br><br><br>

--90e6ba1819da6c2505049aa28c84--

