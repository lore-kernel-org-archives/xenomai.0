Date: Thu, 16 Apr 2020 02:37:47 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <938058433.19478.1587022667392.JavaMail.zimbra@wolfram.com>
In-Reply-To: <CAGRwck3wJrmihcu06RDKQtOWXLeG8DMVXgV41+dpodnGi4QUZQ@mail.gmail.com>
References: <CAGRwck3wJrmihcu06RDKQtOWXLeG8DMVXgV41+dpodnGi4QUZQ@mail.gmail.com>
Subject: Re: Regarding "hwmatch" error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>
Cc: Abhin pulikkottil <abhin.pulikkottil@svayarobotics.com>



---- Den 16 apr 2020, p=C3=A5 kl 6:18, xenomai xenomai@xenomai.org skrev:

> Hi,

> I have used xenomai - 3.0.5 to patch linux-4.9.38 on ubuntu 18.04. I have
> completed the building process without any errors. When I rebooted to the
> builded OS, I am facing some errors as follows:

> error : can't find command 'hwmatch'

This looks like it's output from GRUB, i.e. before your new kernel is even =
loaded. How did you go about putting your new kernel in your grub config?
(Are you using EFI boot or legacy?)


> Loading Linux 4.9.38

> Loading Initial ramdisk

> because of this error I cannot proceed further. Kindly look into this err=
or
> and help me to resolve this issue.

> Thanks and regards

> Abhin Philip P


Per =C3=96berg=20

