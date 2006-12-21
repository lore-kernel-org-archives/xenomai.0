Subject: Re: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai
	application that freezes the
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <16382545.1166699974895.JavaMail.ngmail@domain.hid>
References: <b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
	<31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 12:28:11 +0100
Message-Id: <1166700491.4936.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Thu, 2006-12-21 at 12:19 +0100, M. Koehrer wrote:
> Hi Dmitry, 
> 
> thanks for your response.
> > 
> > 
> > Is it still true that when you place printf() right after the system()
> > call, it works?
> Yes, a printf() directly after the system() fixes the issue.
> 
> > 
> > What happens when you try different sleep intervals : 0, say 1000 ?
> > 
> > Just to be sure where we are stuck. Insert exit() (or rt_task_delete(NULL))
> > :

The important issue to check is the above one. Please try calling
rt_task_delete(NULL), and in a second test, rt_task_suspend(NULL),
instead of letting the thread routine return. TIA,

-- 
Philippe.



