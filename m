Message-ID: <4D2B36A6.3020402@domain.hid>
Date: Mon, 10 Jan 2011 17:41:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201101101718.58201.peter@domain.hid>
In-Reply-To: <201101101718.58201.peter@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Correct use of xeno_sigshadow_install()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Peter Soetens wrote:
> Hi,
> 
> A while ago, I was advised to call xeno_sigshadow_install() after a library 
> installed a sigwinch signal handler (I believe this was Xenomai 2.5.1). Could 
> it be that this is no longer supported in recent versions ? What is the 
> correct way to avoid a segfault if an application installed a sigwinch handler 
> after Xenomai did ?

In fact, I am not sure I understand your question. Could you post a
simple example having this issue?

-- 
                                                                Gilles.

