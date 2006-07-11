Message-ID: <4546494d0607102348g181624cfxc14b47c85c00efb4@domain.hid>
Date: Tue, 11 Jul 2006 14:48:26 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
Subject: Re: [Xenomai-help] Sychronize between Linux and Xenomai domain
In-Reply-To: <44B341E2.9040506@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_105777_3767416.1152600506199"
References: <4546494d0607092316s7dbc7406j2436714deccbfb91@domain.hid>
	<44B1FDBD.4060600@domain.hid>
	<4546494d0607100148s1f5476e3tb3f58d7ae48d4a72@domain.hid>
	<44B218C5.9000804@domain.hid>
	<4546494d0607100231x469aa596s2513e5b36cad8550@domain.hid>
	<44B2216A.1060904@domain.hid>
	<4546494d0607102125w2817ccd1j746651214cac3a6d@domain.hid>
	<44B341E2.9040506@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_105777_3767416.1152600506199
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes. I am concerned about UP situation. But I am still a little confused.

Do you mean in a "normal Linux driver", I can use

rtdm_lock_get_irqsave() to protect my Linux task from being preempted by
Xenomai task?


The code shows that:
"
#define rtdm_lock_get_irqsave(lock, context)    \
    rthal_spin_lock_irqsave(lock, context).

#define rthal_spin_lock_irqsave(lock,x) \
do {  \
    rthal_local_irq_save(x); \
    rthal_spin_lock(lock); \
} while(0)

#define rthal_local_irq_save(x) ((x) =
!!ipipe_test_and_stall_pipeline_from(&rthal_domain)

------=_Part_105777_3767416.1152600506199
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Yes. I am concerned about UP situation. But I am still a little confused.<br><br>Do you mean in a &quot;normal Linux driver&quot;, I can use<br><br>rtdm_lock_get_irqsave() to protect my Linux task from being preempted by Xenomai task?
<br><br><br>The code shows that:<br>&quot;<br>#define rtdm_lock_get_irqsave(lock, context)&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp; rthal_spin_lock_irqsave(lock, context).<br><br>#define rthal_spin_lock_irqsave(lock,x) \<br>
do {&nbsp; \<br>
&nbsp;&nbsp;&nbsp; rthal_local_irq_save(x); \<br>
&nbsp;&nbsp;&nbsp; rthal_spin_lock(lock); \<br>
} while(0)
<br><br>#define rthal_local_irq_save(x)		((x) = !!ipipe_test_and_stall_pipeline_from(&amp;rthal_domain)

------=_Part_105777_3767416.1152600506199--

