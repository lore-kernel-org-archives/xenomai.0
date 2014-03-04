Message-ID: <5315DABE.4090005@xenomai.org>
Date: Tue, 04 Mar 2014 14:53:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1393935764.2258.YahooMailNeo@web163903.mail.gq1.yahoo.com>
 <CAEbDrgnFcZb3iO0mU_-7Up9OfjtcryDwU_LA3xNpOHj11K661A@mail.gmail.com>
 <1393938968.37774.YahooMailNeo@web163902.mail.gq1.yahoo.com>
In-Reply-To: <1393938968.37774.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] compiling kernel after xenomai-patch ends in error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>, Gregory Dymarek <gregd72002@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/04/2014 02:16 PM, Huub Van Niekerk wrote:
>
>
>> On Tuesday, March 4, 2014 2:09 PM, Gregory Dymarek <gregd72002@gmail.com> wrote:
>
>> had the same issue before. The solution is to disable remote kernel
>> debugging (kernel hacking menu)
>
> You mean disabling Low-level kernel debugging uart ?
>

Disabling CONFIG_KGDB would do. Or adding the following bits:

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 7cc2adf..31818db 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -28,6 +28,7 @@
  #include <linux/bitops.h>
  #include <linux/tick.h>
  #include <linux/interrupt.h>
+#include <linux/uaccess.h>
  #ifdef CONFIG_PROC_FS
  #include <linux/proc_fs.h>
  #include <linux/seq_file.h>

>
> On 4 March 2014 12:22, Huub Van Niekerk <huubvanniekerk@yahoo.com> wrote:
>
>> Hi,
>>
>> I just patched vanilla kernel 3.10.18 with ipipe-core-3.10.18-arm-1 and
>> get these errors:
>>
>> kernel/ipipe/core.c: In function 'ipipe_probe_kernel_read':
>> kernel/ipipe/core.c:1742:2: error: implicit declaration of function
>> 'get_fs' [-Werror=implicit-function-declaration]
>> kernel/ipipe/core.c:1744:2: error: implicit declaration of function
>> 'set_fs' [-Werror=implicit-function-declaration]
>> kernel/ipipe/core.c:1744:9: error: 'KERNEL_DS' undeclared (first use in
>> this function)
>> kernel/ipipe/core.c:1744:9: note: each undeclared identifier is reported
>> only once for each function it appears in
>> kernel/ipipe/core.c:1747:2: error: implicit declaration of function
>> '__copy_from_user_inatomic' [-Werror=implicit-function-declaration]
>> kernel/ipipe/core.c: In function 'ipipe_probe_kernel_write':
>> kernel/ipipe/core.c:1761:9: error: 'KERNEL_DS' undeclared (first use in
>> this function)
>> kernel/ipipe/core.c:1764:2: error: implicit declaration of function
>> '__copy_to_user_inatomic' [-Werror=implicit-function-declaration]
>>
>> With previous kernel 3.2 I got warning and errors before saving the
>> kernel, now I didn't. Looking on the net for these errors, I find some
>> postings, but none related to ipipe. Any ideas?
>>
>> Thanks.
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

