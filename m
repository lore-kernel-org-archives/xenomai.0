MIME-Version: 1.0
In-Reply-To: <20150313171211.GH1497@hermes.click-hack.org>
References: <20150226102010.GA24003@hermes.click-hack.org>
 <54EF0790.3040607@triphase.com> <54F07AC2.6000902@triphase.com>
 <54F0D46F.1070006@siemens.com> <54F56C9C.6080507@siemens.com>
 <CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>
 <54FDB495.3060303@triphase.com> <5501FC89.2040205@siemens.com>
 <20150313163431.GE1497@hermes.click-hack.org>
 <550319B3.1050902@siemens.com>
 <20150313171211.GH1497@hermes.click-hack.org>
Date: Thu, 2 Apr 2015 20:47:30 +0200
Message-ID: <CAPRPZsD4503Yc92d=e0jqR8HtLiV8rXo_vA2e5ea5V_gyCTOzA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

I've been testing for two weeks now and the system has crashed three
more times under dohell load. Two with 3.14.28, the other with 3.16.0.
Time to crash varied between 3 hours and 90 hours.

The scenario is always the same: one CPU (has already been any of the
4) gets stuck and the others start reporting soft lockups. The trouble
is: I've been unable to get hold of a stack trace of the hardlocked
CPU. SysRq L does not work and the CPU does not respond to the NMIs it
is given from the softlocked CPUs. I also enabled hardlockup_panic to
make sure I get all stack traces but to no avail.

Does anyone know another trick to possibly get the backtrace from this CPU ?

Thanks,


J.


2015-03-13 18:12 GMT+01:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On Fri, Mar 13, 2015 at 06:09:07PM +0100, Jan Kiszka wrote:
>> On 2015-03-13 17:34, Gilles Chanteperdrix wrote:
>> > On Thu, Mar 12, 2015 at 09:52:25PM +0100, Jan Kiszka wrote:
>> >> Am 2015-03-09 um 15:56 schrieb Niels Wellens:
>> >>> Hi,
>> >>>
>> >>> We have a few updates on the lockup's that we observed.
>> >>>
>> >>> Jeroen did a dohell test on his unpatched 3.14.28 kernel and he didn't
>> >>> experienced any problems, the system was still working as expected after
>> >>> more than 100 hours of operation.
>> >>>
>> >>> In the meanwhile, I did some further tests on my 3.16.0 ipipe kernel. I
>> >>> disabled some services (gdm3, rtkit-daemon, smbd and nmbd) and after 90
>> >>> hours of operation (latency + dohell) everything was still working
>> >>> flawlessly.  Afterwards I enabled gdm3 and rtkit-daemon services again
>> >>> and the lockup didn't occur for another 25hours (test stopped due to
>> >>> kernel panic while porting one of my RTDM drivers to xeno 3 ;-) ).
>> >>> Then I continued my test where it stopped (only smbd and nmbd services
>> >>> disabled, latency + dohell running) and it was running perfectly for 114
>> >>> hours, then I enabled smbd and nmbd again and after 3 hours the hard
>> >>> lockup occurred again:
>> >>>
>> >>> Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Initializing cgroup
>> >>> subsys cpuset
>> >>> Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Initializing cgroup
>> >>> subsys cpu
>> >>> Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Initializing cgroup
>> >>> subsys cpuacct
>> >>> Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Linux version
>> >>> 3.16.0-ipipe-v0+ (triphase@dev-x10sae) (gcc version 4.9.1 (Debian
>> >>> 4.9.1-19) ) #1 SMP Thu Feb 26 12:15:32 CET 2015
>> >>> Mar  4 16:35:47 dev-x10sae kernel: [    0.000000] Command line:
>> >>> BOOT_IMAGE=/boot/vmlinuz-3.16.0-ipipe-v0+
>> >>> root=UUID=fc8ecefa-fc73-487f-a045-cffa99c38a11 ro quiet
>> >>> ...
>> >>> Mar  9 07:35:02 dev-x10sae anacron[26338]: Job `cron.daily' terminated
>> >>> Mar  9 07:35:02 dev-x10sae anacron[26338]: Normal exit (1 job run)
>> >>> Mar  9 08:17:01 dev-x10sae CRON[25670]: (root) CMD (   cd / && run-parts
>> >>> --report /etc/cron.hourly)
>> >>> Mar  9 08:30:17 dev-x10sae gnome-session[2611]:
>> >>> (gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 4961 was not
>> >>> found when attempting to remove it
>> >>> Mar  9 09:17:01 dev-x10sae CRON[20303]: (root) CMD (   cd / && run-parts
>> >>> --report /etc/cron.hourly)
>> >>> Mar  9 09:30:17 dev-x10sae gnome-session[2611]:
>> >>> (gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 4987 was not
>> >>> found when attempting to remove it
>> >>> Mar  9 10:17:01 dev-x10sae CRON[14576]: (root) CMD (   cd / && run-parts
>> >>> --report /etc/cron.hourly)
>> >>> Mar  9 10:30:17 dev-x10sae gnome-session[2611]:
>> >>> (gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5017 was not
>> >>> found when attempting to remove it
>> >>> Mar  9 11:17:01 dev-x10sae CRON[30596]: (root) CMD (   cd / && run-parts
>> >>> --report /etc/cron.hourly)
>> >>> Mar  9 11:20:51 dev-x10sae smbd[11478]: Starting SMB/CIFS daemon: smbd.
>> >>> Mar  9 11:20:56 dev-x10sae nmbd[24483]: Starting NetBIOS name server: nmbd.
>> >>> Mar  9 11:30:17 dev-x10sae gnome-session[2611]:
>> >>> (gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5043 was not
>> >>> found when attempting to remove it
>> >>> Mar  9 12:17:01 dev-x10sae CRON[6674]: (root) CMD (   cd / && run-parts
>> >>> --report /etc/cron.hourly)
>> >>> Mar  9 12:30:17 dev-x10sae gnome-session[2611]:
>> >>> (gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5075 was not
>> >>> found when attempting to remove it
>> >>> Mar  9 13:17:01 dev-x10sae CRON[6801]: (root) CMD (   cd / && run-parts
>> >>> --report /etc/cron.hourly)
>> >>> Mar  9 13:30:17 dev-x10sae gnome-session[2611]:
>> >>> (gnome-settings-daemon:2675): GLib-CRITICAL **: Source ID 5464 was not
>> >>> found when attempting to remove it
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422579.748685] Watchdog detected
>> >>> hard LOCKUP on cpu 5
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196923] INFO: rcu_sched
>> >>> self-detected stall on CPUINFO: rcu_sched self-detected stall on
>> >>> CPUINFO: rcu_sched self-detected stall on CPU {
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196927]  {
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196928]  2
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196928]  1
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196929] }
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196930] }
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196930]  (t=5250 jiffies
>> >>> g=21756356 c=21756355 q=15258)
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196931]  (t=5250 jiffies
>> >>> g=21756356 c=21756355 q=15258)
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.196932] sending NMI to all CPUs:
>> >>> Mar  9 14:02:54 dev-x10sae kernel: [422583.197098]  { 6}  (t=5250
>> >>> jiffies g=21756356 c=21756355 q=15258)
>> >>>
>> >>> Is it possible that the kernel part of Samba (CIFS?) is holding the page
>> >>> allocation spinlock that Jan has mentioned?
>> >>
>> >> Well, we need to see the backtraces to know more. But even then the
>> >> question would what could cause this. If it is some issue in I-pipe or
>> >> Xenomai, or if this is a generic issue that would see after a while with
>> >> an unpatched kernel as well.
>> >
>> > Well, to rule out any already fixed mainline issue, maybe it would
>> > make sense to upgrade to the latest in the 3.14 series? This is a
>> > double edged sword, since it has a risk to introduce regressions,
>> > but maybe worth a try.
>>
>> If the step from .28 to .33 should start to expose the issue on 3.14 as
>> well, we would have a more limited space to search for the reason. But I
>> suspect it won't make a difference.
>
> Well there were some fixes around .31 or .32, which definitely
> resolved some NFS stalls on my NFS server (which is not patched with
> I-pipe).
>
> --
>                                             Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

