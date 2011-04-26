Message-ID: <4DB70921.9020301@domain.hid>
Date: Tue, 26 Apr 2011 20:04:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <31967139.181303825640562.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <31967139.181303825640562.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_join() small issue on not-joinable task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
>> Why would not it be correct? I mean, Linux threads are joinable by 
>> default, so, it is normal that rt_task_join succeeds. Now, we can 
>> implement a different behaviour, but for what reason?
> 
> OK sorry, I wrongly think that rt_task_shadow() follows
> rt_task_create() behaviour (task was joinable only if T_JOINABLE
> specified).

The T_JOINABLE bit is not documented for rt_task_shadow. So, any
behaviour is valid. But as I said, we can add it.

> 
> Thank you, regards.
> 
> _______________________________________________ Xenomai-help mailing
> list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help
> 


-- 
                                                                Gilles.

