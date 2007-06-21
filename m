Message-ID: <b647ffbd0706210252o1074fa6aof00e82b5ba5a2509@domain.hid>
Date: Thu, 21 Jun 2007 11:52:29 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <467A42F6.8080706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46782305.4080501@domain.hid>
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>
	<4679A302.2060403@domain.hid>
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>
	<467A42F6.8080706@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On 21/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> [ ... ]
>
> Unfortunately, that whole thing make me meditate about the whole issue
> again. And now I wonder why we make such a fuss about locking for shared
> IRQs (where it should be correct with any of the new patches) while we
> do not care about the non-shared, standard scenario.

surprise-surprise.. sure, one way or another it must be fixed. heh..
too many bugs (and I don't even want to say who's responsible) :-/

> Sigh, the never ending IRQ story...

should be reviewed.


>
> Jan
>

-- 
Best regards,
Dmitry Adamushko

