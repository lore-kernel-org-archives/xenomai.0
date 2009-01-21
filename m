Message-ID: <49777C1F.4040805@domain.hid>
Date: Wed, 21 Jan 2009 20:48:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
	<4976EABD.3060505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534053@domain.hid>
	<497751E3.3020301@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53405D@slcmail.slc.mew.int>
	<49775759.2090505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534064@domain.hid>
	<49776313.2090403@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53407D@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D53407D@slcmail.slc.mew.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu issue
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
> Gilles,
> 
> Just to clarify, that is all the information I have. I see a single call
> to init_fpu() in i387.c, a single call to xnarch_save_fpu(), and a
> single call to xnarch_restore_fpu().
> 
> It almost seems like the second thread doesn't know the FPU was used. I
> should see at least two inits, but seeing one context switch may make
> sense since I now break from my loops in both routines. Plus, with the
> const doubles in func2(), the comparison is optimized out when I look at
> the disassembled output.

Yes, the strcmp trick sucks. You should trace the switch when
current->comm is either "double_test" or "gatekeeper/0".

-- 
					    Gilles.

