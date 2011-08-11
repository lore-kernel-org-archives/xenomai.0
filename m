Message-ID: <4E443712.3060609@domain.hid>
Date: Thu, 11 Aug 2011 22:09:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid>
	<4E43B7E8.5000302@domain.hid>	<4E43C056.9040007@domain.hid>
	<4E43EBC6.10808@domain.hid> <4E440FC2.4070807@domain.hid>
	<4E4422B3.6090101@domain.hid>
In-Reply-To: <4E4422B3.6090101@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On 08/11/2011 08:42 PM, Daniele Nicolodi wrote:
> On 11/08/11 19:22, Gilles Chanteperdrix wrote:
> 
>> Please try and find the point in the latency test where the hang happens
>> (it probably happens when calling a xenomai service, so, not
>> sched_setscheduler), and then post the two disassemblies of this service
>> implementation in libnative.so, the one compiled with 4.4, the other
>> with 4.6.
> 
> The latency test hangs in rt_task_create() attached the function
> disassemblies obtained with gcc-4.4 and gcc-4.6. Hope that this helps,
> those are Aramaic to me.

The gcc 4.6 version is compiled with frame pointer disabled, whereas the
4.4 version is compiled with frame pointers. Enabling the
-fomit-frame-pointer option with gcc 4.4 seems to cause issues as well.

Could you test passing -fno-omit-frame-pointers in the CFLAGS with gcc
4.6 to see if it avoids the issue?

Regards.

-- 
                                                                Gilles.

