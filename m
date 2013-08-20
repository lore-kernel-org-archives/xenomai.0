Message-ID: <5213EFBA.90608@steinkuehler.net>
Date: Tue, 20 Aug 2013 17:37:46 -0500
From: Charles Steinkuehler <charles@steinkuehler.net>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net> <5213C9AD.2010903@xenomai.org>
	<5213D09E.80103@steinkuehler.net>
In-Reply-To: <5213D09E.80103@steinkuehler.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Building BeagleBone kernel from git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 8/20/2013 3:25 PM, Charles Steinkuehler wrote:
> On 8/20/2013 2:55 PM, Gilles Chanteperdrix wrote:
>> You want the I-pipe patch. To generate it, in the I-pipe tree, try:
>>
>> ./scripts/ipipe/genpatches.sh
>>
>> You should then find a file ipipe-core-3.8.13-arm-1.patch which you
>> can try and apply to another tree, possibly additionally patching with
>> pre and post patches (respectively before and after the I-pipe patch).
> =

> Yep, that sounds like exactly what I want!  Thanks for the help!!
> =

> I'll report back if I run into more issues or if everything works out
> OK.  I am trying to integrate the xenomai patches into a customized
> version of Robert C. Nelson's BeagleBone kernel build scripts:

Problem #1 (solved):
The genpatches.sh script calls awk, but seems to be incompatible with
the stock awk (mawk) on my Debian Wheezy system.  I was getting errors
on all the match ($0, ...) lines until I installed gawk:

charles@machinekit:~/linux-dev/XENOMAI$ ./scripts/ipipe/genpatches.sh
reference: v3.8.13, kernel version: 3.8.13
awk: line 40: syntax error at or near ,
awk: line 48: syntax error at or near ,
awk: line 76: syntax error at or near ,

charles@machinekit:~/linux-dev/XENOMAI$ sudo aptitude install gawk

charles@machinekit:~/linux-dev/XENOMAI$ ./scripts/ipipe/genpatches.sh
reference: v3.8.13, kernel version: 3.8.13
ipipe-core-3.8.13-powerpc-1.patch
ipipe-core-3.8.13-arm-1.patch
ipipe-core-3.8.13-x86-1.patch
ipipe-core-3.8.13-blackfin-1.patch

...continuing on down the yellow brick road...
:)

-- =

Charles Steinkuehler
charles@steinkuehler.net

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130820/3414698=
5/attachment.pgp>
