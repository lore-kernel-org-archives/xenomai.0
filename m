References: <20170126155926.594b8e2b@md1em3qc>
 <20170127135222.28440-1-henning.schild@siemens.com>
 <20170127150422.6aef6bfd@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <437e7b70-9681-ac26-38bb-e528ea6a4831@xenomai.org>
Date: Fri, 27 Jan 2017 15:10:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170127150422.6aef6bfd@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] testsuite/switchtest/x86: allow in kernel-FPU
	testing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 01/27/2017 03:04 PM, Henning Schild wrote:
> On Fri, 27 Jan 2017 14:52:22 +0100
> Henning Schild <henning.schild@siemens.com> wrote:
> 
>> Not running the in-kernel FPU tests while Linux might be using the FPU
>> in kernel-mode is a safeguard measure for development versions that
>> might still have issues with FPU context switching. i.e. it prevents
>> data corruption on RAIDs beeing triggered by an FPU Bug.
>> In a bug-free kernel running the switchtest in kernel-mode is not a
>> problem and may be desired for proper test-coverage.
>>
>> This patch introduces a command line option to switchtest to allow
>> overriding the safeguard.
> 
> I am not sure i am happy with this solution either. Actually the test
> should always run as part of the unit tests. It is very valuable and
> skipping it "silently" is a really bad idea.
> If it is really just disabled for when it might mess with your raid on
> the machine you do kernel development on, maybe you should not use
> such a machine for that?
> So i am starting to think the test should run by default and the
> conservative version should be opt-in instead of opt-out.
> 

A conservative version can only be opt-out, otherwise people may run
into damages without knowing, which would defeat the intent of picking
the conservative approach.

I'm still pondering whether this test makes sense in 3.x, given that
official support for running fpu ops over rt threads in kernel space was
dropped for that version. Too much of a mess.

-- 
Philippe.

