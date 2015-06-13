MIME-Version: 1.0
Date: Sat, 13 Jun 2015 13:15:47 -0700
Message-ID: <CAO8ajWdaJFqnAqYM4rjZEse3j8gmUkOk5tZN_8DZrqNPadmx8w@mail.gmail.com>
From: Sean Machin <smachin1000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] How to build Xenomai 3 for TI AM3352 3.2.0 kernel based
	system?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

I'm very interested in trying out Xenomai on my custom ARM HF Linux
system.  This system has been designed using the 3.2 Linux kernel, with
vendor patches provided by TI.  The system is stable, and working well.

After downloading the latest Xenomai code from git, I went to try and
re-build the existing kernel with Xenomai.  I was going to run this command:

scripts/prepare-kernel.sh
--linux=~/src/kernel/cortex/linux-3.2.0-psp05.06.00.00
--ipipe=~/xenomai-3/kernel/cobalt/arch/arm/patches/xxx --arch=arm

But I can't find a patch file for my 3.2.0 kernel.  I also looked in
http://download.gna.org/adeos/patches/v3.x/arm/older/ but can't find one
their either.

How can I get Xenomai to work for my system?  Upgrading our system to a
newer kernel would be a lot of work and what we have now is stable and
working well.

Thank you.
Sean
