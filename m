Message-ID: <0e68629cbfc2c5dca516dee0288fc422.squirrel@domain.hid>
In-Reply-To: <20100511173354.817362i68npdpl9e@domain.hid>
References: <20100511154922.1435425ohdyyt08w@domain.hid>
	<afdd5c92e3183ce45967e21224736fc2.squirrel@domain.hid>
	<20100511173354.817362i68npdpl9e@domain.hid>
Date: Tue, 11 May 2010 17:56:32 +0200 (CEST)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] RT_TASK structure
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
> Actually, I don't use the POSIX skin to implement functions.
>
> So, I used to rt_task_self() to get an identifier, which inside an
> array having corresponding integer data for it. But this seems to be
> non trivial since the array size can be important. The search function
> can cost cpu time.
>
> I though that we can use something like rt_task_get_specific()...

pthread_getspecific/pthread_setspecific are not implemented by the POSIX
skin, they are implemented by libpthread, and since all xenomai user-space
skins use libpthread, your application is already linked with libpthread
anyway. So, there is really no problem using them in an application using
the native skin.


-- 
                    Gilles.


