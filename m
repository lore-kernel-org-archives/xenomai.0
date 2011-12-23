Message-ID: <4EF4DFAB.9040406@domain.hid>
Date: Fri, 23 Dec 2011 21:08:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20111223173309.GM27742@domain.hid>
	<4EF4C5A5.6000105@domain.hid>
	<20111223183246.GN27742@domain.hid>
In-Reply-To: <20111223183246.GN27742@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] CONFIG_XENO_HW_UNLOCKED_SWITCH=y causes random
 process corruption in xenomai 2.6.0 on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: xenomai@xenomai.org

On 12/23/2011 07:32 PM, Lennart Sorensen wrote:
> On Fri, Dec 23, 2011 at 07:17:09PM +0100, Philippe Gerum wrote:
>> Papering over a bug this way is certainly not an option.
>
> Long term it certainly isn't.
>
>> Which kernel version, what ppc hardware?
>
> 3.0.13, 3.0.9, 3.0.8.  mpc8360e.
>
> xenomai 2.6.0 with ipipe 3.0.8-powerpc-2.13-04
>

Do you have a typical test scenario which triggers this bug?

-- 
Philippe.

