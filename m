MIME-Version: 1.0
In-Reply-To: <CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
	<4ECA2FF8.7040406@domain.hid>
	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>
	<4ECA5E12.5040907@domain.hid>
	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>
	<4ECB967C.70509@domain.hid>
	<CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>
Date: Tue, 22 Nov 2011 23:33:14 +0100
Message-ID: <CAMesUR6Jx7WuZNsY6WmomD-ExoJ9hhKovKiekrr71Kbrk7Jb_A@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Hadrien Caron <hadrien.caron@domain.hid>
Cc: xenomai@xenomai.org

On Tue, Nov 22, 2011 at 2:43 PM, Hadrien Caron <hadrien.caron@domain.hid> wr=
ote:
> Alexis : yes I am using the Analogy drivers . . . Would that mean that
> analog output is implemented but not digital output for National Instrume=
nt
> acquisition cards ? Has someone tried this already ? Seems strange that
> analog output would be implemented but not digital.
>
> Anders : Ok ! I will look into rebulding my xenomai installation then !

According to the thread:
[Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails with ENOSYS)
https://mail.gna.org/public/xenomai-core/2011-07/msg00010.html
The problem related by Anders Blomdell is supposed to be fixed with
the 2.6 release, isn't it?

Could you tell us which version of Xenomai and which driver
(ni_pcimio, ...) you are using?

Regards,

Alexis.
>
> Many thanks to both of you for your ideas !
>
> Hadrien
>
> On Tue, Nov 22, 2011 at 1:33 PM, Anders Blomdell
> <anders.blomdell@domain.hid> wrote:
>>
>> On 11/22/2011 01:06 PM, Alexis Berlemont wrote:
>>>
>>> Hi,
>>>
>>> On Mon, Nov 21, 2011 at 3:20 PM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> =A0wrote:
>>>>
>>>> On 11/21/2011 12:10 PM, Hadrien Caron wrote:
>>>>>
>>>>> Thanks very much Wolfang !
>>>>> Cool script, I didn't know about it :)
>>>>> I'll try to correct my code with that information !
>>>>>
>>>>> Thanks again,
>>>>
>>>> ENOSYS usually means that you have not enabled the relevant support in
>>>> kernel configuration.
>>>>
>>>
>>> Which driver are you using? I think analogy returns ENOSYS if the
>>> driver does not implement the related instruction.
>>
>> It can also happen with xenomai compiled with gcc-4.6.x, but without
>> -fno-omit-frame-pointer :-(
>>
>> Regards
>>
>> Anders
>
>

