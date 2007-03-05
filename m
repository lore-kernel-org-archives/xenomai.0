Message-ID: <45EC4F8E.905@domain.hid>
Date: Mon, 05 Mar 2007 18:12:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
References: <45EC4111.6070104@domain.hid>
	<45EC428E.5060306@domain.hid>
	<45EC4AF4.7000808@domain.hid>
In-Reply-To: <45EC4AF4.7000808@domain.hid>
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
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

Markus Franke wrote:
> what happens if rt_pipe_write() returns
> -ENOMEM? Does the data to be written simply get lost or is it simply
> enqeued at the end and the first element in the pipe get's lost?
> 

No, the rt_pipe_write which returns an error fails.

-- 
                                                 Gilles Chanteperdrix

