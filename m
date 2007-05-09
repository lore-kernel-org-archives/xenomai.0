Message-ID: <4641951C.4020008@domain.hid>
Date: Wed, 09 May 2007 11:32:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0705090155ma97b0et930b53336849a56f@domain.hid>
In-Reply-To: <7289437c0705090155ma97b0et930b53336849a56f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
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
> I've build a xenomai test application with Posix skin wich run on an
> ARM9. The application works well one time, and when I want to launch
> again my application, I have this error message :
>  
> 
> Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
> unavailable
> 
>  
> 
> I think something was bad cancelled but I don't see.

Resource temporarily unavailable is EAGAIN, it means that there is not
enough memory to create the real-time thread. Could you send us the
contents of /proc/xenomai/heap before and after running your application  ?

-- 
                                                 Gilles Chanteperdrix

