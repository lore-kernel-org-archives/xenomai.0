Message-ID: <d4a823590734a81ec4ef71cf6c26ef69.squirrel@domain.hid>
In-Reply-To: <4E44E1C2.50800@domain.hid>
References: <4E43B5FE.4040402@domain.hid> <4E43B7E8.5000302@domain.hid>
	<4E43C056.9040007@domain.hid> <4E43EBC6.10808@domain.hid>
	<4E440FAC.5020107@domain.hid> <4E4411DB.80009@domain.hid>
	<4E444102.10206@domain.hid> <4E446345.9060705@domain.hid>
	<4E44E1C2.50800@domain.hid>
Date: Fri, 12 Aug 2011 10:46:51 +0200 (CEST)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] gcc-4.6 issue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org


Daniele Nicolodi wrote:
> On 12/08/11 01:18, Gilles Chanteperdrix wrote:
>> The following patch seems to do the trick. It makes the assumption that
>> when compiling with -fomit-frame-pointer, we have one more register, so
>> the "R" constraint will always be able to avoid choosing eax, and eax
>> will be free for the muxcode, so that the compiler will not choose the
>> "m" alternative.
>
> It works, indeed. Thank you Gilles.
>
> May this patch be backported to the stable branch?

I do not think so, simply compile with -fno-omit-frame-pointer.

-- 
                    Gilles.


