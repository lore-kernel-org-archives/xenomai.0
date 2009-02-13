Message-ID: <4995B619.1040506@domain.hid>
Date: Fri, 13 Feb 2009 19:04:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <57e813c90902130946p362eeb18m3141b31fc6aee873@domain.hid>
In-Reply-To: <57e813c90902130946p362eeb18m3141b31fc6aee873@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Confusion regarding linux/xenomai tasks
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zara Tustra <zarawesome@domain.hid>
Cc: xenomai@xenomai.org

Zara Tustra wrote:
> I've read some information regarding the difficulty of communication
> between Linux threads and Xenomai tasks, and I've had some
> misinformation fired at me from co-workers.

Regarding this, you definitely need to fix your co-workers, not Xenomai.

 I just want to make some
> points clear:
> 
> 1) Can a Linux application launch Xenomai tasks, or I've horribly
> misread things somewhere? My understanding is that Xenomai tasks are
> commonly activated by a Linux process.
> 
> 2) Can real-time Xenomai tasks started by a Linux application
> communicate with it through the global variables of that application?
> 
> 3) What happens if I make a syscall or similar non-real-time call from a
> Xenomai task? Is the task automatically 'demoted' to non-real-time? How
> can I tell?
>

Please start there:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf

> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

