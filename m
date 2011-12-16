MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
In-Reply-To: <CA+eKTkZFiMTFZe4jyhhD3b064bQDQMMcgVW+YMU5SJKeVnCiZA@mail.gmail.com>
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
	<4ECA2FF8.7040406@domain.hid>
	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>
	<4ECA5E12.5040907@domain.hid>
	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>
	<4ECB967C.70509@domain.hid>
	<CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>
	<CAMesUR6Jx7WuZNsY6WmomD-ExoJ9hhKovKiekrr71Kbrk7Jb_A@mail.gmail.com>
	<4ECCB27F.3040903@domain.hid>
	<CA+eKTkZp5M8OTHyLBBM=S5=5C-WaVrLgSsWOtzA1_y=z4ujTJw@domain.hid>
	<CA+eKTkZFiMTFZe4jyhhD3b064bQDQMMcgVW+YMU5SJKeVnCiZA@mail.gmail.com>
Date: Fri, 16 Dec 2011 13:39:36 +0100
Message-ID: <CA+eKTkbcuv6GkD1mwz_p++F7144fF3Eq0gisg69yAdH9KneD3w@domain.hid>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/alternative; boundary=f46d043bdfb8c7f10a04b434e4f0
Subject: Re: [Xenomai-help] [xenomai-help] Error return with a4l_sync_write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org, Alexis Berlemont <alexis.berlemont@domain.hid>, Anders Blomdell <anders.blomdell@domain.hid>

--f46d043bdfb8c7f10a04b434e4f0
Content-Type: text/plain; charset=ISO-8859-1

Hello again !
I am kind of stuck right now, anybody has an idea regarding my post ?
Anyone able to help ?

Thanks in advance,

Hadrien


On Thu, Dec 8, 2011 at 3:36 PM, Hadrien Caron <hadrien.caron@domain.hid>wrote:

> Hello again to all,
>
> I have been trying to look at the problem and finding it's source
> following the various advice you gave me.
> My problem is still trying to use the DIO channels of my NI-DAQ card
>
> I updated my xenomai configuration :
>
> xenomai 2.6.0
> ubuntu 10.10 kernel 2.6.38-8
>
> with a NI-Daq card : PCI-6221
>
> --------------------
> $ lspci | grep National
> 06:05.0 Unassigned class [ff00]: National Instruments Device 71bc
> --------------------
> 71bc is the device_id of pci-6221_37pin according to pcimio.c . . . So to
> me this is a good sign and that means that the device is well recognised.
> But in the header of pcimio.c I see :
>   "- Digital I/O may not work on 673x.
>  * - Information (number of channels, bits, etc.) for some devices may
>  *   be incorrect.  Please check this and submit a bug if there are
>  *   problems for your device"
>
> So I am starting to be afraid that there might be a bug and that the
> information for my device is not accurate (even though the issue reported
> is not about my card).
>
> Furthermore, I tried using the cmd_bits program to use the DIO channels.
>
> First, here is the content of my 00-analogy_ni_pcimio file :
> jb@domain.hid$ cat 00-analogy_ni_pcimio
> --  Subdevices --
>
> | idx | type
> |  00 | Analog input subdevice
> |  01 | Analog output subdevice
> |  02 | Digital input/output subdevice
> |  03 | Unused subdevice
> |  04 | Unused subdevice
> |  05 | Calibration subdevice
> |  06 | Memory subdevice
> |  07 | Digital input/output subdevice
> |  08 | Unused subdevice
> |  09 | Serial subdevice
> |  10 | Unused subdevice
> |  11 | Counter subdevice
> |  12 | Counter subdevice
> |  13 | Counter subdevice
>
> jb@domain.hid$ sudo ./cmd_bits -d analogy0 -s 1
> cmd_bits: selected subdevice is not digital
>
> # Which seems normal : idx 1 is for analog Output. But if I use "-s 2" or
> "-s 7" I get :
>
> jb@domain.hid$ sudo ./cmd_bits -d analogy0 -s 7
> cmd_bits: a4l_snd_command failed (err=-5)
>
> thant I used the errno.sh tool :
> ./errno.sh 5
> #define    EIO         5    /* I/O error */
>
> and in the Xenomai API documentation I read about a4l_snd_command :
> -EIO is returned if the selected subdevice cannot handle command
>
> So I am not sure what to make up of all this. I feel like there is a
> problem with the implementation
> of analogy_pcmio for my NI-DAQ card. If this is the case, I would be happy
> (to at least try) to fix it myself (with a little help to get myself
> started maybe ^^), or do you think the problem is elsewhere ?
>
> Thank you very much for reading this :)
>
> Sincerely,
>
> Hadrien
>
>
> On Wed, Nov 23, 2011 at 10:53 AM, Hadrien Caron <hadrien.caron@domain.hid>wrote:
>
>> I use Xenomai 2.5.6 with drivers nipcimio. Should I try it with the
>> latest 2.6 version ?
>>
>> Thanks again for all your ideas !
>>
>> Hadrien
>>
>>
>> On Wed, Nov 23, 2011 at 9:44 AM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>>> On 11/22/2011 11:33 PM, Alexis Berlemont wrote:
>>> > On Tue, Nov 22, 2011 at 2:43 PM, Hadrien Caron <
>>> hadrien.caron@domain.hid> wrote:
>>> >> Alexis : yes I am using the Analogy drivers . . . Would that mean that
>>> >> analog output is implemented but not digital output for National
>>> Instrument
>>> >> acquisition cards ? Has someone tried this already ? Seems strange
>>> that
>>> >> analog output would be implemented but not digital.
>>> >>
>>> >> Anders : Ok ! I will look into rebulding my xenomai installation then
>>> !
>>> >
>>> > According to the thread:
>>> > [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails with
>>> ENOSYS)
>>> > https://mail.gna.org/public/xenomai-core/2011-07/msg00010.html
>>> > The problem related by Anders Blomdell is supposed to be fixed with
>>> > the 2.6 release, isn't it?
>>> >
>>> > Could you tell us which version of Xenomai and which driver
>>> > (ni_pcimio, ...) you are using?
>>>
>>> Hi,
>>>
>>> the problem is not fixed, we can not compile xenomai without frame
>>> pointers.
>>>
>>> --
>>>                                                                Gilles.
>>>
>>
>>
>

--f46d043bdfb8c7f10a04b434e4f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello again ! <br>I am kind of stuck right now, anybody has an idea regardi=
ng my post ?<br>Anyone able to help ?<br><br>Thanks in advance,<br><br>Hadr=
ien<br><br><br><div class=3D"gmail_quote">On Thu, Dec 8, 2011 at 3:36 PM, H=
adrien Caron <span dir=3D"ltr">&lt;<a href=3D"mailto:hadrien.caron@domain.hid=
m">hadrien.caron@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hello again to all,<br><b=
r>I have been trying to look at the problem and finding it&#39;s source fol=
lowing the various advice you gave me.<br>
My problem is still trying to use the DIO channels of my NI-DAQ card<br><br=
>I updated my xenomai configuration :<br>


<br>xenomai 2.6.0<br>ubuntu 10.10 kernel 2.6.38-8<br><br>with a NI-Daq card=
 : PCI-6221<br><br>--------------------<br>$ lspci | grep National<br>06:05=
.0 Unassigned class [ff00]: National Instruments Device 71bc<br>

--------------------<br>71bc is the device_id of pci-6221_37pin according t=
o pcimio.c . . . So to me this is a good sign and that means that the devic=
e is well recognised. But in the header of pcimio.c I see : <br>

=A0 &quot;- Digital I/O may not work on 673x.<br>=A0* - Information (number=
 of channels, bits, etc.) for some devices may<br>=A0*=A0=A0 be incorrect.=
=A0 Please check this and submit a bug if there are<br>=A0*=A0=A0 problems =
for your device&quot;<br>



<br>So I am starting to be afraid that there might be a bug and that the in=
formation for my device is not accurate (even though the issue reported is =
not about my card).<br><br>Furthermore, I tried using the cmd_bits program =
to use the DIO channels.<br>

<br>First, here is the content of my 00-analogy_ni_pcimio file :<br>jb@domain.hid=
0:/proc/analogy$ cat 00-analogy_ni_pcimio <br>--=A0 Subdevices --<br><br>| =
idx | type<br>|=A0 00 | Analog input subdevice<br>|=A0 01 | Analog output s=
ubdevice<br>

|=A0 02 | Digital input/output subdevice<br>|=A0 03 | Unused subdevice<br>|=
=A0 04 | Unused subdevice<br>|=A0 05 | Calibration subdevice<br>|=A0 06 | M=
emory subdevice<br>|=A0 07 | Digital input/output subdevice<br>|=A0 08 | Un=
used subdevice<br>

|=A0 09 | Serial subdevice<br>|=A0 10 | Unused subdevice<br>|=A0 11 | Count=
er subdevice<br>|=A0 12 | Counter subdevice<br>|=A0 13 | Counter subdevice<=
br><br>jb@domain.hid$ sudo ./cmd_bits -d analogy0 -s 1<br>cmd_b=
its: selected subdevice is not digital<br>

<br># Which seems normal : idx 1 is for analog Output. But if I use &quot;-=
s 2&quot; or &quot;-s 7&quot; I get : <br><br>jb@domain.hid$ su=
do ./cmd_bits -d analogy0 -s 7<br>cmd_bits: a4l_snd_command failed (err=3D-=
5)<br>

<br>thant I used the errno.sh tool :<br>./errno.sh 5<br>#define=A0=A0=A0 EI=
O=A0=A0=A0 =A0=A0=A0 =A05=A0=A0=A0 /* I/O error */<br><br>and in the Xenoma=
i API documentation I read about a4l_snd_command :<br>-EIO is returned if t=
he selected subdevice cannot handle command<br>

<br>So I am not sure what to make up of all this. I feel like there is a pr=
oblem with the implementation<br>of analogy_pcmio for my NI-DAQ card. If th=
is is the case, I would be happy (to at least try) to fix it myself (with a=
 little help to get myself started maybe ^^), or do you think the problem i=
s elsewhere ?<br>

<br>Thank you very much for reading this :)<br><br>Sincerely,<br><font colo=
r=3D"#888888"><br>Hadrien</font><div><div></div><div class=3D"h5"><br><br><=
div class=3D"gmail_quote">

On Wed, Nov 23, 2011 at 10:53 AM, Hadrien Caron <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:hadrien.caron@domain.hid" target=3D"_blank">hadrien.caron@domain.hid=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">



I use Xenomai 2.5.6 with drivers nipcimio. Should I try it with the latest =
2.6 version ?<br><br>Thanks again for all your ideas !<br><font color=3D"#8=
88888"><br>Hadrien</font><div><div></div><div><br><br><div class=3D"gmail_q=
uote">



On Wed, Nov 23, 2011 at 9:44 AM, Gilles Chanteperdrix <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank">gill=
es.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div>On 11/22/2011 11:33 =
PM, Alexis Berlemont wrote:<br>
</div><div>&gt; On Tue, Nov 22, 2011 at 2:43 PM, Hadrien Caron &lt;<a href=
=3D"mailto:hadrien.caron@domain.hid" target=3D"_blank">hadrien.caron@domain.hid=
om</a>&gt; wrote:<br>
&gt;&gt; Alexis : yes I am using the Analogy drivers . . . Would that mean =
that<br>
&gt;&gt; analog output is implemented but not digital output for National I=
nstrument<br>
&gt;&gt; acquisition cards ? Has someone tried this already ? Seems strange=
 that<br>
&gt;&gt; analog output would be implemented but not digital.<br>
&gt;&gt;<br>
&gt;&gt; Anders : Ok ! I will look into rebulding my xenomai installation t=
hen !<br>
&gt;<br>
&gt; According to the thread:<br>
&gt; [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails with ENOS=
YS)<br>
&gt; <a href=3D"https://mail.gna.org/public/xenomai-core/2011-07/msg00010.h=
tml" target=3D"_blank">https://mail.gna.org/public/xenomai-core/2011-07/msg=
00010.html</a><br>
&gt; The problem related by Anders Blomdell is supposed to be fixed with<br=
>
&gt; the 2.6 release, isn&#39;t it?<br>
&gt;<br>
&gt; Could you tell us which version of Xenomai and which driver<br>
&gt; (ni_pcimio, ...) you are using?<br>
<br>
</div>Hi,<br>
<br>
the problem is not fixed, we can not compile xenomai without frame pointers=
.<br>
<font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>
</div></div></blockquote></div><br>
</div></div></blockquote></div><br>

--f46d043bdfb8c7f10a04b434e4f0--

