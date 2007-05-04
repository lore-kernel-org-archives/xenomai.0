Message-ID: <463B33BC.5020408@domain.hid>
Date: Fri, 04 May 2007 15:23:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705040615n2272cf83oeec8db0a7dda910c@domain.hid>
In-Reply-To: <7289437c0705040615n2272cf83oeec8db0a7dda910c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem to compile for ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
> Hello,
>  
> I have some problems to compile my code Posix for ARM. I have installed
> xenomai in /usr/xenomai_arm-2.3.1 for ARM.
>  
> Here is my compilation :
> (...)
> -L/usr/xenomai_arm-2.3.1/lib -lpthread_rt -lpthread -lrt  
> essai_mutex_rt.o   -o essai_mutex_rt

The order of arguments on the linker command line is important, this
should be:

essai_mutex_rt.o -lpthread_rt -lpthread -lrt

-- 
                                                 Gilles Chanteperdrix

