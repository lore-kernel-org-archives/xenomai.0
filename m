Message-ID: <DUB116-W720717CF2FC03455E3FC46AFFB0@phx.gbl>
From: Fabio Visona <fabioviso@hotmail.com>
Date: Fri, 15 Jun 2012 16:11:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Illegal use of supervisor resource
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


>>
>> Not sure if this issue is related to Xenomai or not=2C however I hope so=
mebody can give me an hint:
>> we are getting an error of the following form from time to time:
>>
>
>This is a I-pipe bug=2C caused by a spurious rescheduling over an IRQ=20
>context (blackfin is a bit special regarding this=2C to say the least).=20
>You may want to check whether 2.6.35.9-1.16-01 fixes the issue.
>
>> Example 1:
>>
>> Illegal use of supervisor resource
>> <5>  - Attempted to use a Supervisor register or instruction from User m=
ode.
>> <5>    Supervisor resources are registers and instructions that are rese=
rved
>> <5>    for Supervisor use: Supervisor only registers=2C all MMRs=2C and =
Supervisor
> <5>    only instructions.

Thank you! Tests done up to now tell Adeos 2.6.35.9-1.16-01 fixes the issue=
. We applied it to kernel 2.6.35.13.

Should we want to try upgrading to kernel 3.0 or later (like in official Bl=
ackfin distributions) in future=2C could you clarify how to patch with Adeo=
s=2C since the latest official patch in Adeos website for Blackfin is 2.6.3=
5.9-1.16-01?
I tried checking your http://git.denx.de/?p=3Dipipe.git=3Ba=3Dsummary but I=
 do not understand if there are patches in there or  kernel sources already=
 patched.
  		 	   		  =
