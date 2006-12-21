Message-ID: <b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
Date: Thu, 21 Dec 2006 11:45:11 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
In-Reply-To: <2890274.1166696466862.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
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
> Hi Jan, hi everybody,
>
> I have stripped down my program that is crashing Xenomai even further.
> (I have attached the complete source code).
> No rtnet is required.
> Now I have the following real time task:
>
> static void realtimetask(void *arg)
> {
>     system("ls -l");
>     rt_task_sleep(1000000000ULL);
>     printf("rt_task_sleep done...\n");
> }


Is it still true that when you place printf() right after the system()
call, it works?

What happens when you try different sleep intervals : 0, say 1000 ?

Just to be sure where we are stuck. Insert exit() (or rt_task_delete(NULL)) :

(0) after system() --- if said above about printf() is not true;
(1) after rt_task_sleep();
(2) after printf("rt_task_sleep done...\n").

At which step does a hang start occuring?

>
> This leads to a complete freeze of the PC on a 2.6.19.1 kernel using the latest
> Xenomai (from SVN) and the included adeos-patch.

I have almost the same config (only 2.6.19) at home, although it's p3
750 so I'll try if it won't be solved by this everning (or we are sure
that only high-end machines are involved).


-- 
Best regards,
Dmitry Adamushko

