Subject: Re: [Xenomai-help] Which thread holds a Mutex?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4613623A.6090008@domain.hid>
References: <4613623A.6090008@domain.hid>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 10:50:29 +0200
Message-Id: <1175676629.4666.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-04-04 at 10:30 +0200, Stephan Zimmermann wrote:
> Hi,
> I see a deadlock occur every now and than in my app. Is there a way to 
> tell which thread is actually holding a lock from a normal userspace 
> app? rt_mutex_inquire() only tells me that it is locked, but not who is 
> holding it.
> 

/proc/xenomai/registry/native/mutexes/...

> Tia, Stephan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



