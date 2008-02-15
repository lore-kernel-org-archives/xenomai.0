Message-ID: <2ff1a98a0802150040p45290422uacb7fc4b6954fa0a@domain.hid>
Date: Fri, 15 Feb 2008 09:40:32 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <7470.62.39.72.60.1203063044.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7470.62.39.72.60.1203063044.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Problem of thread creation with Xenomai Posix 2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 15, 2008 at 9:10 AM, Fabien MAHOT >  OK, we can see that
there is the same problem. T1 thread prempts Main
>  Thread during the pthread_create of T2 with Xenomai and not with Linux
>  standard. I would like to know why.
>
>  I don't that there is a difference beetween the posix Linux pthread_create
>  and the posix Xenomai pthread_create ?
>
>  If pthread_create suspends a short time its caller, why we don t have the
>  same behaviour in the two cases ?
>
>  In my opinion, there is a problem with Xenomai, no ?
>
>  I hope that you could help me. thank you

Sorry, I did not make myself clear: it is xenomai implementation of
pthread_create which suspends its caller. But as I said in my previous
answer this does not contradict the posix standard as far as I can
tell. This implementation needs to work around two different glibc
bugs, which explains how it is implemented.

-- 
 Gilles Chanteperdrix

