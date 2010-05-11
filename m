Message-ID: <afdd5c92e3183ce45967e21224736fc2.squirrel@domain.hid>
In-Reply-To: <20100511154922.1435425ohdyyt08w@domain.hid>
References: <20100511154922.1435425ohdyyt08w@domain.hid>
Date: Tue, 11 May 2010 16:00:04 +0200 (CEST)
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
> Hello all,
>
>        In Xenomai, I need an equivalent function of
> pthread_setspecific in order to register a key element associated to
> the RT_TASK. Is it possible to you (maintainers of Xenomai core) to
> add an extra integer type (let's say int user_specific_data inside the
> struct rt_task) in the RT_TASK structure and then add functions
> similar to pthread_setspecific and pthread_getspecific to allow user
> to write and get this integer value (associated to RT_TASK) ?

What is wrong with pthread_getspecific/pthread_setspecific? If you do not
like them, you may use __thread storage local variables.

-- 
                    Gilles.


