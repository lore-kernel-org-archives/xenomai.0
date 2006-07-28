From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17610.5728.464611.778617@domain.hid>
Date: Fri, 28 Jul 2006 15:51:28 +0200
Subject: Re: [Xenomai-help] Re: RT_TASK_INFO status
In-Reply-To: <44C9D319.7020704@domain.hid>
References: <1154015872-24969.00053.00861-smmsdV2.1.4@domain.hid>
	<44C8EECE.4070209@domain.hid> <44C90CEF.9090908@domain.hid>
	<44C9136C.7080709@domain.hid> <44C9420D.3070100@domain.hid>
	<44C9D319.7020704@domain.hid>
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
Cc: xenomai@xenomai.org, Nathaniel Villaume <villaume@domain.hid>

Jan Kiszka wrote:
 > > Third: I removed the duplication as you requested. This is not without
 > > consequence.  Please note the difference between RT_TASK_INFO and
 > > RT_TASK_MCB (which remainded the same).  To keep the brief member
 > > documentation, I had to use the /**  comment */ syntax. This is
 > > inconsistent with other usage, but... this gives the results we want.
 > 
 > Yeah, I noticed this as well. Is this somewhere documented in the
 > doxygen manual? Anyway, I prefer the output format of "/**" or "/**<"
 > for such small structures like we have here.

Here is how (I think) this works:
- the '<' syntax may only be used to comment members of something larger
  like a structure or union
- they will not appear if the larger thing is not itself commented
- putting a documentation with a /** */ before the member is equivalent
  to putting a documentation block with a /**< */ after the member.

As for the brief documentation, the autobrief mode is enabled, so the
first sentence of each documentation block should be taken as brief
automatically.

-- 


					    Gilles Chanteperdrix.

