Message-ID: <4F2BFC70.8080406@domain.hid>
Date: Fri, 03 Feb 2012 16:25:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F2BF442.9080308@domain.hid> <4F2BFBBA.7030805@domain.hid>
In-Reply-To: <4F2BFBBA.7030805@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Only export required CFLAGS via
	xeno-config
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 02/03/2012 04:22 PM, Gilles Chanteperdrix wrote:
> On 02/03/2012 03:50 PM, Jan Kiszka wrote:
>> -Werror-implicit-function-declaration is not compatible with C++, and
>> also decisions about -Wall and -pipe should be left to the application.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>  configure.in |   12 ++++++------
>>  1 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/configure.in b/configure.in
>> index b2563ee..2185925 100644
>> --- a/configure.in
>> +++ b/configure.in
>> @@ -448,13 +448,13 @@ else
>>  fi
>>  AC_MSG_RESULT([done])
>>  
>> -dnl Common CFLAGS and LDFLAGS
>> -XENO_USER_CFLAGS="-D_GNU_SOURCE -D_REENTRANT -Wall -Werror-implicit-function-declaration -pipe"
>> -XENO_USER_LDFLAGS=
>> +dnl Exported CFLAGS and LDFLAGS, shared with internal flags
>> +XENO_USER_APP_CFLAGS="-D_GNU_SOURCE -D_REENTRANT"
>> +XENO_USER_APP_LDFLAGS=
>>  
>> -dnl Exported CFLAGS and LDFLAGS, may be enhanced per-arch below
>> -XENO_USER_APP_CFLAGS=$XENO_USER_CFLAGS
>> -XENO_USER_APP_LDFLAGS=$XENO_USER_LDFLAGS
>> +dnl Internal CFLAGS and LDFLAGS, may be enhanced per-arch below
>> +XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -Werror-implicit-function-declaration -pipe"
>> +XENO_USER_LDFLAGS="$XENO_USER_APP_LDFLAGS"
> 
> We do not build C++ code, so I see no problem with using flags
> incompatible with C++, and customize the flags according to our
> preferences. Now, the flags returned by xeno-config are another issue,
> if this is what you want to change, please do not change the flags used
> to compile xenomai globally.
> 
Which is exactly what your patch is doing, sorry for the noise, the
patch looks fine.

-- 
					    Gilles.

