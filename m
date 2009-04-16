MIME-Version: 1.0
In-Reply-To: <49E73DE7.9020307@domain.hid>
References: <37f89760904160447j7399b4ctced93a3e4956db6a@domain.hid>
	<49E72BA8.20203@domain.hid>
	<37f89760904160654g43fde4f0l6cd228faa65d6baf@domain.hid>
	<49E73DE7.9020307@domain.hid>
Date: Thu, 16 Apr 2009 16:55:45 +0200
Message-ID: <37f89760904160755y2e056c3cq1b86d3adf2160b0b@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=001485f0a01e49e9270467ad427a
Subject: Re: [Xenomai-help] driver: IOCTL command behavior
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--001485f0a01e49e9270467ad427a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
here is the my ioctl function and the header file below.


/*****************************************************************************************/
int rt_gpio_ioctl(struct rtdm_dev_context *context,
                  rtdm_user_info_t *user_info,
                  unsigned int request, void *arg)
{
    struct rt_gpio_context *ctx_gpio;
    int err = 0;
    unsigned long base;
    int mode;

    ctx_gpio = (struct rt_gpio_context *)context->dev_private;
    base = ctx_gpio->base_addr;
    mode = rt_gpio_io_mode_from_ctx_gpio(ctx_gpio);

    printk(KERN_INFO "IOCTL : request %x\n", request);
    switch (request)
    {
    case RT_GPIO_RTIOC_GET_DIRECTION:
        {
            /*
            ** 1 = input and 0 = output, by default all are inputs.
            */
            int gpio_dir;

            gpio_dir = rt_gpio_reg_in(mode, base, OFF_MPIOSEL);
            printk(KERN_INFO "GET_DIRECTION %x\n", gpio_dir);

            if (user_info)
            {
                err = rtdm_safe_copy_to_user(user_info, arg,
                                             &gpio_dir, sizeof(int));
            }
            else
            {
                *(int *)arg = gpio_dir;
            }

            break;
        }

    case RT_GPIO_RTIOC_SET_DIRECTION:
        {
            /*
            ** 1 = input and 0 = output, by default all are inputs.
            */
            unsigned int gpio_dir = (unsigned int)arg;

            rt_gpio_reg_out(mode, base, OFF_MPIOSEL, gpio_dir);
            printk(KERN_INFO "SET_DIRECTION %x\n", gpio_dir);

            break;
        }

    default:
        err = -ENOTTY;
    }

    return err;
}


/**************************************************************************************************/
header file
/**************************************************************************************************/

#ifndef _RTGPIO_H
#define _RTGPIO_H

#include <rtdm/rtdm.h>

#define RT_GPIO_PROFILE_VER        2

#define RTIOC_TYPE_GPIO                 RTDM_CLASS_GPIO
#define RTDM_SUBCLASS_GPIO              0

#define RT_GPIO_RTIOC_GET_DIRECTION\
    _IOR(RTIOC_TYPE_GPIO, 0x00, int)

#define RT_GPIO_RTIOC_SET_DIRECTION\
    _IOR(RTIOC_TYPE_GPIO, 0x01, int)

#endif /* _RTGPIO_H */

/**************************************************************************************************/

So for the "RT_GPIO_RTIOC_SET_DIRECTION"  when I switch "_IOR(RTIOC_TYPE_GPIO,
0x01, int)" to "_IOW(RTIOC_TYPE_GPIO, 0x01, int)" or "_IOWR(RTIOC_TYPE_GPIO,
0x01, int)", the switch pass in "default".

Someone as an explanation ?
Thanks,
Marcel.

--001485f0a01e49e9270467ad427a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br>here is the my ioctl function and the header file below.<br><br><br=
>/*************************************************************************=
****************/<br>int rt_gpio_ioctl(struct rtdm_dev_context *context,<br=
>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtdm_user_info_t *user_=
info,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int r=
equest, void *arg)<br>{<br>=A0=A0=A0 struct rt_gpio_context *ctx_gpio;<br>=
=A0=A0=A0 int err =3D 0;<br>=A0=A0=A0 unsigned long base;<br>=A0=A0=A0 int =
mode;<br><br>=A0=A0=A0 ctx_gpio =3D (struct rt_gpio_context *)context-&gt;d=
ev_private;<br>
=A0=A0=A0 base =3D ctx_gpio-&gt;base_addr;<br>=A0=A0=A0 mode =3D rt_gpio_io=
_mode_from_ctx_gpio(ctx_gpio);<br><br>=A0=A0=A0 printk(KERN_INFO &quot;IOCT=
L : request %x\n&quot;, request);<br>=A0=A0=A0 switch (request)<br>=A0=A0=
=A0 {<br>=A0=A0=A0 case RT_GPIO_RTIOC_GET_DIRECTION:<br>
=A0=A0=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 ** 1 =3D input and 0 =3D output, by default all=
 are inputs.<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 int gpio_dir;<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpio=
_dir =3D rt_gpio_reg_in(mode, base, OFF_MPIOSEL);<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 printk(KERN_INFO &quot;GET_DIRECTION %x\n&quot;, gpio_dir);<br=
>
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (user_info)<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D =
rtdm_safe_copy_to_user(user_info, arg,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 &amp;gpio_dir, sizeof(int));<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 }<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 *(int *)arg =3D gpio_dir;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<=
br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;<br>=A0=A0=A0=A0=A0=A0=A0 }<=
br><br>=A0=A0=A0 case RT_GPIO_RTIOC_SET_DIRECTION:<br>=A0=A0=A0=A0=A0=A0=A0=
 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ** 1 =3D input and 0 =3D output, by default all are inputs.<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u=
nsigned int gpio_dir =3D (unsigned int)arg;<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 rt_gpio_reg_out(mode, base, OFF_MPIOSEL, gpio_dir);<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_INFO &quot;SET_DIRECTION %x\n&quot;, g=
pio_dir);<br>
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;<br>=A0=A0=A0=A0=A0=A0=A0 }<br>=
<br>=A0=A0=A0 default:<br>=A0=A0=A0=A0=A0=A0=A0 err =3D -ENOTTY;<br>=A0=A0=
=A0 }<br><br>=A0=A0=A0 return err;<br>}<br><br><br>/***********************=
***************************************************************************=
/<br>
header file<br>/***********************************************************=
***************************************/<br><br>#ifndef _RTGPIO_H<br>#defin=
e _RTGPIO_H<br><br>#include &lt;rtdm/rtdm.h&gt;<br><br>#define RT_GPIO_PROF=
ILE_VER=A0=A0=A0 =A0=A0=A0 2<br>
<br>#define RTIOC_TYPE_GPIO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 RTDM_CLASS_GPIO<br>#define RTDM_SUBCLASS_GPIO=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0<br><br>#define RT_GPIO_RTIOC_GET_DIRECTION\<br>=A0=A0=A0 _IO=
R(RTIOC_TYPE_GPIO, 0x00, int)<br><br>#define RT_GPIO_RTIOC_SET_DIRECTION\<b=
r>
=A0=A0=A0 _IOR(RTIOC_TYPE_GPIO, 0x01, int)<br><br>#endif /* _RTGPIO_H */<br=
><br>/*********************************************************************=
*****************************/<br><br>So for the &quot;<span style=3D"color=
: rgb(0, 0, 153);">RT_GPIO_RTIOC_SET_DIRECTION</span>&quot;=A0 when I switc=
h &quot;<span style=3D"color: rgb(0, 0, 153);">_IOR(RTIOC_TYPE_GPIO, 0x01, =
int)</span>&quot; to &quot;<span style=3D"color: rgb(0, 0, 153);">_IOW(RTIO=
C_TYPE_GPIO, 0x01, int)</span>&quot; or &quot;<span style=3D"color: rgb(0, =
0, 153);">_IOWR(RTIOC_TYPE_GPIO, 0x01, int)</span>&quot;, the switch pass i=
n &quot;default&quot;.<br>
<br>Someone as an explanation ?<br>Thanks,<br>Marcel.<br><br><br><br><br><b=
r><br>

--001485f0a01e49e9270467ad427a--

