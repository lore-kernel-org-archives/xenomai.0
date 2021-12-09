Subject: Re: y2038: select() seems not affected
References: <383d5a49352f3417f6a8903714e5b5bc1d096a3f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3b8a08fe-9574-8f62-a129-544b4dd43559@siemens.com>
Date: Thu, 9 Dec 2021 10:25:37 +0100
MIME-Version: 1.0
In-Reply-To: <383d5a49352f3417f6a8903714e5b5bc1d096a3f.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "chensong_2000@189.cn" <chensong_2000@189.cn>

On 07.12.21 17:00, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> Hi,
> 
> when we initially collected all y2038 affected syscalls we putted the
> select() call on the list [1], which is one of the 4 calls that are
> still missing.
> 
> Before starting implementing the missing y2038 safe syscall today, I
> noticed that this call is not affected at all. There is a struct
> timeval inside the signature, yes, but it holds a relative time (= time
> interval) and not an absolute time (=point in time).
> 
> The signature:
> COBALT_SYSCALL(select, primary,
>                (int nfds,
>                 fd_set __user *u_rfds,
>                 fd_set __user *u_wfds,
>                 fd_set __user *u_xfds,
>                 struct __kernel_old_timeval __user *u_tv));
> 
> Are I'm missing something?
> 
> Linux has no select64 as well, so I assume I'm right ;-)
> 
> If no complains come up I would remove select() from the list of
> affected syscalls. That would lower the number of non-implemented y2038
> calls to 3.
> 

Sounds consistent to me.

Jan

> Best regards,
> Florian
> 
> 
> [1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/wikis/y2038/Y2038_Affected_Syscalls
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

