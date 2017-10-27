References: <49f18a6100f34834bf350f4395cd6944@ocgepvsw3304.ocr.priv>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ef069032-2f58-93a8-98b5-dec4f592094f@xenomai.org>
Date: Fri, 27 Oct 2017 19:51:14 +0200
MIME-Version: 1.0
In-Reply-To: <49f18a6100f34834bf350f4395cd6944@ocgepvsw3304.ocr.priv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.5 - sigwaitinfo si_overrun wrong value
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/26/2017 03:56 PM, Fazio Maurizio wrote:

[snip]

>          sprintf (buffer, "%ld s %ld ns - %ld s %ld ns overrun = %d\n",tp.tv_sec,
>                  tp.tv_nsec, diffTime.tv_sec,diffTime.tv_nsec, siginfo.si_overrun);
> 
>          write (STDOUT_FILENO, buffer, strlen (buffer));

Bad, will switch the caller to secondary mode.

>          if (counter % 3 == 0)
>          {
>                usleep(1500);

Ditto with 3.0.5.

>          }
>          counter++;
>      }
> }
> 

Excerpt from the timer_getoverrun() manpage:

"The timer overrun count is  the  number of additional timer expirations
that occurred between the time when the signal was generated and when it
was delivered or accepted."

So you need to delay for at least two intervals before receiving a
non-zero overrun count.

You may want to check this building your code over the plain glibc.
usleep(1500) gives no overruns, usleep(2000) gives 1, usleep(3000) gives
2 and so on.

-- 
Philippe.

