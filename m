Message-ID: <4FCDC08E.9030101@xenomai.org>
Date: Tue, 05 Jun 2012 10:17:18 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
	<4FC637EB.90908@xenomai.org>
	<CAKKWdte3jE_kW8esz25=gYeYU_M1cmOmftgbfMs9RqyfBCr9Kw@mail.gmail.com>
	<4FCDB0FD.1080309@xenomai.org>
	<8236197CA3DA864F9EF20609D9887263B7F87D1A@rrxchngmbx01.mro.roland-man.biz>
In-Reply-To: <8236197CA3DA864F9EF20609D9887263B7F87D1A@rrxchngmbx01.mro.roland-man.biz>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland.com
Cc: Xenomai@xenomai.org

On 06/05/2012 10:06 AM, dietmar.schindler@manroland.com wrote:
> A Xenomai-patched 2.6.34 kernel (ppc GNU/Linux) crashes when issuing the command
>
> echo function>/sys/kernel/debug/tracing/current_tracer
>
> (sometimes displaying NIP in a function from "source/kernel/trace/ring_buffer.c", sometimes with no message).
>
> Are Xenomai and ftrace incompatible?
>

No, but some ftrace bits have to be made pipeline-aware. The generic 
ones should be, but some powerpc-specific fix ups might be missing. I'm 
not using/testing ftrace routinely when upgrading patches. Also, 2.6.34 
is fairly old.

> --
> Best Regards,
> Dietmar
> ________________________________________
> manroland web systems GmbH -- Managing Director: Uwe Lüders
> Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No. 26816 -- VAT: DE281389840
>
> Confidentiality note:
> This eMail and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you are not the intended recipient, you are hereby notified that any use or dissemination of this communication is strictly prohibited. If you have received this eMail in error, please notify us immediately via info@manroland-web.com, then delete this eMail.
>
> - Please consider your environmental responsibility before printing this eMail
> ________________________________________
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


-- 
Philippe.

