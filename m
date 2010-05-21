Message-ID: <4BF64CB9.5010301@domain.hid>
Date: Fri, 21 May 2010 11:04:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100520142614.GA23058@domain.hid>
In-Reply-To: <20100520142614.GA23058@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Monitoring Xenomai scheduler switches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

Tschaeche IT-Services wrote:
> Hi,
> 
> we started an application which monitors task switches
> using Xenomai 2.5.3.
> 
> For monitoring primary domain switches we hooked
> in our code by using rt_task_add_hook(T_HOOK_SWITCH)
> (storing a timestamp and the Xenomai task ID in an array,
> which is read later by user space appl from shared memory).
> 
> It seems, that our code is not called when Xenomai switches to the ROOT task.
> 
> We already had this issue with Xenomai 2.4.10
> and solved it by applying the attached patch.
> 
> How can we catch these Xenomai scheduler events in 2.5.3?
> 
> What is the reason for filtering them out?

The nucleus switch hook service was created to implement the equivalent
service provided by RTOSes such as vxworks, psos, vrtx, etc... And we
wrongly assumed that for these RTOSes the switch hook was not called
when switching to the idle task. So, your patch is indeed neeeded. We
also probably need to change code in some places to avoid missing the
switches which take place when changing mode.

-- 
					    Gilles.

