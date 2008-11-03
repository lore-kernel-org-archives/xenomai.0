Message-ID: <490ECE11.208@domain.hid>
Date: Mon, 03 Nov 2008 11:10:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu context switch issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I'm having a weird issue. Sometimes when I run the attached program I
> see one of the "shouldn't see this" printouts. However, it only fails if
> I also link in another userspace library that doesn't do anything. (No
> libraries are being called here.)

Some libraries do things when loaded, even if no function is called: if
a C++ library declares a global or static object with a non trivial
constructor, the constructor is run when the library is loaded. The same
goes for C functions declared with the "constructor" attribute.

> 
>  
> 
> I've had issues with a couple of other xenomai apps. I get a nan on a
> double operation sometimes right after the app first loads, and then
> it's ok after that. This error in the attached program always happens on
> the first call in the higher priority task (started second.)
> 
>  
> 
> Running 2.4.5 with 2.6.26.3 and also 2.6.25.9. AMD Geode LX800 board.

Could you try to run the "switchtest" program, and see if it has bugs
too ? Also, do you see the "fxsr" flag in /proc/cpuinfo ?

-- 
                                                 Gilles.

