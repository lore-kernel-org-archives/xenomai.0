Message-ID: <475D7DF6.3070502@domain.hid>
Date: Mon, 10 Dec 2007 18:57:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <c12ec2810712100218s7c93af6drc2ada3ee7644c152@domain.hid>	<475D4A31.1080908@domain.hid>
	<c12ec2810712100655l47f5f55dr5ca5e762e18a1522@domain.hid>
In-Reply-To: <c12ec2810712100655l47f5f55dr5ca5e762e18a1522@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rtpipe consistency problems
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ulf Karlsson <karlsson.ulf@domain.hid>
Cc: xenomai@xenomai.org

Ulf Karlsson wrote:
> Hi,
> 
>> I can't reproduce this issue here, on the very same kernel/xenomai
>> combo. Looking at the pipe code, a closing regular Linux side
>> (linux-pipe) explicitly flushes the real-time output queue, so I just
>> don't get how any lingering data could be delivered across a pipe close.
>> Weird.
>>
>> Could you send your .config? TIA,
> 
> I have attached my .config-file.
> 

I need to run this testcase on a SMP then. Ok, I'll have a look at this.
Thanks for reporting.

-- 
Philippe.

