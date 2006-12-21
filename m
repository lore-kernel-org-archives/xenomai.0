Message-ID: <458A9E27.3000509@domain.hid>
Date: Thu, 21 Dec 2006 15:45:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
References: <458A4DE0.5030005@domain.hid>		<7145056.1166514841031.JavaMail.ngmail@domain.hid>		<4970132.1166516081275.JavaMail.ngmail@domain.hid>		<2579704.1166520394117.JavaMail.ngmail@domain.hid>		<4383100.1166529856857.JavaMail.ngmail@domain.hid>		<13529671.1166621136153.JavaMail.ngmail@domain.hid>		<15069404.1166690889417.JavaMail.ngmail@domain.hid>		<2890274.1166696466862.JavaMail.ngmail@domain.hid>		<458A67B6.8000207@domain.hid>
	<458A7185.8070803@domain.hid>	<b647ffbd0612210450r4e515046v4eb69da0f6c6c0b3@domain.hid>
	<458A8B8A.8060401@domain.hid>
In-Reply-To: <458A8B8A.8060401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Gilles Chanteperdrix wrote:
> Dmitry Adamushko wrote:
>>p.s. vfork() is a different beast. Here a child is supposed to call
>>exec*() rigth after fork() so it's allowed to "borrow" parent's
>>address space (vm_struct -> all vm_area(s)) and the parent is blocked
>>in the mean time. As a result, no need for copy-on-write.
> 
> 
> I think to remember that glibc vfork is just fork.

At least, linuxthread's vfork is the same as linuxthread's fork.

-- 
                                                 Gilles Chanteperdrix

