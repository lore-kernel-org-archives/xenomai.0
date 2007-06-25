Message-ID: <cbe23c50706250905r38f1471ak72d82bc58c31b259@domain.hid>
Date: Mon, 25 Jun 2007 18:05:02 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <cbe23c50706250904i57afbc0xfbce52fdb9dccc66@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <467FBC67.8030805@domain.hid>
	<cbe23c50706250904i57afbc0xfbce52fdb9dccc66@domain.hid>
Subject: [Xenomai-help] Fwd:  Xenomai and mlockall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Sorry forgot to send to the list

---------- Forwarded message ----------
From: Eric Noulard <eric.noulard@domain.hid>
Date: 25 juin 2007 18:04
Subject: Re: [Xenomai-help] Xenomai and mlockall
To: Johan Borkhuis <j.borkhuis@domain.hid>


2007/6/25, Johan Borkhuis <j.borkhuis@domain.hid>:
> I am trying to run my Xenomai application as non-root. I disabled
> XENO_OPT_SECURITY_ACCESS to allow non-root users to run Xenomai
> applications. However, this causes my application to exit with the error:
>
> Xenomai: process memory not locked (missing mlockall?)
>
> Is there a way to avoid this error? I am running on an embedded system
> without swap and without disk, so there is no real need for mlock or
> mlockall.

I may be wrong but even on embedded system without
mlockall(MCL_FUTURE) how can you be sure the memory you get from from
a dynamically allocated memory (malloc/calloc etc...) is
currently allocated in PHYSICAL memory?

Usually linux is lazy and it gives you "real" memory when
you hit the memory page.

> Is there a way to "tweak" the CAP_IPC_LOCK capability of the system or
> the task so that I can run mlockall call,

May be you can use 'sudo' to run the task?

> or is there a way to disable this check on Xenomai?

I am not able to answer this one :))

--
Erk


-- 
Erk

