Message-ID: <4E44FBAA.1010301@domain.hid>
Date: Fri, 12 Aug 2011 12:08:42 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid>	<4E43B7E8.5000302@domain.hid>	<4E43C056.9040007@domain.hid>	<4E43EBC6.10808@domain.hid>	<4E440FAC.5020107@domain.hid>	<4E4411DB.80009@domain.hid>	<4E444102.10206@domain.hid>	<4E446345.9060705@domain.hid>
	<4E44E1C2.50800@domain.hid>
In-Reply-To: <4E44E1C2.50800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] gcc-4.6 issue
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On 12/08/11 10:18, Daniele Nicolodi wrote:
> On 12/08/11 01:18, Gilles Chanteperdrix wrote:
>> The following patch seems to do the trick. It makes the assumption that 
>> when compiling with -fomit-frame-pointer, we have one more register, so
>> the "R" constraint will always be able to avoid choosing eax, and eax 
>> will be free for the muxcode, so that the compiler will not choose the 
>> "m" alternative.
> 
> It works, indeed. Thank you Gilles.

I've spoken to early. The patch does not work for the posix skin.
Posix skin services return "function not implemented" errors when
xenomai user space is compiled with the patch and gcc-4.6, they work
just fine when compiled with gcc-4.4 (without the patch).

Cheers,
-- 
Daniele

