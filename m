Message-ID: <4EEB304B.2010108@domain.hid>
Date: Fri, 16 Dec 2011 12:49:31 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4EE9FD4A.1090202@domain.hid>
	<CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
In-Reply-To: <CAMwkeZw4X15HU7ABUhvLpXuu1Sbspen6FK7XvjHiQLXg0AcazQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Big differences in analogy interrupt handling
 time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/15/2011 06:28 PM, Fernando Herrero Carr=C3=B3n wrote:
> 2011/12/15 Anders Blomdell<anders.blomdell@domain.hid>
>
> Hi,
>>
>> I'm trying to tweak out good performance with Analogy and a NI-6221 ca=
rd,
>> and after getting weird results with the attached program (long and ve=
ry
>> varying interrupt latencies). The machine I'm running on is a 'Intel(R=
)
>> Core(TM)2 CPU 6420 @ 2.13GHz', no frequency scaling, no X, low load,  =
only
>> one CPU enabled to minimize influence from other Linux tasks. As can b=
e
>> seen from the frozen traces (formatted and time shifted to be examined=
 with
>> 'pr -mtT -w 200 A B'), the time spent in the interrupt handling varies
>> between 263 and 329 us and there is variation even in repeated code pa=
ths
>> [which are bogus in themselves, why busy-wait 10 us in an interrupt
>> routine?], so cache poisoning should not be the issue.
>>
>> Anybody that has any insights to share?
>>
>>
> Hi everyone there,
>
> In fact, I came accross this same issue some months ago, but haven't ha=
d
> time to write on the list up to now.
>
> Actually, there seems to be some old inherited code from the early come=
di
> days. In the file ksrc/drivers/analogy/national_instruments/mio_common.=
c
> there is a function that handles transfers called "ni_handle_eos()". Yo=
u
> can see:
>
> static void ni_handle_eos(a4l_subd_t *subd)
> {
>          a4l_dev_t *dev =3D subd->dev;
>
>          if (devpriv->aimode =3D=3D AIMODE_SCAN) {
>                  static const int timeout =3D 10;
>                  int i;
>
>                  for (i =3D 0; i<  timeout; i++) {
>                          ni_sync_ai_dma(subd);
>                          /* TODO: stop when the transfer is really over=
 */
>                          a4l_udelay(1);
>                  }
>          }
>
>          /* Handle special case of single scan using AI_End_On_End_Of_S=
can */
>          if ((devpriv->ai_cmd2&  AI_End_On_End_Of_Scan)) {
>                  shutdown_ai_command(subd);
>          }
> }
>
> Just remove the "for" loop and the a4l_udelay, and leave
> ni_sync_ai_dma(subd):
>
> static void ni_handle_eos(a4l_subd_t *subd)
> {
>          a4l_dev_t *dev =3D subd->dev;
>
>          if (devpriv->aimode =3D=3D AIMODE_SCAN) {
>                  static const int timeout =3D 10;
>                  int i;
timeout and i should also be removed.

>
>                  ni_sync_ai_dma(subd);
>          }
>
>          /* Handle special case of single scan using AI_End_On_End_Of_S=
can */
>          if ((devpriv->ai_cmd2&  AI_End_On_End_Of_Scan)) {
>                  shutdown_ai_command(subd);
>          }
> }
>
> This is working for me, for the time being.
>
> Hope this helps,
Nice that somebody has already tested this.

Nobody that has any insight on what might slow down execution with 20%=20
(curious mind wants to know)?

/Anders

--=20
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


