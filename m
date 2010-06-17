MIME-Version: 1.0
In-Reply-To: <4C19037D.6030301@domain.hid>
References: <4B992463.8050202@domain.hid>
	<4C19037D.6030301@domain.hid>
Date: Thu, 17 Jun 2010 08:13:06 +0200
Message-ID: <AANLkTimw3WcsILV9AZaHtfB7omLQI4es9i0j53S17vkP@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] Analogy a4l_fill_desc() bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Wed, Jun 16, 2010 at 7:01 PM, Daniele Nicolodi <daniele@domain.hid> wrote:
> On 11/03/10 18:12, Daniele Nicolodi wrote:
>> Hello.
>>
>> I found a bug in a4l_fill_desc(). If I call it on a descriptor obtained
>> for an unattached device, the memory allocated for the sbdata descriptor
>> field is corrupted in a bad way. When, after the failing a4l_fill_desc()
>> call, I free() it, glibc complains about an "invalid next size" for the
>> memory chunk.
>>
>> I'm on x86 architecture using kernel 2.6.30.10 with xenomai 2.5.1.
>
> This bug is still biting me...

A few months ago, I fixed a bug in a4l_fill_desc() and I forgot there
were two. So I closed the case in my TODO list.

Many thanks for reminding me.

>
> Cheers,
> --
> Daniele
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>

Alexis.

