Message-ID: <20100511173354.817362i68npdpl9e@domain.hid>
Date: Tue, 11 May 2010 17:33:54 +0200
From: Michel He <michel.he@domain.hid>
References: <20100511154922.1435425ohdyyt08w@domain.hid>
	<afdd5c92e3183ce45967e21224736fc2.squirrel@domain.hid>
In-Reply-To: <afdd5c92e3183ce45967e21224736fc2.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Actually, I don't use the POSIX skin to implement functions.

So, I used to rt_task_self() to get an identifier, which inside an =20
array having corresponding integer data for it. But this seems to be =20
non trivial since the array size can be important. The search function =20
can cost cpu time.

I though that we can use something like rt_task_get_specific()...


Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =E9crit=A0:

>
> Michel He wrote:
>> Hello all,
>>
>>        In Xenomai, I need an equivalent function of
>> pthread_setspecific in order to register a key element associated to
>> the RT_TASK. Is it possible to you (maintainers of Xenomai core) to
>> add an extra integer type (let's say int user_specific_data inside the
>> struct rt_task) in the RT_TASK structure and then add functions
>> similar to pthread_setspecific and pthread_getspecific to allow user
>> to write and get this integer value (associated to RT_TASK) ?
>
> What is wrong with pthread_getspecific/pthread_setspecific? If you do not
> like them, you may use __thread storage local variables.
>
> --
>                     Gilles.
>
>



