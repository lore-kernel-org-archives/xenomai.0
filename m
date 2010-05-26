From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100526154252.17507d4no3xmm0e8@domain.hid>
References: <20100526154252.17507d4no3xmm0e8@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 May 2010 15:53:31 +0200
Message-ID: <1274882011.10529.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] equivalent of rtai's rt_get_adr
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-05-26 at 15:42 +0200, Michel He wrote:
> Hello all,
> 
>     In order to search a specific task name in Xenomai, the question  
> is what can be equivalent to rt_get_adr (from RTAI) to get a pointer  
> of RT_TASK with a task name ?

rt_task_bind().

> 
> thank you all
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



