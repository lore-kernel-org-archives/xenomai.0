Subject: Re: Checkpatch errors
References: <CAODwZ7vER3+Jp1+-U8dfO2_LeZj=nS+PZPq0vDou5M2zDi6AVw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3d69016b-1167-acef-6232-21f66de133a8@siemens.com>
Date: Fri, 5 Apr 2019 16:24:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAODwZ7vER3+Jp1+-U8dfO2_LeZj=nS+PZPq0vDou5M2zDi6AVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Roman Stratiienko <roman.stratiienko@globallogic.com>, xenomai@xenomai.org

On 05.04.19 16:05, Roman Stratiienko wrote:
> Hello Jan,
> 
> Let me share some of checkpatch findings after recent update:
> 
> --------------------------------------------------------------------
> Commit 67549038b677 ("rtnet: e1000e: Account for timer API changes")
> --------------------------------------------------------------------
> WARNING: LINUX_VERSION_CODE should be avoided, code should be for the version to
> which it is merged
> #21: FILE: kernel/drivers/net/drivers/e1000e/netdev.c:2882:
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
> ERROR: space required after that ',' (ctx:VxV)
> #21: FILE: kernel/drivers/net/drivers/e1000e/netdev.c:2882:
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)

Thanks, but these are false positives. Upstream (in the few cases it has) does
the same.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

