Subject: Re: [Xenomai-help] RTDM PCI development framework
From: ramv <vikesh.rambaran@domain.hid>
In-Reply-To: <44FD5CF1.7000603@domain.hid>
References: <1157443250.4466.12.camel@domain.hid> 
	<44FD5CF1.7000603@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Sep 2006 17:55:28 +0200
Message-Id: <1157471728.4466.27.camel@domain.hid>
Mime-Version: 1.0
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
Cc: xenomai@xenomai.org

Hi
Thanx for the feedback thus far.

On Tue, 2006-09-05 at 13:18 +0200, Jan Kiszka wrote:

> The idea to provide some template for (PCI) driver development is
> definitely a good one. Your approach already look quite nice, but it is
> generally wise to apply such templates at least on two different drivers
> to see what may be missing, what needs refinement, or what is not required
> 
> A few comments already: it would be nice to add kernel 2.4 support to
> your Makefile. Keep an eye on potential "over-design", i.e. avoid
> wrapping trivial things, rather concentrate on providing templates the
> user can fill in stuff directly.
> 

Yup, those are good suggestions. That's one of the reasons i posted to
this list. I'm still too new at device drivers to know the various
application scenarios, so suggestions from others would help greatly.

Is there an alternative preferred method to make code available for
review ?

Will put the suggestions on the TODO list.

> > *******************************************************************************************************
> > Disclaimer:  The information contained in this communication is confidential and may be legally privileged.  
> 
> Mmm, was it illegal then to read your mail? Or the attachment?? ;)
> 
> Jan
> 

PS. The disclaimer gets attached automatically by our mail server. Have
applied for a gmail account and will start a thread from there later.

Keep well
Vicki


*******************************************************************************************************
Disclaimer:  The information contained in this communication is confidential and may be legally privileged.  
It is intended solely for the use of the individual or entity to whom it is addressed and others authorised to receive it.  
Any review, retransmission, dissemination, copying, disclosure or other use of, or taking of any action in reliance upon, this information by person or entities other then the intended recipient is prohibited.  
If you have received this message in error, please notify the sender immediately by e-mail, facsimile or telephone and return and/or destroy the original message and all copies from any computer.  

Denel (Pty) Ltd exercises no editorial control over e-mail messages originating in the organisation and does not accept any responsibility for either the contents of the message or any copyright laws that may have been violated by the person sending this message.  
Denel (Pty) Ltd is neither liable for the proper and complete transmission of the information contained in this communication nor any delay in its receipt.  
This message should not be copied or used for any purpose other than intended, nor should it be disclosed to any other person.
*******************************************************************************************************


