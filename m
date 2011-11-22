Message-ID: <4ECB967C.70509@domain.hid>
Date: Tue, 22 Nov 2011 13:33:00 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
	<4ECA2FF8.7040406@domain.hid>
	<CA+eKTkZuNknobLhsgqU8jjkKboL3jNLhMPoG82fkjD6sZfyXgA@mail.gmail.com>
	<4ECA5E12.5040907@domain.hid>
	<CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>
In-Reply-To: <CAMesUR7edxnPvpLu0kajLWGtVBwK65m27kssOjh=JViVhPeXJQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 11/22/2011 01:06 PM, Alexis Berlemont wrote:
> Hi,
>
> On Mon, Nov 21, 2011 at 3:20 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org>  wrote:
>> On 11/21/2011 12:10 PM, Hadrien Caron wrote:
>>> Thanks very much Wolfang !
>>> Cool script, I didn't know about it :)
>>> I'll try to correct my code with that information !
>>>
>>> Thanks again,
>>
>> ENOSYS usually means that you have not enabled the relevant support in
>> kernel configuration.
>>
>
> Which driver are you using? I think analogy returns ENOSYS if the
> driver does not implement the related instruction.
It can also happen with xenomai compiled with gcc-4.6.x, but without 
-fno-omit-frame-pointer :-(

Regards

Anders

