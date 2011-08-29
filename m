MIME-Version: 1.0
Date: Mon, 29 Aug 2011 15:43:01 +0800
Message-ID: <CAHoMn5qyUPgGBk+gKQsLweYb1UixJKVk6si9P4YLiOAstL_2XQ@mail.gmail.com>
From: yi zheng <yizheng23@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6464e3a6fd83204aba00b83
Subject: [Xenomai-help] how to use rt_io_get_region function on AT91SAM9263
	in user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e6464e3a6fd83204aba00b83
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

   Hi,all
     I want to write a Xenomai application running in user space that can
access the
GPIO pins of my AT91SAM9263 ARM. To get the memory
region I found the function rt_misc_get_io_region(). Unfortunately
there is no discription of this function in the API documentation.
Does this function work like request_mem_region()?
Anybody knows how to use it,please tell me. It is best if there is a little
example.IF there is another way to access memory for user space application
on arm=A3=AC please let me  know.Thank you.
regards
yizheng

--0016e6464e3a6fd83204aba00b83
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

&nbsp; &nbsp;Hi,all<div>&nbsp; &nbsp; &nbsp;<span class=3D"Apple-style-span=
" style=3D"font-family: monospace; white-space: pre; background-color: rgb(=
255, 255, 255); font-size: medium; ">I want to write a Xenomai application =
running in user space that can access the</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; whit=
e-space: pre; background-color: rgb(255, 255, 255); font-size: medium; ">  =
 GPIO pins of my AT91SAM9263 ARM. To get the memory</span></div><div><span =
class=3D"Apple-style-span" style=3D"font-family: monospace; white-space: pr=
e; background-color: rgb(255, 255, 255); font-size: medium; ">   region I f=
ound the function rt_misc_get_io_region(). Unfortunately</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; whit=
e-space: pre; background-color: rgb(255, 255, 255); font-size: medium; ">  =
 there is no discription of this function in the API documentation.</span><=
/div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; whit=
e-space: pre; background-color: rgb(255, 255, 255); font-size: medium; ">  =
 Does this function work like request_mem_region()?</span></div><div><span =
class=3D"Apple-style-span" style=3D"font-family: monospace; white-space: pr=
e; background-color: rgb(255, 255, 255); font-size: medium; ">   Anybody kn=
ows how to use it,please tell me. It is best if there is a little example.I=
F there is another way to access memory for user space application on arm=
=A3=AC please let me&nbsp; </span><span class=3D"Apple-style-span" style=3D=
"font-family: monospace; white-space: pre; background-color: rgb(255, 255, =
255); font-size: medium; ">know.Thank you.</span></div>
<div><font class=3D"Apple-style-span" face=3D"monospace" size=3D"3"><span c=
lass=3D"Apple-style-span" style=3D"white-space: pre;">regards</span></font>=
</div><div><font class=3D"Apple-style-span" face=3D"monospace" size=3D"3"><=
span class=3D"Apple-style-span" style=3D"white-space: pre;">yizheng</span><=
/font></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; whit=
e-space: pre; background-color: rgb(255, 255, 255); font-size: medium; "><b=
r></span></div><div><span class=3D"Apple-style-span" style=3D"font-family: =
monospace; white-space: pre; background-color: rgb(255, 255, 255); font-siz=
e: medium; "><br>
</span></div>

--0016e6464e3a6fd83204aba00b83--

