Message-ID: <4ECCB27F.3040903@domain.hid>
Date: Wed, 23 Nov 2011 09:44:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>	<4ECA2FF8.7040406@domain.hid>	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>	<4ECA5E12.5040907@domain.hid>	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>	<4ECB967C.70509@domain.hid>	<CA+eKTkbcBYnoRnBZrrBQ-Br2h2HPrVdyVLs2V3F4WOvcvhpDxA@mail.gmail.com>
	<CAMesUR6Jx7WuZNsY6WmomD-ExoJ9hhKovKiekrr71Kbrk7Jb_A@mail.gmail.com>
In-Reply-To: <CAMesUR6Jx7WuZNsY6WmomD-ExoJ9hhKovKiekrr71Kbrk7Jb_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org, Hadrien Caron <hadrien.caron@domain.hid>

On 11/22/2011 11:33 PM, Alexis Berlemont wrote:
> On Tue, Nov 22, 2011 at 2:43 PM, Hadrien Caron <hadrien.caron@domain.hid> wrote:
>> Alexis : yes I am using the Analogy drivers . . . Would that mean that
>> analog output is implemented but not digital output for National Instrument
>> acquisition cards ? Has someone tried this already ? Seems strange that
>> analog output would be implemented but not digital.
>>
>> Anders : Ok ! I will look into rebulding my xenomai installation then !
> 
> According to the thread:
> [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails with ENOSYS)
> https://mail.gna.org/public/xenomai-core/2011-07/msg00010.html
> The problem related by Anders Blomdell is supposed to be fixed with
> the 2.6 release, isn't it?
> 
> Could you tell us which version of Xenomai and which driver
> (ni_pcimio, ...) you are using?

Hi,

the problem is not fixed, we can not compile xenomai without frame pointers.

-- 
                                                                Gilles.

