From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100520142614.GA23058@domain.hid>
References: <20100520142614.GA23058@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 May 2010 11:28:41 +0200
Message-ID: <1274434121.2444.9.camel@domain.hid>
Mime-Version: 1.0
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

On Thu, 2010-05-20 at 16:26 +0200, Tschaeche IT-Services wrote:
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

No valid one. Patch queued in my tree, thanks.

> 
> Best regards,
> 
> 	Olli
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



