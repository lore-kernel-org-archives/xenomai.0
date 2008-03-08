Message-ID: <47D2D10E.2050501@domain.hid>
Date: Sat, 08 Mar 2008 18:46:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47CFBB2E.3010700@domain.hid> <47CFBE53.4010707@domain.hid>
	<47D01673.8030909@domain.hid>
In-Reply-To: <47D01673.8030909@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Need help with pipes
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent BESSARD <laurent.bessard@domain.hid>
Cc: xenomai@xenomai.org

Laurent BESSARD wrote:
> Philippe Gerum a =E9crit :
>> Laurent BESSARD wrote:
>> =20
>>> Hello everybody,
>>>
>>> I'm using Xenomai for realtime developments for a couple of time. I have
>>> written a program using pipes for Xenomai 2.1.0 and a 2.6.15 Linux
>>> kernel compiled with Xenomai support. All worked or seemed to work fine.
>>>
>>> Recently, I decided to upgrade my system to Xenomai 2.4.1 and a 2.6.23
>>> Linux kernel. But during my program execution, I get a kernel
>>> segmentation fault while I try to delete the pipe. After having test any
>>> possibility of problem while deleting pipe, I finally find that just
>>> creating and then deleting a pipe causes a kernel segmentation fault.
>>>
>>> Now I don't know where my problem is located:
>>>   - There is something I'm doing wrong when I use pipes.
>>>   - I have mis-installed Xenomai on my system.
>>>   - It is a known problem with the version of Xenomai I installed.
>>>
>>> I attached a sample of code that causes my problem.
>>>

Try this one:
http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.24-x86-2.0-0=
4.patch

--=20
Philippe.

