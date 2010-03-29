Message-ID: <4BB0D9D9.1050904@domain.hid>
Date: Mon, 29 Mar 2010 18:48:25 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4BACBFDC.4080909@domain.hid> <20100328233556.GC2542@domain.hid>
In-Reply-To: <20100328233556.GC2542@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Bug in a4l_get_chan
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

Alexis Berlemont wrote:
> Daniele Nicolodi wrote:
>> Hello Alexis,
>>
>> I found that a4l_get_chan() in buffer.c does not work for subdevices
>> that use a global channels description struct (mode =
>> A4L_CHAN_GLOBAL_CHANDESC in the a4l_chdesc_t structure).

> However, with your accurate description, I think this patch should
> solve the problem:

Thanks Alexis. Your patch has the same effect as the one I cracked up
myself after some head scratching. It is more readable than mine,
however my solution avoids the iteration and the multiple checks for
A4L_CHAN_GLOBAL_CHANDESC and can be a little more efficient, but i think
compiler optimizations should make it a non noticeable difference.

Cheers,

PS: Looks like free.fr does not like my university SMTP server. I have
difficulties in sending mails to your account there.

-- 
Daniele

