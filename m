Message-ID: <54E37A1F.4020405@siemens.com>
Date: Tue, 17 Feb 2015 18:27:59 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54E22A50.4070106@siemens.com> <54E22D82.9020105@xenomai.org>
 <54E22E5E.7080003@siemens.com> <54E23C6B.2020103@siemens.com>
 <54E240EB.2050904@siemens.com> <54E24672.3000402@xenomai.org>
 <54E24FD8.9020605@siemens.com> <54E354F9.30703@siemens.com>
In-Reply-To: <54E354F9.30703@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] ipipe: fixes for 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2015-02-17 15:49, Jan Kiszka wrote:
> Retested and, although I could have sworn that !CONFIG_IPIPE doesn't
> cause this effect, it does on 3.14.28. And checking CPU features again,
> there is both "hle" and "rtm" - in contrast to a newer 3.18 kernel where
> those are gone (same distro, same hardware).
> 
> So this is not an I-pipe issue, it's something related to the kernel or
> its configuration. Need to study again where the microcode comes from. I
> thought it was pulled from /lib/firmware/somewhere, thus would be shared
> between all kernels on the same rootfs.

Just to close the topic: We had early microcode loading disabled in the
kernel, likely due to some historic reasons (there was a crash once).
That caused systemd to load libpthread before the microcode fix that
disables RTM was loaded. Once the microcode came in, the RTM
instructions suddenly start to cause #UD. Nice. Not sure yet if this
explains the issues in the customer application - we will see later.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

