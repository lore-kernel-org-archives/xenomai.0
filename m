Message-ID: <455481B8.80804@domain.hid>
Date: Fri, 10 Nov 2006 14:42:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Kernel limits
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E621@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154E621@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Hi,
>  
> I am still struggling with problems under Xenomai and POSIX skin. You 
> remember maybe I was posting a Kernel Oops some days ago.
> I realized that a basic test (not with our large app. but with a little 
> test program) of clock_nanosleep() shows, that this function - if tested 
> alone - works as expected. Strangely in our application the behaviour of 
> clock_nanosleep() changes and then suddenly (before crashing) it returns 
> only after 1/4 of the supposed time. Bear in mind: if I compile the app. 
> against POSIX NPTL glibc, everything works as expected.

What is the return value of clock_nanosleep when it returns in advance ?

-- 
                                                  Gilles Chanteperdrix

