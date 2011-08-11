Message-ID: <4E43C056.9040007@domain.hid>
Date: Thu, 11 Aug 2011 13:43:18 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4E43B5FE.4040402@domain.hid> <4E43B7E8.5000302@domain.hid>
In-Reply-To: <4E43B7E8.5000302@domain.hid>
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

On 11/08/11 13:07, Gilles Chanteperdrix wrote:
> On 08/11/2011 12:59 PM, Roland Stigge wrote:
>> Hi,
>>
>> I remember the recent gcc 4.6 issue on this list, but unfortunately,
>> didn't have much time for attention. Now, it found its way to the Debian
>> package: http://bugs.debian.org/637425
>>
>> I wonder if it is a compiler bug or Xenomai's.
> 
> It looks like a xenomai bug due to the pseudo-signals implemented in
> this branch. I have asked two persons which have this compiler to test
> xenomai-head where these signals have been removed to confirm this
> hypothesis, but received no answer as of today.

Hello.

I submitted the debian bug, beside what is the cause of the problem,
binaries compiled with gcc-4.6 are not usable, but binaries compiled
with gcc-4.4 are. I'm compiling xenomai-head right now (this requires
compiling both user space and kernel space, so testing requires some
more time). I'll let you know ASAP.

Cheers,
-- 
Daniele

