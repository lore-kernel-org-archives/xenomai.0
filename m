Message-ID: <4F7C4667.7010609@domain.hid>
Date: Wed, 04 Apr 2012 15:02:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F7C44FD.2040406@domain.hid>
In-Reply-To: <4F7C44FD.2040406@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] rt-puts fix, mprotect testsuite
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

On 04/04/2012 02:56 PM, Jan Kiszka wrote:
> The following changes since commit 0ef2410a2c9cf7102dead861241bd2d9957e4433:
> 
>   Mask signals in rt_print:printer_loop() (2012-04-02 00:16:41 +0200)
> 
> are available in the git repository at:
>   git://git.xenomai.org/xenomai-jki.git for-upstream
> 
> Jan Kiszka (3):
>       Append missing newline to rt_[f]puts output
>       testsuite: Add rt-print buffer flushes to native error paths

As I said, I do not agree with calling rt_print_flush_buffers outside of
xenomai libs. If you want to avoid the issue you should use rt_printf only.

-- 
					    Gilles.

