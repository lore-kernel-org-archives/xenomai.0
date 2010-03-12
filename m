Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B9AD0DE.4020103@domain.hid>
Date: Sat, 13 Mar 2010 00:40:14 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid>
In-Reply-To: <4B97BA0C.9000702@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Sorry for answering so late. I took a few days off far from any internet
connection.

It seems you sent many mails related with Analogy. Many thanks for your
interest. I have not read all of them yet. However, I am beginning by
this one (which seems unanswered). The answer is quick and easy :)

Daniele Nicolodi wrote:
> Hello. I'm looking into the analogy cmd_write example.
> 
> I'm not sure I understand the reason for the rt_task_set_mode() function
> call into the data acquisition loop (lines 413 or 464 in the code
> shipped with xenomai 2.5.1).
> 
> I do not understand why we have to set the primary mode at every
> iteration, when we set it before for the task (line 380).
> 
> Is it because the dump_function() uses system calls that can make the
> task to switch to secondary mode, or there is a deeper reason I'm missing?
> 
You are right. The dumping routine triggers a switch to secondary mode.
That is why, the program switches back to primary mode after.

Almost all the Analogy programs (cmd_read, cmd_write, insn_read,
insn_write, insn_bits) are just demonstration examples. That is why the
code is so linear, lengthy and repetitive. Furthermore, the code was not
meant to be efficient. I just wanted to test the RT and NRT entries.

By the way, I started to improve them. One change (which is still
missing) is the use of rtdk.

> Thanks. Cheers,

Alexis.

