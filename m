MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <4A3235BF.5090201@domain.hid>
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid> 
	<200906121148.37732.smolorz@domain.hid>
	<4A3235BF.5090201@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Fri, 12 Jun 2009 13:14:59 +0200
Message-ID: <634c78ce0906120414j70a8a7cav49ef09cb99913ea5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
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

On Fri, Jun 12, 2009 at 13:02, Jan Kiszka<jan.kiszka@domain.hid> wrote:
> Sebastian Smolorz wrote:
>> Peter Soetens wrote:
>>> I'm looking for a more agile way to run my unit tests (and build farm)
>>> on a Xenomai system, without running them directly my development
>>> system (nor rebooting to a Xenomai patched kernel). I was hoping that
>>> a virtualisation solution would do the trick. Does anyone have
>>> experience with running a Xenomai patched kernel + applicaiton in
>>> vmware or another virtualisation package ?
>>>
>>
>> Xenomai runs perfectly inside qemu, without real-time guarantees, of course.
>>
>
> Most of the time we are developing on and for Xenomai inside qemu-kvm,
> often using '-smp 2' (or more) and an SMP host so that the more
> interesting races are triggered. In contrast to other hypervisors, this
> offers the chance to do source-level kernel debugging, also when the
> target hopelessly locked up deep inside I-pipe - situations that are
> almost undebugable on real x86 hardware.
>
> For sure, you don't get reasonable latencies this way (though evaluating
> kvm under -rt /wrt soft-rt is on my to-do list for the next weeks), but
> a lot of testing does not require this anyway. Moreover, qemu/kvm
> cleanly integrates with Linux, thus can easily be scripted. If you plan
> to set up some test farm, you may also want to have a look at
> kvm-autotest (currently under merge into autotest).

Thank you for your answers !

Peter

