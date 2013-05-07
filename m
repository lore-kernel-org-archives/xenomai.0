Message-ID: <5188AC8C.9000409@xenomai.org>
Date: Tue, 07 May 2013 09:26:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1367884025.7491.YahooMailNeo@web161401.mail.bf1.yahoo.com>
In-Reply-To: <1367884025.7491.YahooMailNeo@web161401.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] priority of alarm handler?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/07/2013 01:47 AM, Tom Z wrote:
> Hi, I have question regarding using
> int rt_alarm_create     (     RT_ALARM *      alarm,
>          const char *      name,
>          rt_alarm_t      handler,
>          void *      cookie
>      )
>
> If I installed a kernel-space handler to an RT_ALARM object, then when this handler is executing, will this handler be preempted by other higher-priority interrupts? If yes, can I prevent this from happening?
>

No, it won't be preempted by any other interrupt, unless you unmask it 
manually, which you should not do. In addition, kernel-based alarm 
handlers are serialized.

>
> Thanks,
> Tom
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

