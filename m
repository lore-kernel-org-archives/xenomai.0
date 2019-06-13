Subject: Re: cobalts printf thread affects signalfd operation
References: <VI1PR05MB59173D4829F3F8EBA9143AE7F6EF0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a11ca71-5b9c-0aba-8746-ec5097cedae4@siemens.com>
Date: Thu, 13 Jun 2019 21:23:58 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59173D4829F3F8EBA9143AE7F6EF0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 13.06.19 19:08, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I ran into a problem with the automatically spawned printf thread.
> 
> Short summary:
> The kernel delivers signals by picking a thread that can accept a signal and does not mask the specific signal,
> only if none is available then the signal will be queued for asynchronous delivery.
> signalfd is asynchronous delivery, thus if one thread accepts signals then signalfd won't work as expected,
> enter cobals printf thread.

Good point...

> 
> Solutions would be:
> 
> - Mask all signals for this thread (is there any downside?)

I don't see any, we do not use signals for the operation of the printer.

> - Mask all signals on the main thread before calling xenomai_init. This is ugly, as that removes most methods of interacting with a hung startup.
> - Somehow mask the thread for signals later (only ugly solutions?).
> 
> The first option would be a rather small patch:
> 
> @@ -642,7 +642,11 @@ static void spawn_printer_thread(void)
>   pthread_attr_t thattr;
> 
>   pthread_attr_init(&thattr);
> +sigset_t sset, oset;
> +sigfillset(&sset)
> +sigprocmask(SIG_BLOCK, &sset, &oset);
>   pthread_create(&printer_thread, &thattr, printer_loop, NULL);
> +sigprocmask(SIG_SETMASK, &oset, NULL);
>   }
> 

Looks reasonable, please send a patch (then it can still make into next stable).

Jan

-- 
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

