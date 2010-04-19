Message-ID: <4BCC8D2C.3070905@domain.hid>
Date: Mon, 19 Apr 2010 19:04:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100419190151.56913gdansdxkhvk@domain.hid>
In-Reply-To: <20100419190151.56913gdansdxkhvk@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT_QUEUE problem in Sender/Receiver order
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

Michel He wrote:
> hello everyone,
> 
>     I find out a problem (it seems already mentionned before but I  
> can't find the link to the forum and the post). It deals with the  
> message passing, eg. when we change the order of task execution,  
> something can get wrong. Notice that codes below, if we launch the  
> exection of Recep2,Recep3,Sender, Recep2 won't get the right message.  
> But if we change the order to : Sender,Recep2,Recep3, everything is  
> back to OK. So any explanation ?

A piece of self-contained code, compiling and demonstrating a bug when
running is worth a thousand words.


-- 
					    Gilles.

