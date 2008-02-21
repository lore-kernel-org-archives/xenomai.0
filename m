Message-ID: <47BD9763.1040304@domain.hid>
Date: Thu, 21 Feb 2008 16:23:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200802202358.25792.ngustavson@domain.hid>	<47BD316D.3070801@domain.hid>
	<200802210944.56033.ngustavson@domain.hid>
In-Reply-To: <200802210944.56033.ngustavson@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] writing from user space through fifo problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <metalninjadragon@domain.hid>
Cc: xenomai@xenomai.org

NZG wrote:
>> Are you sure it is EINTR? A first glance at the possible code path,
>> specifically at xnpipe_recv, suggests that you cannot reach the line
>> returning this error code if TM_NONBLOCK was passed.
> Your right, my mistake sorry.
> It's returning EAGAIN , which is the same thing as  EWOULDBLOCK in my kernel 
> headers, which corresponds to the correct value when data i s not available, 
> but doesn't explain why data is never received.

OK, that makes more sense.

> 
>> What Xenomai version are we talking about BTW? 
> 2.3.1 (blackfin 537 build)
> 
>> And, as usual: 
>> self-contained simple test cases are always appreciated. :)
> I'll try to put something together tonight.

That's good. This test will also allow you to check it against
 - more recent Xenomai (please check the Changelog for pipe-related
   changes since 2.3.1, I bet there are a few)
 - some other arch, specifically x86 (IIRC, there is still some Linux
   scheduling artifact left in the I-pipe patch for blackfin, but it
   shouldn't make a difference here - well, who knows...)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

