Message-ID: <48AAF55E.9000206@domain.hid>
Date: Tue, 19 Aug 2008 18:31:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
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
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello,
>  
> I am opening the uClinux side of a Xenomai pipe like (so in blocking mode):
> FdPipe = open(PipeName, O_RDWR);
> After some writes to FdPipe I get the returnvalue -ENOMEM.
> I can understand that the internal buffer gets full as my application is
> writing data faster than the Xenomai side is consuming, but I don't
> expect to see a returnvalue -ENOMEM : the calling writing-thread should
> block, isn't it?  Please comment.
>

RT is assumed to consume asap and will preempt the non-RT write() caller
immediately upon data receipt, unless the RT code uses some kind of timed
polling, which is considered useless and inefficient, since you can ask a RT
thread to wait for incoming data in a blocking way.

> (When adding the O_SYNC flag things get even worse)
>  

That is the point that would actually need fixing: what happens with O_SYNC,
what is worsening exactly?

> Why is the code for xnpipe_write saying:
> if (!mh)
>   /* Cannot sleep. */   <--- ???????????????????
>   return -ENOMEM;
>  
> I am using svn version 4105.
>  
> Best regards,
> Filip
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

