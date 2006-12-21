Message-ID: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
Date: Thu, 21 Dec 2006 14:09:42 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <25528819.1166701882755.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
	<1166700491.4936.5.camel@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: Re: A fairly small rtnet/Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On 21/12/06, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> Hello Philippe,
>
> > The important issue to check is the above one. Please try calling
> > rt_task_delete(NULL), and in a second test, rt_task_suspend(NULL),
> > instead of letting the thread routine return. TIA,
> O.K, here are the results:
> I have placed rt_task_delete() at all possible positions in realtimetask().
> The system freezes when I place rt_task_delete() after the printf() statement.
> At all other positions (after system(), after rt_task_sleep()) the system does not freeze.
> I get the very same results when I use rt_task_suspend() instead of rt_task_delete().
>
> It means, that the printf() call causes the freeze.

just to be sure.

Could you try with other secondary domain calls (instead of printf() )
: write() (open/close as I suggested before) or even getpid() ?

(1) instead of the last code line (printf() after rt_task_sleep() ) ;

(2) put it after system(). Does it still prevent a PC from hanging?


-- 
Best regards,
Dmitry Adamushko

