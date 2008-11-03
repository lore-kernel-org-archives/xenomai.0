Message-ID: <490F2F23.2080307@domain.hid>
Date: Mon, 03 Nov 2008 18:04:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533259@domain.hid>
	<490ECE11.208@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D53325A@slcmail.slc.mew.int>
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
> Hi Gilles. Thank you for getting back to me.
> 
> I do not see "fxsr" in /proc/cpuinfo. I checked around with Google and
> it seems this chip doesn't have FXSR support. Do I need to do something
> else in this case? We are currently using a new board. I will check
> /proc/cpuinfo on the old board and see if it says FXSR. We never had
> this problem with the old board.

No, the fact that you have no support for FXSR is not a problem, it was
just a question to try and reproduce the issue you face.

-- 
                                                 Gilles.

