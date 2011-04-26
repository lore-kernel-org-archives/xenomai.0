Date: Tue, 26 Apr 2011 15:47:22 +0200 (CEST)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <31967139.181303825640562.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <28969746.161303825604578.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: xenomai@xenomai.org


> Why would not it be correct? I mean, Linux threads are joinable by
> default, so, it is normal that rt_task_join succeeds. Now, we can
> implement a different behaviour, but for what reason?

OK sorry, I wrongly think that rt_task_shadow() follows rt_task_create() behaviour (task was joinable only if T_JOINABLE specified).

Thank you, regards.

