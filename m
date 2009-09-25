Message-ID: <4ABD2060.1010102@domain.hid>
Date: Fri, 25 Sep 2009 21:56:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0909251227y598abd0fmb4297cb2614b13af@domain.hid>	<4ABD1BAA.2090005@domain.hid>
	<7a15153d0909251252r5ba268e1n885e3a6155b5212@domain.hid>
In-Reply-To: <7a15153d0909251252r5ba268e1n885e3a6155b5212@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High CPU Load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> Well , that is what i thought but i need to stop the software otherwise my
> tasks will be deleted .... That's the why i put this infinite loop .... how
> can i do to keep my tasks running ?

	for(;;)
		pause();

For instance. Or:

	while (!finished)
		pause();

finished being a variable set to a non zero value by some signal handler.

-- 
					    Gilles.

