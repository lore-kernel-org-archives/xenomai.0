Message-ID: <444E61F0.9000606@domain.hid>
Date: Tue, 25 Apr 2006 19:52:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] syslog safe?
References: <20060425134048.D5934@domain.hid>
In-Reply-To: <20060425134048.D5934@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Kent Borg <kentborg@domain.hid>
Cc: xenomai@xenomai.org

Kent Borg wrote:
> Is syslog() safe to call from real time userland code?  (If not, what
> is the right way to do such output?)

No problem using it, but it will trigger an automatic switch to 
secondary mode in order to issue the right Linux syscalls. The thread 
will switch back to primary automatically again as soon as a (usually 
blocking) Xenomai syscall is issued.

-- 

Philippe.

