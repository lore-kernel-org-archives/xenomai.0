Message-ID: <491D39E8.3090105@domain.hid>
Date: Fri, 14 Nov 2008 09:42:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>	
	<490F2F23.2080307@domain.hid>	
	<67b6b3430811031237v4cfba0c9sf63e40a697f3da58@domain.hid>	
	<49100825.9000502@domain.hid> <4915C4D3.8030304@domain.hid>	
	<67b6b3430811101607k75eaa084ga387c453096d2710@domain.hid>	
	<1c74c6152ff1b52eaa3dd84f4b912b29.squirrel@domain.hid>	
	<51CAD0CE1504444DBE77CBBE51A0135D53344A@slcmail.slc.mew.int>	
	<67b6b3430811111432o1ca14e87w7ccab4ab95dd591e@domain.hid>	
	<491C0B50.6030507@domain.hid>
	<67b6b3430811131959r6bc22545wd4e3df613c15fc7b@domain.hid>
In-Reply-To: <67b6b3430811131959r6bc22545wd4e3df613c15fc7b@domain.hid>
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
> Gilles,
> 
> No noticeable difference using 2.4.5 w/ 2.6.26.3.  I was testing using the
> app we first noticed the behavior on.  I will run the simple test program
> tomorrow, but fully expect to see the erroneous behavior.  I also had the
> chance to test the patch on a GX1 board, and noticed the error as well. We
> have a version of the app, that I was testing today, running on 2.6.23.12 w/
> Xenomai svn of around February 2008 (I don't have the revision number in
> front of me at the moment) that works properly.

Could you test 2.6.23 with Xenomai 2.4.5? This way we would know if we
are looking for a problem in the I-pipe patch or in Xenomai.

-- 
					    Gilles.

