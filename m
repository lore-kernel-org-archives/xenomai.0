From: davide doninelli <davide.doninelli@domain.hid>
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/alternative; boundary="Apple-Mail-1--234429734"
Date: Wed, 4 May 2011 08:24:44 +0200
In-Reply-To: <22964D33-8717-4B81-88B4-9051D0F1EA36@domain.hid>
References: <AANLkTinvryUHtzDWQa9j=Z83jNe1FbJtRYaqMHNORfvp@domain.hid>
	<4D5039AD.2070205@domain.hid>
	<AANLkTincD+0eKF7tM8aj5s4tepF0KwQ6xkJ52G1Lq4iT@mail.gmail.com>
	<4D50433D.1040804@domain.hid>
	<AANLkTi=SfPm6HVK2abFWV8uAd5wWnWv9vf0mkby8282r@domain.hid>
	<1297154320.2023.6.camel@domain.hid>
	<AANLkTim4Q_F5wY77TBH5T0oT3P2X2pex7B-8cr6Q+XyS@mail.gmail.com>
	<1297156556.2023.9.camel@domain.hid>	<4D513278.4090606@domain.hid>
	<1297167172.2023.11.camel@domain.hid>	<4D513427.6050707@domain.hid>
	<1297167750.2023.13.camel@domain.hid>	<4D5137B0.8050006@domain.hid>
	<AANLkTikh_Z8Jg0nYb=089Szzh=_gn=ZZnvBcswnGuTur@domain.hid>
	<1297169771.2023.15.camel@domain.hid>	<4D514109.9060103@domain.hid>
	<1297171546.2023.19.camel@domain.hid>
	<AANLkTik9oR2h84WKhTarsaEEDhBYhyofLPZH4SjEUZyA@mail.gmail.com>
	<BANLkTim+YXr+_tpF+np3S_+O1CSNNOSVLQ@mail.gmail.com>
	<4DA84917.1000400@domain.hid>
	<63426532-1738-4117-B6C8-C329D63AA4BF@edu.hefr.ch>
	<4DADC2AD.7030707@domain.hid>
	<22964D33-8717-4B81-88B4-9051D0F1EA36@domain.hid>
Message-ID: <EDF3F381-9F3A-4F5F-A61F-1E3E9D8FC2F6@domain.hid>
Subject: Re: [Xenomai-help] Xenomai rt_printf() don't print
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

--Apple-Mail-1--234429734
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"


Hi,
with Xenomai 2.4.10 same error.

i solved with this patch that you have made in 2009.=20

best regards=20
davide

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 0615247..a0aeec3 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -422,6 +422,7 @@ void __rt_print_init(void)
        pthread_attr_t thattr;
        const char *value_str;
        unsigned long long period;
+       unsigned stksize;

        first_buffer =3D NULL;
        seq_no =3D 0;
@@ -457,6 +458,9 @@ void __rt_print_init(void)
        pthread_cond_init(&printer_wakeup, NULL);

        pthread_attr_init(&thattr);
-       pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+       stksize =3D 32768;
+       if (stksize < PTHREAD_STACK_MIN)
+               stksize =3D PTHREAD_STACK_MIN;
+       pthread_attr_setstacksize(&thattr, stksize);
        pthread_create(&printer_thread, &thattr, printer_loop, NULL);
 }


Il giorno 19-apr-2011, alle ore 19.39, davide doninelli ha scritto:

> Hi,
> sorry i precise
> Linux kernel v.2.6.29.6
> Adeos patch 2.6.29 2.6.26-mxc
> Xenomai v. 2.4.8
>=20
> 	compiler 4.2.1
> thanks in advance
> davide
> Il giorno 19-apr-2011, alle ore 19.13, Gilles Chanteperdrix ha =
scritto:
>=20
>> davide doninelli wrote:
>>> Hi,
>>> With xenomai on the APF27, the commands rt_printf() don't print on =
console?=20
>>> Have someone  the same issue?
>>> Or i need to change some output ? (on which serial  print out)=20
>>>=20
>>>=20
>>> rt_printk() works fine.
>>>=20
>>=20
>> http://www.xenomai.org/index.php/Request_for_information
>>=20
>> --=20
>>                                                                =
Gilles.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--Apple-Mail-1--234429734
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="us-ascii"

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><br></div><div>Hi,</div><div>with Xenomai 2.4.10 same =
error.</div><div><br></div><div>i solved with this patch that you have =
made in 2009.&nbsp;</div><div><br></div><div>best =
regards&nbsp;</div><div>davide</div><div><br></div><div><span =
class=3D"Apple-style-span" style=3D"font-family: monospace; "><pre>diff =
--git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 0615247..a0aeec3 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -422,6 +422,7 @@ void __rt_print_init(void)
        pthread_attr_t thattr;
        const char *value_str;
        unsigned long long period;
+       unsigned stksize;

        first_buffer =3D NULL;
        seq_no =3D 0;
@@ -457,6 +458,9 @@ void __rt_print_init(void)
        pthread_cond_init(&amp;printer_wakeup, NULL);

        pthread_attr_init(&amp;thattr);
-       pthread_attr_setstacksize(&amp;thattr, PTHREAD_STACK_MIN);
+       stksize =3D 32768;
+       if (stksize &lt; PTHREAD_STACK_MIN)
+               stksize =3D PTHREAD_STACK_MIN;
+       pthread_attr_setstacksize(&amp;thattr, stksize);
        pthread_create(&amp;printer_thread, &amp;thattr, printer_loop, =
NULL);
 }</pre></span><div><br></div></div><br><div><div>Il giorno 19-apr-2011, =
alle ore 19.39, davide doninelli ha scritto:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">Hi,<div>sorry i =
precise</div><div><span class=3D"Apple-style-span" style=3D"font-family: =
sans-serif; font-size: 13px; line-height: 19px; "><ul =
style=3D"line-height: 1.5em; list-style-type: square; margin-top: 0.3em; =
margin-right: 0px; margin-bottom: 0px; margin-left: 1.5em; padding-top: =
0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; =
list-style-image: url(http://www.xenomai.org/skins/monobook/bullet.gif); =
"><li style=3D"margin-bottom: 0.1em; ">Linux kernel v.2.6.29.6</li><li =
style=3D"margin-bottom: 0.1em; ">Adeos patch 2.6.29 2.6.26-mxc</li><li =
style=3D"margin-bottom: 0.1em; ">Xenomai v. =
2.4.8</li></ul></span><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre"><br></span></div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>compiler =
4.2.1</div><div>thanks in advance</div><div>davide</div><div><div>Il =
giorno 19-apr-2011, alle ore 19.13, Gilles Chanteperdrix ha =
scritto:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div>davide doninelli wrote:<br><blockquote =
type=3D"cite">Hi,<br></blockquote><blockquote type=3D"cite">With xenomai =
on the APF27, the commands rt_printf() don't print on console? =
<br></blockquote><blockquote type=3D"cite">Have someone &nbsp;the same =
issue?<br></blockquote><blockquote type=3D"cite">Or i need to change =
some output ? (on which serial &nbsp;print out) =
<br></blockquote><blockquote type=3D"cite"><br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">rt_printk() =
works fine.<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><br><a =
href=3D"http://www.xenomai.org/index.php/Request_for_information">http://w=
ww.xenomai.org/index.php/Request_for_information</a><br><br>-- <br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;Gilles.<br></div></blockquote></div><br></div></div>______________=
_________________________________<br>Xenomai-help mailing list<br><a =
href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>https://m=
ail.gna.org/listinfo/xenomai-help<br></blockquote></div><br></body></html>=

--Apple-Mail-1--234429734--

