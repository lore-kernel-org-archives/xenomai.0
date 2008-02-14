Message-ID: <2ff1a98a0802140927p64490a30sff85200b4a5e452f@domain.hid>
Date: Thu, 14 Feb 2008 18:27:35 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200802141705.17258@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200802141055.1177@domain.hid> <200802141058.2356@domain.hid>
	<2ff1a98a0802140532v36aed06bnff68387cc04cbec9@domain.hid>
	<200802141648.10545@domain.hid> <200802141705.17258@domain.hid>
Subject: Re: [Xenomai-help] Slow sin function
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Feb 14, 2008 at 5:05 PM, Petr Cervenka <grugh@domain.hid> wrote:
> _
>
>
> >On Thu, Feb 14, 2008 at 10:58 AM, Petr Cervenka <grugh@domain.hid> wrote:
>  >> Hello again.
>  >>  I have another problem and I'm not sure if it is connected with Xenomai ,
>  >>  but perhaps you already met similar problem.
>  >>  Occasionally  the math sin function takes an enormous amount of time
>  >>  (400-450 us on Athlon A64 X2 4800+). When I detect this and make the sin function
>  >>  call with the same parameter again, it takes the same (long) time. I
>  >>  suspect that this function is for some values is unreasonably slow. I'll
>  >>  try to capture some such values and post them here.
>  >>  I don't remember such behavior before the transition to newer 64bit linux
>  >>  distribution (Kubuntu 7.10 amd64 and kernel 2.6.24).
>  >>  Petr Cervenka
>  >
>  >I would expect the sin function to be built-in, at least, I think it
>  >is built-in on x86_32.
>  >
>  >Now, looking at glibc code, there seem to be a loop in the
>  >implementation of these functions.
>  >
>  >--
>  > Gilles Chanteperdrix
>  >
>  I managed to capture two such numbers:
>  0.93340582292648832662962377071381      (0x00b06be375deed3f)
>  3.9225160069792437411706487182528       (0x5019801250610f40)
>
>  Tried on similar 32bit machine (2.6.19.7), everything is OK there.
>  Any idea how to solve it or who to inform about this problem?

If it is really an issue, it is a glibc issue. So, you should send
your problem to the glibc people. But check before that the bug has
not been fixed by a more recent glibc.

>
>  Short program for trying this problem:

I would use cli, sti and rdtsc to make the test more convincing.

-- 
 Gilles Chanteperdrix

