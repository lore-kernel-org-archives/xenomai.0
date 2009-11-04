Message-ID: <4AF1685C.3090709@domain.hid>
Date: Wed, 04 Nov 2009 12:41:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AF0B4B4.3020609@domain.hid>
In-Reply-To: <4AF0B4B4.3020609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] rtdm: Add padding to rtser_config
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, Paolo Bernini <paolo.bernini@domain.hid>

Jan Kiszka wrote:
> The following changes since commit 6b1a185b460765c933b17932d77be6967d2e42dc:
>   Philippe Gerum (1):
>         nucleus: fix locking in shared heap deletion
> 
> are available in the git repository at:
> 
>   git://git.xenomai.org/xenomai-jki.git for-upstream
> 
> Jan Kiszka (1):
>       rtdm: Add padding to rtser_config
> 
>  include/rtdm/rtserial.h |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> ---
> 
> rtdm: Add padding to rtser_config
> 
> The current layout of rtser_config is unfortunate as it may result in
> different layout depending on the compiler alignment setting. Namely,
> rx_timeout may be aligned on 8-byte boundaries in user land while it may
> not be aligned in the kernel, or vice versa.
> 
> Avoid this ambiguity by adding a reserved padding field. Bump profile
> revision number due to ABI breakage.

Sorry, forgot to state explicitly: This is obviously no material for 2.4
as it breaks the ABI also for those users that didn't suffer from it so
far (mostly x86). So please revert the corresponding commit.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

