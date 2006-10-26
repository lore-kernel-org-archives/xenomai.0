Message-ID: <45410441.2070000@domain.hid>
Date: Thu, 26 Oct 2006 13:53:53 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid>
	<453FC4C0.5070105@domain.hid>	<453FF6AA.6030406@domain.hid>
	<45406FEF.90806@domain.hid>	<4540D998.2090908@domain.hid>
	<4540DACA.2050406@domain.hid> <4540E5E8.9010608@domain.hid>
	<4540E89F.9060603@domain.hid>
In-Reply-To: <4540E89F.9060603@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Jeff Webb wrote:
>> If I try to connect to the process after I press the ctrl-c one time, I
>> get:
>>
>> # gdb --pid=2660
>> Attaching to process 2660
>> warning: The current VSYSCALL page code requires an existing excuitable.
>> [sic]
> 
> Then why not trying to provide it?

The machine locks up, so I can't do anything after this point.  Even the machine didn't crash, I don't understand what file it wants me to load with "add-symbol-file-from-memory".  This may be a non-issue, though.  Gilles has sent me some patches off list, and I think he is close to getting the program to clean up properly.  Why my machine behaves differently than other people's, I don't know.

No progress on the FPU/mqueue bug, though.

>> Then the whole machine locks up, and I am forced to reboot.
> 
> That's bad. Is the Xenomai watchdog active (if not, this might be some
> RT thread running wild)?

The watchdog is not enabled.  I will turn it on for the next build.

-Jeff


