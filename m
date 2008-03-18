Message-ID: <2ff1a98a0803180832u4dffd089p4b9acd1a1a553b32@domain.hid>
Date: Tue, 18 Mar 2008 16:32:15 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803180622g6883e066v70c21ba846acdaab@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803140404y1febc9e0g7c6ab90497b347d3@domain.hid>
	<d6c8ef150803140407j496a8d9ah477b001a49e411bf@domain.hid>
	<d6c8ef150803140920u59c84733l64d9cf0c8669097c@domain.hid>
	<47DAA815.4010804@domain.hid>
	<d6c8ef150803180622g6883e066v70c21ba846acdaab@domain.hid>
Subject: Re: [Xenomai-help] [Adeos-main] New I-pipe patch for ARM.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, Mar 18, 2008 at 2:22 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> OK. What about memcpy-ing to kmalloc()-ed memory? Like, kmalloc() is
>  called outside real-time task, but memcpy-in something to that memory
>  is done in realtime.

The answer is always the same, look at memcpy implementation and check
if it is calling spinlock* or local_irq*, or calling functions that do
so. In fact, Xenomai would not even work if memcpy was not callable
from real-time context.

-- 
 Gilles Chanteperdrix

