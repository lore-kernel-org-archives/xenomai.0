Date: Thu, 20 May 2010 10:54:46 -0400
Message-ID: <20100520145446.GA3841@domain.hid>
References: <20100520142614.GA23058@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20100520142614.GA23058@domain.hid>
From: Andreas Glatz <andreasglatz@domain.hid>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

> 
> we started an application which monitors task switches
> using Xenomai 2.5.3.
> 
> For monitoring primary domain switches we hooked
> in our code by using rt_task_add_hook(T_HOOK_SWITCH)
> (storing a timestamp and the Xenomai task ID in an array,
> which is read later by user space appl from shared memory).
> 

This is not related to your actual question: 

Do you want to monitor task switches for debugging or is it part of your application? If for debugging, have you ever used lttng? I know it takes a while to install it but it's quite reliable and can give you much more than the info when a certain task switch occured.

Regards, Andreas



