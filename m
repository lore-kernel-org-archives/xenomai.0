Message-ID: <491A09B0.2080703@domain.hid>
Date: Tue, 11 Nov 2008 23:39:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>	
	<490ECE11.208@domain.hid>	
	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>	
	<490F2F23.2080307@domain.hid>	
	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>	
	<49100825.9000502@domain.hid> <4915C4D3.8030304@domain.hid>	
	<67b6b3430811101607k75eaa084ga387c453096d2710@domain.hid>	
	<1c74c6152ff1b52eaa3dd84f4b912b29.squirrel@domain.hid>	
	<51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>
	<67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>
In-Reply-To: <67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>
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
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Mark Saiia wrote:
> I applied the patch to Xenomai-2.4.5 with kernel 2.6.26.3 and observed the
> erroneous behavior.  I did the same with linux-2.6.27.5 and Xenomai r4372
> and noticed the same behavior.  Please let me know if I can run additional
> tests, if you need any more information, or how to potentially fix this
> issue.

So, fninit is not the culprit. What could happen is that we do not
really get an FPU fault upon first access to the FPU. To know this, we
should test the state of the ts bit before the first use of FPU in each
thread.

I will send a patch to do this.

-- 
					    Gilles.

