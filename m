Subject: Re: access errno in Xeno 3.1
References: <CA+K1mPFj0B28UNzcM-uF1Z6BPHVXO5sdceuyHhQEijU=qEwNNw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ac42ca13-53da-c5e6-47aa-5ad796a6e38a@siemens.com>
Date: Thu, 11 Nov 2021 09:27:03 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPFj0B28UNzcM-uF1Z6BPHVXO5sdceuyHhQEijU=qEwNNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>

On 11.11.21 08:33, C Smith via Xenomai wrote:
> I can compile a rtdm kernel module OK with Xenomai 3.1 but I can't
> seem to get my module to see errno.
> 
> In several Xenomai example sources I see :
> #include <errno.h>
> but when I put that in my rtdm code I must also add to my Makefile:
> -I/usr/src/linux/. Is that the right include path?
> 
> Even once I do all that, when I compile I get:
> error: ‘errno’ undeclared (first use in this function)
>           rtdm_printk("warning, munmap returned errno: %d\n", errno);
> 

The kernel has no errno variable. That is a user space concept. In the
kernel, you usually get errors via the return code of the function you
invoked.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

