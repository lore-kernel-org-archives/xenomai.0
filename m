Message-ID: <4E1717D7.9030505@domain.hid>
Date: Fri, 08 Jul 2011 16:44:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E16296B.4080209@domain.hid> <4E16FB11.1080201@domain.hid>
	<4E170EF8.30504@domain.hid>
In-Reply-To: <4E170EF8.30504@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Problems with gcc 4.6.0 (rt_task_shadow fails
 with	ENOSYS)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/08/2011 04:06 PM, Anders Blomdell wrote:
> On 07/08/2011 02:41 PM, Gilles Chanteperdrix wrote:
>> On 07/07/2011 11:47 PM, Anders Blomdell wrote:
>>> When compiling kernel 2.6.37.3 and xenomai 2.5.6 with "gcc version 4.6.0
>>> 20110530 (Red Hat 4.6.0-9) (GCC)", programs fail with -ENOSYS in
>>> rt_task_shadow. If compiled with "gcc version 4.5.1 20100924 (Red Hat
>>> 4.5.1-4) (GCC)" everything works as expected.
>>
>> Could you send us the disassembly of the two functions?
> Which functions? Print[fk] debugging got me to suspect the 
> syscall/skin_mux interface, but I'm a bit at loss of exactly where the 
> code ends up.

The two rt_task_shadow, the one which works, and the one which does not.

-- 
					    Gilles.

