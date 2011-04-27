Message-ID: <4DB7C8DA.8030803@domain.hid>
Date: Wed, 27 Apr 2011 09:42:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DFFBF4EB468A894AB1474ED220F05AF60134C181@domain.hid>
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C181@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] FW: rtdm_iomap_to_user() I-pipe error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Asier Tamayo <asier.tamayo@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Asier Tamayo wrote:
> Hello,
> 
> Thanks for your help.
> 
> I know my Xenomai version is quite out of date. However, as I'm using
> the ELinOS distribution (which already has its own patches), I find
> it really difficult to upgrade to Xenomai 2.4.10. Anyway, I can apply
> changes to some files.

Sorry, I do not mean that you should upgrade to 2.4.10, I mean you
should run a self-contained test case on an unpatched 2.4.10, in order
to see whether you observe the same behaviour.

> 
> The rtdm_iomap_to_user function is referenced in drvlib.c and
> rtdm_driver.h: I compare the 2.4.7 and 2.4.10 versions and they are
> almost identical, so I think there will be no use in patching the
> kernel for these 2 files. Do you know of any other file that could
> make any difference in my problem?
> 
> If I compare versions 2.4.7 and 2.5.6 (the last one) of Xenomai, I
> can see the last version uses "/dev/rtheap" instead of "/dev/zero"
> and that there are some changes if CONFIG_MMU is not defined. My
> system (Intel Atom N270 CPU) is configured with MMU and therefore the
> only actual changes between the versions are regarding "dev/rtheap".
> Does it make any difference? Xenomai 2.4.7 has "/dev/rtpheap" but no
> "/dev/rtheap"; should I use it instead of "/dev/zero"?

The implementation is different, in order to know why, and which problem
 it solves, you can look into git history. The advantage of using
/dev/rtheap is that the implementation is shared with other skins.

> 
> 
>>> virt_to_phys(new_iomap) --> 0xf5f6f000
>> virt_to_phys is not supposed to work in that case. Since you
>> ioremap'ed the address, you already know the physical address
>> anyway.
>> 
> Is there any function that will tell me the real physical address in
> order to make sure the mapping is correct?

I would say vmalloc_to_page. But do not take my word for it, check the
"linux device drivers" book.

-- 
					    Gilles.

