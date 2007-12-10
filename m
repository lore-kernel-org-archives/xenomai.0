Message-ID: <475D4A31.1080908@domain.hid>
Date: Mon, 10 Dec 2007 15:16:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <c12ec2810712100218s7c93af6drc2ada3ee7644c152@domain.hid>
In-Reply-To: <c12ec2810712100218s7c93af6drc2ada3ee7644c152@domain.hid>
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
> I encounter a problem with rtpipes where the packets are being being
> "locked up" inside the pipe, that is the read(2) call waiting for the
> data does not return, Furthermore, it appears like I lose packets in
> the pipe.
> 
> I have attached a two simple C-programs that demonstrate this behavior.
> 
> The program linux-pipe.c writes increasing integer values to the pipe
> and expects to be able to read the same value back from the pipe,
> while the program xeno-pipe.c reads an integer from the pipe and
> instantly writes the very same value back.
> 
> I am using a 2.6.20.21 kernel together with xenomai 2.4.0.
>

I can't reproduce this issue here, on the very same kernel/xenomai
combo. Looking at the pipe code, a closing regular Linux side
(linux-pipe) explicitly flushes the real-time output queue, so I just
don't get how any lingering data could be delivered across a pipe close.
Weird.

Could you send your .config? TIA,

-- 
Philippe.

