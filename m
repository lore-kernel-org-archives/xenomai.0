Message-ID: <4564988D.1090508@domain.hid>
Date: Wed, 22 Nov 2006 19:35:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Memory leak debugging
References: <4562FAC2.7080207@domain.hid>
In-Reply-To: <4562FAC2.7080207@domain.hid>
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
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai@xenomai.org

Dirk Eibach wrote:
> Hi,
> 
> I have a xenomai application on my PPPC405 that is killed every 16 hours 
> because it spent all available memory. I have no idea where the memory 
> leak is, and it's a rather large application, so a simple code review is 
> quite difficult.
> 
> Is there some kind of "best practices" in Xenomai memory leak debugging? 
>   Any tools that could be useful?

Maybe you can try mtrace ? It is a bit spartan, but is said to work...

-- 
                                                 Gilles Chanteperdrix

