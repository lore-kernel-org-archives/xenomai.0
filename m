References: <99BAB48E90E86D42AD41F0BCE3225AEB018DE50813@GRZSMS582.andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a00a6566-e5f0-9496-f139-beed6d1a1bad@siemens.com>
Date: Tue, 19 Dec 2017 08:16:10 +0100
MIME-Version: 1.0
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB018DE50813@GRZSMS582.andritz.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Weird behavior during debug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 2017-12-18 15:49, Lange Norbert wrote:
> Same issue with latest ipipe. Threads look like this (when the instance is halted in the debugger).
> Somehow, atleast the RT Tasks will block waiting on a timerfd when one task is in state XT (whatever that means)
> 
> # cat /proc/xenomai/sched/threads
> CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
>   0  0      idle   core       -1   -             R          [ROOT/0]
>   1  0      idle   core       -1   -             R          [ROOT/1]
>   2  0      idle   core       -1   -             R          [ROOT/2]
>   3  0      idle   core       -1   -             R          [ROOT/3]
>   2  264    rt     cobalt     20   -             XT         packetfilter
>   1  279    rt     cobalt     20   -             W          packetfilter
> 

Philippe reverted a number of commits in ipipe-4.9.y some days ago.
Please retry either with the latest version or the last release
(ipipe-core-4.9.51-x86-4).

Jan

>  >-----Original Message-----
>  >From: Lange Norbert
>  >Sent: Montag, 18. Dezember 2017 14:43
>  >To: Xenomai (xenomai@xenomai.org)
>  >Subject: Weird behavior during debug
>  >
>  >Hello,
>  >
>  >I tried debugging a cobalt application, and when I hit a breakpoint most of the
>  >system freezes.
>  >If I run for example top over Serial or SSH, then the display won`t be refreshed
>  >anymore,
>  >A separate program running as RT Task, waiting for an timer-event (occurring
>  >10 times a second) will block aswell.
>  >
>  >So the debug session seems to block a rather big amount of events.
>  >
>  >I am using a 4.9 kernel with ipipe at "x86/ipipe: fix detection of unhandled
>  >faults over the head domain".
>  >Looking at the logs and other threads there seems to be a bigger rework in
>  >progress?
>  >I will retry with master, and report back.
>  >
>  >Kind regards
>  >
>  >Norbert Lange
> 
> ________________________________
> 
> This message and any attachments are solely for the use of the intended recipients. They may contain privileged and/or confidential information or other information protected from disclosure. If you are not an intended recipient, you are hereby notified that you received this email in error and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system.
> 
> ANDRITZ HYDRO GmbH
> 
> 
> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
> 
> Firmensitz/ Registered seat: Wien
> 
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> 
> Firmenbuchnummer/ Company registration: FN 61833 g
> 
> DVR: 0605077
> 
> UID-Nr.: ATU14756806
> 
> 
> Thank You
> ________________________________
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

