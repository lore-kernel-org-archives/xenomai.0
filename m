Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with
	NULL-name	leads to Kernel oops in /proc/xenomai/irq
In-Reply-To: <45A6A2F7.7040003@domain.hid>
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
	<45A4F18A.4040209@domain.hid>
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
	<45A4F9CC.6070807@domain.hid>
	<b647ffbd0701100655wd47af96y244c74d5227d6e85@domain.hid>
	<45A502A9.3060800@domain.hid>
	<b647ffbd0701100758i1ea15b12qab5ac7c33acae0be@domain.hid>
	<b647ffbd0701100759p5432558dv386b5b1a580e3921@domain.hid>
	<1168543157.25399.156.camel@domain.hid>  <45A6A2F7.7040003@domain.hid>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 22:01:30 +0100
Message-Id: <1168549290.25399.178.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2007-01-11 at 21:49 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2007-01-10 at 16:59 +0100, Dmitry Adamushko wrote:
> >>> Attached. Keep in mind that although it's a simple patch I,
> >>> personally, haven't tested it (even compilation-wise).
> >>> Anyone who would like to give it a try (Mathias?) is wellcome.
> >> Now finally attached.
> >>
> > 
> > Merged, thanks.
> 
> Please also apply my patch to cover RTDM drivers passing NULL (though
> this is discouraged -- now).
> 

Ok, merged. Thanks.

> Thanks,
> Jan
> 
-- 
Philippe.



