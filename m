Message-ID: <48EE2BF6.60300@domain.hid>
Date: Thu, 09 Oct 2008 18:06:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <15875130.1223557641586.JavaMail.ngmail@domain.hid>
In-Reply-To: <15875130.1223557641586.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Bug with Xenomai and xeno_heap: Eeek!
 page_mapcount(page) went negative!
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
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi everybody,
> 
> I am using the Xenomai version 2.4.5 with Linux version 2.6.26.5
> (adeos patch provided with Xenomai 2.4.5). Pentium D 3.2 GHz.
> 
> There seems to be a bug with the Xenomai mmap page handling that
> leads to a 
> Eeek! page_mapcount(page) went negative! (-1)
> Kernel error.

Ok. Could you send us more details, such as the full boot logs and your
kernel configuration ?

On your side, is it possible for you to do a bisection with Xenomai
versions ?

-- 
                                                 Gilles.

