Message-ID: <2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid>
Date: Tue, 27 Nov 2007 15:57:51 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

On Nov 27, 2007 3:54 PM, Steven Seeger
<sseeger@domain.hid> wrote:
>
>
>
>
> Nobody responded to me on any ideas to detect a task that has locked up
> without being intrusive to the code. So, I decided to just write a simple
> library for my userspace programs that they can call with a high and low
> priority, and it'll create two handshaking threads. The problem is if the
> higher priority thread doesn't get his expected handshake after so many
> iterations, it can't seem to shut down the program. I even made that thread
> crash with (*(volatile unsigned int*)0) = 123; however, this did not work
> either.
>
>
>
> The old approach I took was to wrap the thread creation routine and then
> keep state for the thread so I could go through and suspend all threads
> under the watchdog. The problem with this method is that it's somewhat
> intrusive to the code. I want to be able to have a watchdog that kills a
> userspace application only, but will leave other userspace applications
> running. I was hoping to just make the program quit. Any ideas?
>
>
>
> I can't find any documentation on the NMI watchdog but I don't think it does
> what I want it to do.

What is wrong with Xenomai watchdog and Linux soft lockup detector ?

-- 
                                               Gilles Chanteperdrix

