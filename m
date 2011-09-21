MIME-Version: 1.0
In-Reply-To: <CAMesUR5hZ9OP_CYCQuoCGuh4NDwbYsu5jV454p0fmzKpUhg8xA@mail.gmail.com>
References: <CACRhLDksjAKdeR233NCXUG_9DrqsMmB+L=wjgudT2fZ1=XXBbg@domain.hid>
	<CACRhLDmOWDMWht-qtA=wbLU+vFHOjKS4aRa0H96kpPDoELciVw@domain.hid>
	<CAMesUR5hZ9OP_CYCQuoCGuh4NDwbYsu5jV454p0fmzKpUhg8xA@mail.gmail.com>
Date: Wed, 21 Sep 2011 15:35:25 +0200
Message-ID: <CACRhLDmY_-QeFD1q9UQO=pFc=+xanRL+QjD6DO3mjONkT93DUg@domain.hid>
From: =?ISO-8859-1?Q?Thomas_Kr=FCger?= <thomas.krueger.home@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Analogy data aquisition - How to set up the
	range correctly
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, alexis.berlemont@domain.hid

Thanks for the answer. Now it works like expected.

The solution to set the channels in a loop...

cannel_desc[i] =3D PACK(ni_6071e_analog_channels[i], ret, AREF_GROUND);

while the 'ret' argument is needed and used from the a4l_find_range functio=
n: .

Just for info in case somebody faces similar issues, here the code
from the updated initialisation funciton ...


a4l_desc_t      arm_device;
unsigned        ni_6071e_analog_channels[16] =3D
{0,1,2,4,5,6,16,17,18,19,21,23,32,33,34,35};
unsigned        channel_desc[16];
double			range_settings[16] =3D {5, 5, 2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
10, 10, 10, };
a4l_chinfo_t   *ni_6071e_analog_channel_infos[16];
a4l_rnginfo_t  *ni_6071e_analog_range_infos[16];

int analog_init =3D 0;

void init_arm()
{
   int		i =3D 0;
   int		ret;
   double	Range_Value;
   double	Range_Max;
   double	Range_Min;

   ret =3D a4l_open (&arm_device, "analogy0");

   if (ret !=3D 0)
   {
      printf ("[EXOARM] Error while opening the arm device, return
code=3D%d \n", ret);
      return;
   }
     arm_device.sbdata =3D malloc(arm_device.sbsize);


   ret =3D a4l_fill_desc (&arm_device);

   if (ret !=3D 0)
   {
      printf ("[EXOARM] Error while calling fill_desc(), return
code=3D%d \n", ret);
      return;
   }


   for (i=3D0; i<16; i ++)
   {
      ret =3D a4l_get_chinfo (&arm_device, 0,
ni_6071e_analog_channels[i], &ni_6071e_analog_channel_infos[i]);
      if (ret !=3D 0)
      {
         printf ("[EXOARM] Error invoking a4l_get_chinfo on channel
%d, return code=3D%d \n", ni_6071e_analog_channels[i], ret);
      }
      ret =3D a4l_get_rnginfo (&arm_device, 0,
ni_6071e_analog_channels[i], 0, &ni_6071e_analog_range_infos[i]);
      if (ret !=3D 0)
      {
         printf ("[EXOARM] Error invoking a4l_get_chinfo on channel
%d, return code=3D%d \n", ni_6071e_analog_channels[i], ret);
      }
   }

   //setting up the range
   for(i=3D0;i <16; i++)
   {
      Range_Value =3D range_settings[i];
      if (Range_Value < 0)
      {
         Range_Min =3D Range_Value;
      }
      else
      {
         Range_Min =3D 0.0;
      }
      Range_Max =3D abs(Range_Value);

      ret =3D a4l_find_range
            (  &arm_device,                 //device
               0,                           //subindex
               ni_6071e_analog_channels[i], //idx channel
               A4L_RNG_VOLT_UNIT,                           //unit
               Range_Min,
               Range_Max,
               &ni_6071e_analog_range_infos[i]
               );
      if ((ret =3D=3D -ENOENT) || (ret =3D=3D -EINVAL))
      {
         printf("Error while configuring ranges 6071\n");
      }
	  else
	  {
	     //set the range on the board
		 channel_desc[i] =3D PACK(ni_6071e_analog_channels[i], ret, AREF_GROUND);
	  }
   printf("Ch: %d Rng set: %.1lf Calc val: %d \n",
ni_6071e_analog_channels[i], range_settings[i], ret);//,
ni_6071e_analog_range_infos[i].min,
ni_6071e_analog_range_infos[i].max);
   }//end for loop

   analog_init =3D 1;
}

2011/9/14 Alexis Berlemont <alexis.berlemont@domain.hid>:
> Hi,
>
> Sorry for the late reply.
>
> On Wed, Sep 7, 2011 at 9:37 PM, Thomas Kr=FCger
> <thomas.krueger.home@domain.hid> wrote:
>> Dear all,
>>
>> I am using a DAQ card from national instruments 6071E to measure
>> analog values. It works fine but I have some problems changing the
>> range:
>>
>> I found the a4l_find_range function and it works well, seeing the
>> range_info changes according to my wishes. But I realise that the only
>> function that uses the range information is the a4l_rawtod. It works
>> for the range conversion but technically the range is never changed on
>> the card itself (switching to another internal gain) and so the value
>> I coming out at the end is wrong (mismatch between the setting on the
>> io-card and a4l_rawtod).
>>
>
> Yes. The only interest of a4l_find_range() is to locate the most
> suitable range descriptor according to the min and max value.
>
>> Which function do I have to use or how to pass this information to the c=
ard?
>
> You should pass the index of the selected range to thet third argument
> of a4l_sync_read: the channel descriptor. Some helper macros are
> available so as to make the setting of the channel descriptor (a
> little bit) more easier.
>
> Sorry, in the doxygen documentation of a4l_sync_read, there should be
> a link to the anchor: "Channel macros".
>
> Here is the quote from the Doxygen documentation.
> Channel macros
> Specific precompilation macros and constants useful for the channels
> descriptors tab located in the command structure
>
> #define =A0 =A0 =A0 =A0 CHAN(a) =A0 ((a) & 0xffff)
> =A0 =A0 =A0 =A0Channel indication macro.
> #define =A0 =A0 =A0 =A0 RNG(a) =A0 (((a) & 0xff) << 16)
> =A0 =A0 =A0 =A0Range definition macro.
> #define =A0 =A0 =A0 =A0 AREF(a) =A0 (((a) & 0xf) << 24)
> =A0 =A0 =A0 =A0Reference definition macro.
> #define =A0 =A0 =A0 =A0 FLAGS(a) =A0 ((a) & CR_FLAGS_MASK)
> =A0 =A0 =A0 =A0Flags definition macro.
> #define =A0 =A0 =A0 =A0 PACK(a, b, c) =A0 (CHAN(a) | RNG(b) | AREF(c))
> =A0 =A0 =A0 =A0Channel + range + reference definition macro.
> #define =A0 =A0 =A0 =A0 PACK_FLAGS(a, b, c, d) =A0 (CHAN(a) | RNG(b) | AR=
EF(c) | FLAGS(d))
> =A0 =A0 =A0 =A0Channel + range + reference + flags definition macro.
> #define =A0 =A0 =A0 =A0 AREF_GROUND =A0 0x00
> =A0 =A0 =A0 =A0Analog reference is analog ground.
> #define =A0 =A0 =A0 =A0 AREF_COMMON =A0 0x01
> =A0 =A0 =A0 =A0Analog reference is analog common.
> #define =A0 =A0 =A0 =A0 AREF_DIFF =A0 0x02
> =A0 =A0 =A0 =A0Analog reference is differential.
> #define =A0 =A0 =A0 =A0 AREF_OTHER =A0 0x03
> =A0 =A0 =A0 =A0Analog reference is undefined.
>
> I think this API should be improved; there is an ugly flaw: with
> a4l_find_range() you can retrieve the range descriptor but you have to
> pass the index of the range descriptor to a4l_sync_read (..., ...,
> PACK(0, range_index, ...), ...). This design problem forces the
> developer to use a4l_get_rnginfo() so as to deduce the related index.
>
> I will try to enrich the API so as to make the things easier.
>
>>
>> Thanks for your answers in advance.
>>
>> Cheers,
>> Thomas
>>
>>
>> My test program:
>>
>> // simple build cmd: g++ test-pcimio.c -I/usr/xenomai/include/
>> -lxenomai -lnative -lanalogy -lpthread -lrtdm -L/usr/xenomai/lib
>> // execute #./a.out
>>
>>
>> #include <time.h>
>> #include <stdio.h>
>> #include <string.h>
>> #include <stdint.h>
>> #include <stdlib.h>
>> #include <errno.h>
>> #include <xenomai/analogy/analogy.h>
>>
>> /*
>> =A0* Initialization function, activated once by PolyORB (at startup)
>> */
>> a4l_desc_t =A0 =A0 =A0arm_device;
>> int =A0 =A0 =A0 =A0 =A0 =A0 ni_6071e_analog_channels[16] =3D
>> {0,1,2,4,5,6,16,17,18,19,21,23,32,33,34,35};
>> int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 range_settin=
gs[16] =3D {-5, -10, -10, 5,
>> 5, 5, 5, -5, -5, -5, -5,
>> 10, 10, 10, -0.5, 0.5};
>> a4l_chinfo_t =A0 *ni_6071e_analog_channel_infos[16];
>> a4l_rnginfo_t =A0*ni_6071e_analog_range_infos[16];
>>
>> int analog_init =3D 0;
>>
>> void init_arm()
>> {
>> =A0 int =A0 =A0 =A0 =A0 =A0i =3D 0;
>> =A0 int =A0 =A0 =A0 =A0 =A0ret;
>> =A0 double =A0 =A0 =A0 Range_Value;
>> =A0 double =A0 =A0 =A0 Range_Max;
>> =A0 double =A0 =A0 =A0 Range_Min;
>>
>> =A0 ret =3D a4l_open (&arm_device, "analogy0");
>>
>> =A0 if (ret !=3D 0)
>> =A0 {
>> =A0 =A0 =A0printf ("[EXOARM] Error while opening the arm device, return
>> code=3D%d \n", ret);
>> =A0 =A0 =A0return;
>> =A0 }
>> =A0 =A0 arm_device.sbdata =3D malloc(arm_device.sbsize);
>>
>>
>> =A0 ret =3D a4l_fill_desc (&arm_device);
>>
>> =A0 if (ret !=3D 0)
>> =A0 {
>> =A0 =A0 =A0printf ("[EXOARM] Error while calling fill_desc(), return
>> code=3D%d \n", ret);
>> =A0 =A0 =A0return;
>> =A0 }
>>
>>
>> =A0 for (i=3D0; i<16; i ++)
>> =A0 {
>> =A0 =A0 =A0ret =3D a4l_get_chinfo (&arm_device, 0,
>> ni_6071e_analog_channels[i], &ni_6071e_analog_channel_infos[i]);
>> =A0 =A0 =A0if (ret !=3D 0)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 printf ("[EXOARM] Error invoking a4l_get_chinfo on chann=
el
>> %d, return code=3D%d \n", ni_6071e_analog_channels[i], ret);
>> =A0 =A0 =A0}
>> =A0 =A0 =A0ret =3D a4l_get_rnginfo (&arm_device, 0,
>> ni_6071e_analog_channels[i], 0, &ni_6071e_analog_range_infos[i]);
>> =A0 =A0 =A0if (ret !=3D 0)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 printf ("[EXOARM] Error invoking a4l_get_chinfo on chann=
el
>> %d, return code=3D%d \n", ni_6071e_analog_channels[i], ret);
>> =A0 =A0 =A0}
>> =A0 }
>>
>> =A0 //setting up the range
>> =A0 for(i=3D0;i <16; i++)
>> =A0 {
>> =A0 =A0 =A0Range_Value =3D range_settings[i];
>> =A0 =A0 =A0if (Range_Value < 0)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 Range_Min =3D Range_Value;
>> =A0 =A0 =A0}
>> =A0 =A0 =A0else
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 Range_Min =3D 0.0;
>> =A0 =A0 =A0}
>> =A0 =A0 =A0Range_Max =3D abs(Range_Value);
>>
>> =A0 =A0 =A0ret =3D a4l_find_range
>> =A0 =A0 =A0 =A0 =A0 =A0( =A0&arm_device, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 //device
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 //subindex
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ni_6071e_analog_channels[i], //idx channel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 A4L_RNG_VOLT_UNIT, =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 //unit
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Range_Min,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Range_Max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ni_6071e_analog_range_infos[i]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 );
>> =A0 =A0 =A0if ((ret =3D=3D -ENOENT) || (ret =3D=3D -EINVAL))
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 printf("Error while configuring ranges 6071\n");
>> =A0 =A0 =A0}
>>
>> =A0 }//end for loop
>>
>> =A0 analog_init =3D 1;
>> }
>>
>> void arm_poll_acquisition_board()
>> {
>> =A0 int i;
>> =A0 double tmp;
>> =A0 int ret;
>> =A0 uint8_t raw[128];
>>
>> =A0 if (analog_init =3D=3D 0) {
>> =A0 =A0 =A0printf("[arm] Runtime Error - Periodic task activated before
>> proper initialization.\n");
>> =A0 =A0 =A0return;
>> =A0 }
>>
>>
>> =A0 for (i=3D0; i<16; i++)
>> =A0 {
>> =A0 =A0 =A0ret =3D a4l_sync_read (&arm_device, 0,
>> ni_6071e_analog_channels[i], 0, &raw, 128);
>> =A0 =A0 =A0if (ret <=3D 0)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0printf("[arm] Error while acquiring the data\n");
>> =A0 =A0 =A0}
>>
>> =A0 =A0 =A0ret =3D a4l_rawtod (ni_6071e_analog_channel_infos[i],
>> ni_6071e_analog_range_infos[i], &tmp, &raw, 1);
>>
>> =A0 =A0 =A0if (ret <=3D 0)
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0printf("[arm] Error while converting the data\n");
>> =A0 =A0 =A0}
>> =A0 =A0 =A0else
>> =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0if(i !=3D 0)
>> {
>> printf(";");
>> }
>> =A0 =A0 =A0 =A0 =A0printf("%lf", tmp);
>>
>> =A0 =A0 =A0 =A0}
>> =A0 }
>> printf("]\n[");
>> =A0 return;
>> }
>>
>>
>>
>> int main ()
>> {
>> =A0 init_arm ();
>> =A0 while (1)
>> =A0 {
>> =A0 =A0 =A0arm_poll_acquisition_board();
>> =A0 =A0 =A0sleep (4);
>> =A0 }
>> }
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>

