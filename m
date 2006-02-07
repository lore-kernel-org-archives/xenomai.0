Message-ID: <43E86F4D.4050400@domain.hid>
Date: Tue, 07 Feb 2006 10:58:37 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
References: <b647ffbd0602070104s63275903q@domain.hid>
In-Reply-To: <b647ffbd0602070104s63275903q@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Hello,

Dmitry Adamushko wrote:
> 
> Hi,
> 
> this is the final set of patches against the SVN trunk of 2006-02-03.
> 
> It addresses mostly remarks concerning naming (XN_ISR_ISA -> 
> XN_ISR_EDGE), a few cleanups and updated comments.
> 
> Functionally, the support for shared interrupts (a few flags) to the 
> rtdm (Jan's patch) and native skin.
> In the later case, rt_intr_create() now contains the 6-th argument, 
> namely "int mode".
> 
> Now I'm waiting for the test results from Jan (the previous patch-set 
> remains to be suitable for testing too in case you are using it 
> already). Upon success, the new code is ready for merging.
> 
> the patches have to be applied as follows :
> - shirq-base
> - shirq-v8
> - shirq-proc
> - shirq-edge
> - shirq-ext
> 
> Happy testing ! :)

My concern is code size. I see that the patches add substantial amount 
of code to the ISR. What about make this feature configurable?

Wolfgang.

> -- 
> Best regards,
> Dmitry Adamushko
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


