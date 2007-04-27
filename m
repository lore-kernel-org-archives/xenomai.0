Message-ID: <b647ffbd0704270439h2a6e7ba2hee14be3a7a84e449@domain.hid>
Date: Fri, 27 Apr 2007 13:39:39 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <4630F274.5090605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4630F274.5090605@domain.hid>
Subject: Re: [Adeos-main] [PATCH 5/7] Introduce ipipe_base.h (i386/x86_64)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On 26/04/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> These patches introduce minimalistic ipipe_base.h to be included by
> every header out there in the kernel without any dependencies. That is
> exploited here to move all *stall_root() related prototypes out off
> irqflags.h, to following patches need ipipe_base.h as well.

So this file is supposed to extend with another generic stuff, isn't
it? At the moment it's completely about the root domain, so one would
think of ipipe_root.h as a more appropriate name.

And this "minimalistic" and "without any dependencies" is due to the
heaviness of linux/pipe.h?


-- 
Best regards,
Dmitry Adamushko

