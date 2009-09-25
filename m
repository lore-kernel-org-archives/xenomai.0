MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <1253888606.2819.6.camel@domain.hid>
References: <634c78ce0909250117p2f7dfbdfx74fe2d22b84ab1ee@domain.hid> 
	<634c78ce0909250305t157d2d5br2601da181fbe998@domain.hid> 
	<1253888606.2819.6.camel@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Fri, 25 Sep 2009 22:35:10 +0200
Message-ID: <634c78ce0909251335s1be168calfe61c5784bfc8c0a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] compilation failure of hal_common.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Sep 25, 2009 at 16:23, Philippe Gerum <rpm@xenomai.org> wrote:
> On Fri, 2009-09-25 at 12:05 +0200, Peter Soetens wrote:
>> I'm trying to compile vanilla Linux 2.6.28.9 prepared with Xenomai
>> 2.4.9.1 for x86-64, SMP.
>>
>> I get this error in hal_common.c:
...
>
> Right. There seems to be a slight adjustment to do in my code (also
> reads "I badly screwed up, damn it").
>
> diff --git a/ksrc/arch/x86/hal-common.c b/ksrc/arch/x86/hal-common.c
> index 1497fee..7286987 100644
> --- a/ksrc/arch/x86/hal-common.c
> +++ b/ksrc/arch/x86/hal-common.c
> @@ -107,7 +107,7 @@ static inline void send_IPI_allbutself(int vector)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| vector);
> =A0 =A0 =A0 =A0rthal_local_irq_restore_hw(flags);
> =A0}
> -#elif defined(__i386__) && LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
> +#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
> =A0#include <mach_ipi.h>
> =A0#else
> =A0#define send_IPI_allbutself(vector) =A0 =A0apic->send_IPI_allbutself(v=
ector)
>
> Please let me know if that fixes the issue on your side as well.

Will try but won't be able to tell till after XUM :)

>
> PS: btw, I fail compiling 2.6.28.9 with KPROBES on, but this does not
> look like a Xenomai issue this time.

Same here, drew same conclusion.

Peter

