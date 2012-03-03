Message-ID: <4F524FA1.5010908@domain.hid>
Date: Sat, 03 Mar 2012 18:06:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADAaWNWgKaf9DWXA6YN4iwFa2xXfK2FNkTULGnY4TSKvvW6Whg@domain.hid>
In-Reply-To: <CADAaWNWgKaf9DWXA6YN4iwFa2xXfK2FNkTULGnY4TSKvvW6Whg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scheduling and context switch in Xenomai: - reg
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: SUBRAMANIAN NATESAN <yenyes88@domain.hid>
Cc: xenomai@xenomai.org

On 03/03/2012 02:02 PM, SUBRAMANIAN NATESAN wrote:
> Hi,
> 
> During the context switch in scheduling, could you please let me know,
> where the process/thread's information or state is stored and which
> function call is responsible for it?

Linux uses switch_to, xenomai uses xnarch_switch_to. These are defined
differently for each architecture and may be either macros or functions
depending on the architecture. The registers are loaded and saved from
the task control block.

-- 
                                                                Gilles.

