MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Jan 2014 13:21:50 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <52E10594.4010901@xenomai.org>
References: <52DF9C5F.70005@geral.com> <52DFAA18.6080703@xenomai.org>
 <52DFAD29.4000800@geral.com> <52DFB2DE.4050501@xenomai.org>
 <52DFC734.2090906@geral.com> <52DFC80D.6050101@xenomai.org>
 <52DFCFDE.9060700@geral.com> <52DFD1B0.6070303@xenomai.org>
 <52E0E93C.8010209@xenomai.org>
 <1bab8396d7c946110418979cb8177d9b@grandegger.com>
 <52E10594.4010901@xenomai.org>
Message-ID: <891daa591ae64f3c75be1bf430782be1@grandegger.com>
Subject: Re: [Xenomai] imx28 rtcan flexcan system freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Grandegger <wg@denx.de>, xenomai@xenomai.org

On Thu, 23 Jan 2014 13:05:40 +0100, Gilles Chanteperdrix

<gilles.chanteperdrix@xenomai.org> wrote:

> On 01/23/2014 12:36 PM, Wolfgang Grandegger wrote:

>> How are unaligned accesses handled on your system? Alexandre,

>>

>> what does "cat /proc/cpu/alignment" report? Aligned access

>>

>> would be better, I agree.

> 

> The imx28 can not support unaligned accesses in hardware. The unaligned 

> access causes an exception, /proc/cpu/alignment thus only allow choosing



> how the exception is handled.

> 

> 

>>> Wolfgang, what do you think? Should we change the alignment of

>>

>>> rtcan_rb_frame::data, or use put_unaligned on ARM?

>>

>>

>>

>> I realized the mail and wonder why this problem does not show up with

>>

>> vanilla

> 

> Vanilla handles the alignment trap by emulating the faulting 

> instruction. Last time I checked, there were some problems related to 

> running the emulation over xenomai domain, though looking at the code 

> now, I see nothing which would prevent us from doing it.



Yes, I know. But the handling of unaligned accesses via trap handler must

be

enabled by the user and I'm not aware that this is needed for vanilla

Linux.



Wolfgang.



