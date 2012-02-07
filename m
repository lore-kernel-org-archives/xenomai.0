Message-ID: <4F314F63.1000501@domain.hid>
Date: Tue, 07 Feb 2012 17:20:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F2BF442.9080308@domain.hid> <4F314ED6.6060502@domain.hid>
In-Reply-To: <4F314ED6.6060502@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On 2012-02-07 17:18, Gilles Chanteperdrix wrote:
> On 02/03/2012 03:50 PM, Jan Kiszka wrote:
>> -Werror-implicit-function-declaration is not compatible with C++, and
>> also decisions about -Wall and -pipe should be left to the application.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> 
> Had to revert this patch, it causes a build failure when cross-compiling
> (for ARM, I do not know if it matters).

-pipe? Or a weird compiler bug? -Wsomething can't make a difference.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

