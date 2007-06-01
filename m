Message-ID: <b647ffbd0706010243p5d6964c1o14066c4efb52a207@domain.hid>
Date: Fri, 1 Jun 2007 11:43:58 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <465FE1D5.6070906@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <465FE1D5.6070906@domain.hid>
Subject: Re: [Xenomai-help] Problem trying to find secondary mode switches.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Hi,

> [...]
> So, my question is: is there any chance that the signal sent by send_sig
> in xnshadow_relax could be received by another thread than send_sig
> target ?

Nop, as far as I can see. Anyway, you can easily verify it by printing
current->pid for the send_sig()'s target in xnshadow_relax() and
calling gettid() (not getpid()) in your signal handler.

> If not, where should I look for the reason of this wrong
> backtrace ?

Are you sure backtrace() is always workable on ARM? I just know that
it's not a case for MIPS..


>
> --
>                                                  Gilles Chanteperdrix

-- 
Best regards,
Dmitry Adamushko

