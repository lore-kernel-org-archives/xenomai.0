Message-ID: <4AD8728C.4050904@domain.hid>
Date: Fri, 16 Oct 2009 15:18:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <264350.28868.qm@domain.hid>
In-Reply-To: <264350.28868.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shm_open returns errno 38 - function not
	implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

Yigal Goldberger wrote:
> Gilles,
> Thanks for the answer.
> 
> I need shared memory only between user space applications , so I do prefer the second option. (our system is stable and we're satisfied from the performance , so we'd like to make as little changes as possible at this mature stage of the project ).
> Can you advise me how to get the right version of the glibc (is it a stand alone change , simply replacing the glibc file , or do I need to make other changes ?)
> 
> Thanks again to the Xenomai operation , and to you personaly for your support !
> Yigal Goldberger .

Any reasonably recent version of the glibc should do, but:
- you may be using the glibc from your toolchain, so changing glibc may
mean changing toolchain;
- well, the glibc is a bit the heart of the user-space support. It has
more than one files. And changing them may change a lot of things.

So, I think, the simpler thing for you is to use xenomai shared memories.


-- 
                                          Gilles


