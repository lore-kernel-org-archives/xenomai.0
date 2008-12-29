Message-ID: <4958F2EE.8080804@domain.hid>
Date: Mon, 29 Dec 2008 15:55:26 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4958E439.9040503@domain.hid>
In-Reply-To: <4958E439.9040503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] Fix include for kernel/panic.c
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

Jan Kiszka wrote:
> +++ b/kernel/panic.c
> @@ -21,6 +21,7 @@
>  #include <linux/debug_locks.h>
>  #include <linux/random.h>
>  #include <linux/kallsyms.h>
> +#include <linux/ipipe_trace.h>

That is not enough, when compiling a kernel without I-pipe enabled, the
compiler complains about ipipe_processor_id.

-- 
                                                 Gilles.

