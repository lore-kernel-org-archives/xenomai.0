Message-ID: <4E8F2BF9.5030408@domain.hid>
Date: Fri, 07 Oct 2011 18:42:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<CACFV95+0bWjvQfotboZkHA-ynNWAdYLfqn3RYprr9gpY=hUSNg@domain.hid>
In-Reply-To: <CACFV95+0bWjvQfotboZkHA-ynNWAdYLfqn3RYprr9gpY=hUSNg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
 major=10 minor=254) in mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Cc: xenomai@xenomai.org

On 10/07/2011 06:27 PM, Siva kumar Balasubramanian wrote:
> After running make Devices also ,
> 
> i am getting error
> 
> /usr/xenomai/bin/xeno-load: line 180: 3347 Segmentation fault $suflag $*
> $cmdargs
> 
> My log file link http://pastebin.com/PpnnmnuW

Please do not use xeno-test with xenomai 2.5 branch, launch the latency
and generate load by hand.

-- 
					    Gilles.

