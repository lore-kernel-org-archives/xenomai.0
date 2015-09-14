MIME-Version: 1.0
In-Reply-To: <20150914074527.GA17701@hermes.click-hack.org>
References: <20150914062111.GE4195@hermes.click-hack.org>
 <CAPRPZsB5PCNmrrqfE4u8E23JEL=_aRhTPS=kUHtEZwpRPjhagw@mail.gmail.com>
 <20150914074527.GA17701@hermes.click-hack.org>
Date: Mon, 14 Sep 2015 10:09:24 +0200
Message-ID: <CAPRPZsADxhfhhGOP_9rE__yR-Bb_QgJzyGn4K-kmgHvjO=3WjA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] SMI count polling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

> Well, in that case you can install msr-tools:
> https://01.org/msr-tools

Thanks for pointing out. I didn't know these existed. Always used
direct msr device access.

> And run:
> rdmsr 0x34

> Of course, this requires CONFIG_X86_MSR in the kernel configuration,
> which putting the count in /proc would avoid. But still, this would
> be a bit redundant.

True, but given the frequent usage of SMI on many mainboards, their
serious impact on realtime performance and SMIs being designed to
remain undetected, a convenience function wouldn't hurt. Especially
since I have the impression that it's an important stumbling stone for
first-time users.

Also, the total count would be useful since you would have to run
rdmsr -p <CPU> 0x34 for every CPU in the system. I believe it's
important to check for SMI occurrence on non-realtime CPUs as well,
since I understand any of them might be handling them eventually ?

Just a thought,


Jeroen.

