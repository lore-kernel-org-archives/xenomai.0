Date: Tue, 08 Jul 2008 10:31:49 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200807081031.2687@domain.hid>
References: 200807071745.31720@domain.hid> <200807071745.31720@domain.hid>
	<48723D5D.6020008@domain.hid>
In-Reply-To: <48723D5D.6020008@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Kernel panic: not syncing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

>> Hello,
>> I'm not sure if I'm not off topic.
>> We use Linux 2.6.24 and Xenomai 2.4.1. Occasionally (once in few days)
we get an kernel panic and I don't know If it's our fault or a problem of
kernel/xenomai/adeos/configuration/hw/...
>> If you have any questions, i'll try to answer them. Any help is
welcome.
>
>It is an I-pipe issue, probably. We have to somewhat forge the register
frame
>passed to the Linux tick handler, since we may delay that call. Some
register
>values the profiling code attempts to dereference to find the preempted
code may
>be wrong in our case.
>
>Could you 1) send back a disassembly of the profile_tick routine in your
kernel
>image, then apply the following patch to check whether it improves the
situation
>as well? TIA,
>

ad 1) I would like to, but i don't know how to do it. If you have a simple guide or a link, I would be grateful.
ad 2) I will apply the patch. But it will take days (or a week) before I could tell, if it helped or not.

Petr


