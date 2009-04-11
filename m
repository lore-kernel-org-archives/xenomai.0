Message-ID: <49E0FB28.8000104@domain.hid>
Date: Sat, 11 Apr 2009 22:18:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000001c9ba1a$02e1ac70$08a50550$@com>
In-Reply-To: <000001c9ba1a$02e1ac70$08a50550$@com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Section Mismatch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wcall@domain.hid
Cc: xenomai@xenomai.org

Wayne Call wrote:
> I get the following "Section mismatch" warnings when attempting to build the
> lm73_rtdm.c and lpl_twi_uart_rtdm.c drivers.  What causes a mismatch?

Yes, these are plain Linux debugging messages, completely unrelated to
Xenomai. they tell you that you access object from the init/exit
sections from the text section, which is bad, since the init/exit
sections may not be always available when functions from the text
section are running. Show us the full code, and probably someone will be
able to tell you what the problem is.

-- 
					    Gilles.

