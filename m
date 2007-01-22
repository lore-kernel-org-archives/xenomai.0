Message-ID: <45B4ACA2.1090202@domain.hid>
Date: Mon, 22 Jan 2007 13:22:58 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] weired behaviour around userspace interrupts
References: <45B495F9.6090808@domain.hid> <45B4A1CF.8090304@domain.hid>
In-Reply-To: <45B4A1CF.8090304@domain.hid>
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

Jan Kiszka schrieb:
> Stephan Zimmermann wrote:
>> Hello all,
>> I guess I found some weired memory bug in Xenomai's (userspace?)
>> interrupt handling. When I run the attached testprogram (or another
>> program using userspace interrupt's) it happens that 'cat
>> /proc/xenomai/irq' delivers the following output:
> 
> Which Xenomai version? We recently fixed some maybe related issues, both
> in trunk and the v2.3.x branch. Please give one of them a try as well.

Sorry, forgot to tell you about the versions I use...
I am using Xenomai 2.3 (from Download area / stable, the version from 
December 26.). I guess I need to use svn to access newer versions? I 
will checkout and run some tests now and write again later.

Stepahn

> 
> Jan
> 


