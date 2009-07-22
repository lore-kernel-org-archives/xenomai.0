Message-ID: <4A66D61E.5000904@domain.hid>
Date: Wed, 22 Jul 2009 11:04:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <898521.61258.qm@domain.hid>
In-Reply-To: <898521.61258.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai exceptions tracing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

Yigal Goldberger wrote:
> Hi all, I'm using kernel 2.6.29.4 with xenomai . I'm getting an
> exception 769 . I'd like to know what this exception means (or hints
> where to look for it ).

Well the meaning of exceptions is dependent on the platform you are 
using, so we can not answer without more information.

> 
> (...)<6>Xenomai:
> Switching 802Rdr to secondary mode after exception #769 from user-sp 
> ace at 0x10017cec (pid 974) 

However, you can ask to receive a signal at the point where the 
exception happens, doing as in ksrc/skins/native/snippets/sigxcpu.c, 
only using pthread_set_mode_np instead of rt_task_set_mode, if you use 
the posix skin.

Alternatively, you have a way of knowing directly where the exception 
happens by disassembling your example program and look where 0x10017cec is.

P.S: if you do not like the way your message looks when I rewrap it, 
send it correctly wrapped.

-- 
                                           Gilles


