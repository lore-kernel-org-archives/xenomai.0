Message-ID: <434D20EA.9070905@domain.hid>
Date: Wed, 12 Oct 2005 16:42:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] more on registry stuff
References: <BF726DB2.17F3%steve@domain.hid>
In-Reply-To: <BF726DB2.17F3%steve@domain.hid>
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> My app always creates a set of mutexes with the same name. I do this when
> creating them:
> 
>     if(name&&!rt_mutex_bind(&_m, name, TM_NONBLOCK))
> assert(!rt_mutex_delete(&_m));
> 
> 
> This way, if it already exists, I delete it. Then I create it again.
> 
> They do not seem to delete. In fact, I see some duplicate names in
> /proc/registry/mutex
>

Any /proc output to get more details?

> Steven 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

