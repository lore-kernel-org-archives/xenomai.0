Message-ID: <4B9FC1F2.1070002@domain.hid>
Date: Tue, 16 Mar 2010 18:37:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100316150037.11405209mnid677k@domain.hid>
	<4B9FB4A8.6000903@domain.hid>
	<20100316183247.34995yxgivc3ilj4@domain.hid>
In-Reply-To: <20100316183247.34995yxgivc3ilj4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mini2440 on the kernel 2.6.30.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

Michel He wrote:
> Still not working after reactivation of Timer 3. Here's the codes :

Well, if timer 3 is used by another driver in the system, no wonder that
it does not work. You will not get it to work by just changing a few
things here and there. You have to actually understand what is needed
and fix the implementation (probably to use another timer). Fortunately,
you have the I-pipe porting guide to arm to understand what is needed.


-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

