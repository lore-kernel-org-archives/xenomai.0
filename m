Message-ID: <4D3E8FF6.4030602@domain.hid>
Date: Tue, 25 Jan 2011 09:55:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>	<alpine.DEB.1.10.1101200922440.1211@domain.hid>	<4D384CC9.2040303@domain.hid>	<alpine.DEB.1.10.1101201702340.1990@domain.hid>	<4D386922.5080807@domain.hid>	<alpine.DEB.1.10.1101201811090.1990@domain.hid>	<4D387148.3030306@domain.hid>	<alpine.DEB.1.10.1101211222330.3495@domain.hid>	<4D3D7107.7030603@domain.hid>	<alpine.DEB.1.10.1101250941170.12329@domain.hid>
	<4D3E8EF9.2010606@domain.hid>
In-Reply-To: <4D3E8EF9.2010606@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Kolja Waschk wrote:
>> Hi,
>>
>>> The thing I do not understand is that you should not pass any ldflags to
>>> cond-torture-posix, Xenomai build system should have been taken care
>> I have to admit I haven't watched how cond-torture-posix was built. The one I
>> used then was built during the build process of blackfin-uclinux-dist. But
>> since it is the same error that occurs in my shortened example, and xeno-config
>> emits those flags, I assumed that compile flags were used for
>> cond-torture-posix similarly.
>>
>> The short example I refer to is the one described in my posting to the 
>> blackfin toolchain-help Forum: Given the example code "a.c"
>>
>> int main()
>> {
>>      return 0;
>> }
>>
>> Compile it with:
>>
>> bfin-linux-uclibc-gcc  -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib -lxenomai -lpthread_rt -lpthread a.c
> 
> The link order is wrong. It should be -lpthread_rt -lxenomai -lpthread.

Actually -lpthread_rt -lxenomai -lpthread -lrt.

Yes, please start a neew thread.


-- 
                                                                Gilles.

