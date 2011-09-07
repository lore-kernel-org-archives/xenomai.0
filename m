MIME-Version: 1.0
In-Reply-To: <CACRhLDksjAKdeR233NCXUG_9DrqsMmB+L=wjgudT2fZ1=XXBbg@domain.hid>
References: <CACRhLDksjAKdeR233NCXUG_9DrqsMmB+L=wjgudT2fZ1=XXBbg@domain.hid>
Date: Wed, 7 Sep 2011 21:37:24 +0200
Message-ID: <CACRhLDmOWDMWht-qtA=wbLU+vFHOjKS4aRa0H96kpPDoELciVw@domain.hid>
From: =?ISO-8859-1?Q?Thomas_Kr=FCger?= <thomas.krueger.home@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Analogy data aquisition - How to set up the range
	correctly
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

Dear all,

I am using a DAQ card from national instruments 6071E to measure
analog values. It works fine but I have some problems changing the
range:

I found the a4l_find_range function and it works well, seeing the
range_info changes according to my wishes. But I realise that the only
function that uses the range information is the a4l_rawtod. It works
for the range conversion but technically the range is never changed on
the card itself (switching to another internal gain) and so the value
I coming out at the end is wrong (mismatch between the setting on the
io-card and a4l_rawtod).

Which function do I have to use or how to pass this information to the card=
?

Thanks for your answers in advance.

Cheers,
Thomas


My test program:

// simple build cmd: g++ test-pcimio.c -I/usr/xenomai/include/
-lxenomai -lnative -lanalogy -lpthread -lrtdm -L/usr/xenomai/lib
// execute #./a.out


#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <errno.h>
#include <xenomai/analogy/analogy.h>

/*
=A0* Initialization function, activated once by PolyORB (at startup)
*/
a4l_desc_t =A0 =A0 =A0arm_device;
int =A0 =A0 =A0 =A0 =A0 =A0 ni_6071e_analog_channels[16] =3D
{0,1,2,4,5,6,16,17,18,19,21,23,32,33,34,35};
int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 range_settings[=
16] =3D {-5, -10, -10, 5,
5, 5, 5, -5, -5, -5, -5,
10, 10, 10, -0.5, 0.5};
a4l_chinfo_t =A0 *ni_6071e_analog_channel_infos[16];
a4l_rnginfo_t =A0*ni_6071e_analog_range_infos[16];

int analog_init =3D 0;

void init_arm()
{
=A0 int =A0 =A0 =A0 =A0 =A0i =3D 0;
=A0 int =A0 =A0 =A0 =A0 =A0ret;
=A0 double =A0 =A0 =A0 Range_Value;
=A0 double =A0 =A0 =A0 Range_Max;
=A0 double =A0 =A0 =A0 Range_Min;

=A0 ret =3D a4l_open (&arm_device, "analogy0");

=A0 if (ret !=3D 0)
=A0 {
=A0 =A0 =A0printf ("[EXOARM] Error while opening the arm device, return
code=3D%d \n", ret);
=A0 =A0 =A0return;
=A0 }
=A0 =A0 arm_device.sbdata =3D malloc(arm_device.sbsize);


=A0 ret =3D a4l_fill_desc (&arm_device);

=A0 if (ret !=3D 0)
=A0 {
=A0 =A0 =A0printf ("[EXOARM] Error while calling fill_desc(), return
code=3D%d \n", ret);
=A0 =A0 =A0return;
=A0 }


=A0 for (i=3D0; i<16; i ++)
=A0 {
=A0 =A0 =A0ret =3D a4l_get_chinfo (&arm_device, 0,
ni_6071e_analog_channels[i], &ni_6071e_analog_channel_infos[i]);
=A0 =A0 =A0if (ret !=3D 0)
=A0 =A0 =A0{
=A0 =A0 =A0 =A0 printf ("[EXOARM] Error invoking a4l_get_chinfo on channel
%d, return code=3D%d \n", ni_6071e_analog_channels[i], ret);
=A0 =A0 =A0}
=A0 =A0 =A0ret =3D a4l_get_rnginfo (&arm_device, 0,
ni_6071e_analog_channels[i], 0, &ni_6071e_analog_range_infos[i]);
=A0 =A0 =A0if (ret !=3D 0)
=A0 =A0 =A0{
=A0 =A0 =A0 =A0 printf ("[EXOARM] Error invoking a4l_get_chinfo on channel
%d, return code=3D%d \n", ni_6071e_analog_channels[i], ret);
=A0 =A0 =A0}
=A0 }

=A0 //setting up the range
=A0 for(i=3D0;i <16; i++)
=A0 {
=A0 =A0 =A0Range_Value =3D range_settings[i];
=A0 =A0 =A0if (Range_Value < 0)
=A0 =A0 =A0{
=A0 =A0 =A0 =A0 Range_Min =3D Range_Value;
=A0 =A0 =A0}
=A0 =A0 =A0else
=A0 =A0 =A0{
=A0 =A0 =A0 =A0 Range_Min =3D 0.0;
=A0 =A0 =A0}
=A0 =A0 =A0Range_Max =3D abs(Range_Value);

=A0 =A0 =A0ret =3D a4l_find_range
=A0 =A0 =A0 =A0 =A0 =A0( =A0&arm_device, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //=
device
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 //subindex
=A0 =A0 =A0 =A0 =A0 =A0 =A0 ni_6071e_analog_channels[i], //idx channel
=A0 =A0 =A0 =A0 =A0 =A0 =A0 A4L_RNG_VOLT_UNIT, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 //unit
=A0 =A0 =A0 =A0 =A0 =A0 =A0 Range_Min,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 Range_Max,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &ni_6071e_analog_range_infos[i]
=A0 =A0 =A0 =A0 =A0 =A0 =A0 );
=A0 =A0 =A0if ((ret =3D=3D -ENOENT) || (ret =3D=3D -EINVAL))
=A0 =A0 =A0{
=A0 =A0 =A0 =A0 printf("Error while configuring ranges 6071\n");
=A0 =A0 =A0}

=A0 }//end for loop

=A0 analog_init =3D 1;
}

void arm_poll_acquisition_board()
{
=A0 int i;
=A0 double tmp;
=A0 int ret;
=A0 uint8_t raw[128];

=A0 if (analog_init =3D=3D 0) {
=A0 =A0 =A0printf("[arm] Runtime Error - Periodic task activated before
proper initialization.\n");
=A0 =A0 =A0return;
=A0 }


=A0 for (i=3D0; i<16; i++)
=A0 {
=A0 =A0 =A0ret =3D a4l_sync_read (&arm_device, 0,
ni_6071e_analog_channels[i], 0, &raw, 128);
=A0 =A0 =A0if (ret <=3D 0)
=A0 =A0 =A0{
=A0 =A0 =A0 =A0 =A0printf("[arm] Error while acquiring the data\n");
=A0 =A0 =A0}

=A0 =A0 =A0ret =3D a4l_rawtod (ni_6071e_analog_channel_infos[i],
ni_6071e_analog_range_infos[i], &tmp, &raw, 1);

=A0 =A0 =A0if (ret <=3D 0)
=A0 =A0 =A0{
=A0 =A0 =A0 =A0 =A0printf("[arm] Error while converting the data\n");
=A0 =A0 =A0}
=A0 =A0 =A0else
=A0 =A0 =A0{
=A0 =A0 =A0 =A0if(i !=3D 0)
{
printf(";");
}
=A0 =A0 =A0 =A0 =A0printf("%lf", tmp);

=A0 =A0 =A0 =A0}
=A0 }
printf("]\n[");
=A0 return;
}



int main ()
{
=A0 init_arm ();
=A0 while (1)
=A0 {
=A0 =A0 =A0arm_poll_acquisition_board();
=A0 =A0 =A0sleep (4);
=A0 }
}

