Message-ID: <53130898.20104@web.de>
Date: Sun, 02 Mar 2014 11:31:52 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <20140301175753.EEF35200EA@smtp.hushmail.com>
 <20140301215301.GS17765@csclub.uwaterloo.ca>
In-Reply-To: <20140301215301.GS17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] AVX Support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, subscribe010304@hushmail.com
Cc: xenomai@xenomai.org

On 2014-03-01 22:53, Lennart Sorensen wrote:
> On Sat, Mar 01, 2014 at 06:57:53PM +0100, subscribe010304@hushmail.com wr=
ote:
>> in order to find out if Xenomai were an appropriate real-time developer =
framework for our design
>> task I am trying to collect some first information about it.
>> I read the documentation that is provided on the Xenomai web pages but I=
 could not find any
>> information about AVX support on x86_64 target platforms.
>> The wikipedia entry on AVX does not list Xenomai under operating system =
support.
>> Isn't AVX supported by Xenomai?
> =

> I don't see what xeonmai has to do with it.  As far sa I can tell AVX
> are just some new instructions.  It adds no new registers or cpu modes,
> so as for as the OS or xenomai is concerned, nothing has changed.
> =

> I can't see any reason it shouldn't work fine.

AVX requires a different approach to save/retore the "FPU" context on
task switches. We added this to ensure AVX compatibility (and speed up
switches as well). switchtest is actually stressing this. So, yes, it
should work fine. No guarantees on AVX2, though, this wasn't explored yet.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140302/a75fe98=
0/attachment.sig>
