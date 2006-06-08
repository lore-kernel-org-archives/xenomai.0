Message-ID: <448837C6.9040905@domain.hid>
Date: Thu, 08 Jun 2006 16:44:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_receive / rt_reply
References: <44883438.1090709@domain.hid>
In-Reply-To: <44883438.1090709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Nicola Pace <nicola@domain.hid>
Cc: xenomai@xenomai.org

Nicola Pace wrote:
> After an rt_receive, is it possible to defer the rt_reply to a later 
> time and in the meantime to do other rt_receive ? In other words, is the 
> following sequence right ?
> 
> rt_receive
>  ... something received from Task A
> rt_receive
>  ... something received from Task B
> rt_receive
>  ... something received from Task C
>      reply to Task A
>      reply to Task C
>    .
>    .
>    .. and so on  .
> 

Yes, provided you pass rt_task_reply() the proper flow identifier as 
received from rt_task_receive() for both ongoing transactions. The 
flowid also allows to deal with situations where the requestor vanishes 
away while its request is being processed by the receiver, before the 
latter has had a chance to reply. In the latter case, the flowid cannot 
match any pending requestors, and -ENXIO would be returned.

-- 

Philippe.

