Message-ID: <492D2958.40006@domain.hid>
Date: Wed, 26 Nov 2008 11:47:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>		<51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>		<67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>		<491C0B50.6030507@domain.hid>		<67b6b3430811131959r6bc22545wd4e3df613c15fc7b@domain.hid>		<491D39E8.3090105@domain.hid>		<67b6b3430811170927t74f809edg1b0c6aaf1a9d2709@domain.hid>		<51CAD0CE1504444DBE77CBBE51A0135D533618@domain.hid>		<6d17f533257138813c350472d9527033.squirrel@domain.hid>		<51CAD0CE1504444DBE77CBBE51A0135D533634@domain.hid>	<67b6b3430811210903l75b9fb6aj31e30fd4af749094@domain.hid>
	<4926EAE5.8070604@domain.hid>
In-Reply-To: <4926EAE5.8070604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu context switch issue
Reply-To: gilles.chanteperdrix@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Mark Saiia wrote:
>> I finally had a chance to patch 2.6.23.12 w/ Xenomai-2.4.5.  Both the simple
>> test and larger apps worked incorrectly (i.e. had the same floating point
>> issues as described before).   What should the next step be?
> 
> The next step is for me to look at the differences between 2.4.5 and the
> version of Xenomai which works for you and try and imagine what could be
> the problem.

Ok. The version you are talking about (r3415) is rather old. Could you
try to do a bisection in Xenomai revisions to tell me which commit
causes the bug you observe ?

-- 
                                                 Gilles.

