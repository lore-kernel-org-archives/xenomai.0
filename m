Message-ID: <4A49C738.4090705@domain.hid>
Date: Tue, 30 Jun 2009 10:05:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E181189FBC01D@ILMA1.IL.NDS.COM>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E181189FBC01D@ILMA1.IL.NDS.COM>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_mutex_lock returns 1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> I'm using Xenomai version 2.4.

Anyway, in xenomai 2.2, mutexes were pshared by default, and there was
no way to do otherwise. After hearing critics from a well-known person
involved in the preempt_rt Linux kernel development, I implemented the
pshared attribute. So, to get mutexes the old way, you have to set the
pshared attribute. Note however, that when you use the pshared
attribute, mutexes are no longer automatically destroyed upon process
deletion.

And also note that if you simply get this problem because you call
pthread_mutex_init, then fork, then use the mutexes in the child
process, you can avoid the problem by calling pthread_mutex_init in the
child process. As explained here:

http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Mixing_fork_with_Xenomai_POSIX_skin_services.


> This e-mail is confidential, the property of NDS Ltd and intended for
> the addressee only. Any dissemination, copying or distribution of
> this message or any attachments by anyone other than the intended
> recipient is strictly prohibited.

Grrrmblmbl

-- 
                                          Gilles


