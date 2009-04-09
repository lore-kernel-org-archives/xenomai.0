Message-Id: <F75DBA9B-A2C9-4C05-A339-0B4B47186E8A@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904081659110.22300@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 8 Apr 2009 22:49:48 -0400
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
Subject: Re: [Xenomai-help] Selecting the TSC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

On Apr 8, 2009, at 8:11 PM, Martin Shepherd wrote:

> Regardless, I would still be interested to hear whether there are any
> moves to switch Xenomai over to consulting the run-time cpu_has_tsc
> macro, now that the CONFIG_X86_TSC option no longer configures the use
> of the TSC in the kernel.

Martin, doing it the way Xenomai does it removes a branch from the  
critical path in many places. That is a very good thing!

Steven


