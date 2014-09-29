From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Mon, 29 Sep 2014 21:23:19 +0000
Message-ID: <D04F37C7.19109%shartmann@cnt.canon.com>
References: <5423F8E3.3060006@xenomai.org>
 <D04EDD17.190CB%shartmann@cnt.canon.com> <542976B2.30804@xenomai.org>
 <D04F0E52.190EE%shartmann@cnt.canon.com> <5429CAF1.9070603@xenomai.org>
In-Reply-To: <5429CAF1.9070603@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A15F3AB11D4C347AC553DC1A68F167E@mex06.mlsrvr.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>



On 9/29/14 4:11 PM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

>On 09/29/2014 08:44 PM, Steve Hartmann wrote:
>> On 9/29/14 10:11 AM, "Gilles Chanteperdrix"
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>=20
>>> On 09/29/2014 04:59 PM, Steve Hartmann wrote:
>>>> Just FYI, When following the directions to build debian packages, the
>>>> debian packages are named with 2.6.3 filenames rather than the
>>>>expected
>>>> 2.6.4.
>>>
>>> Yes, we are not going to update the instructions every time we release
>>> an new version. Which is why the instructions say:
>>>
>>> This howto was written for Xenomai 2.6.3, please use the latest stable
>>> Xenomai release and adapt the version numbers accordingly.
>>>
>>> Then, when building the kernel:
>>>
>>> We use Xenomai 2.6.3 and Linux 3.10.32 on x86 in the following example,
>>> please adapt it to the versions and architectures you want to install.
>>>
>>> Do you see a way to make the instructions more clear?
>>>
>>> --=20
>>>                                                                Gilles.
>>=20
>> Gilles,
>>=20
>> OK, you are right, it is my fault.  It was the word-wrap in the
>> instructions that got me screwed up:
>>=20
>> Create a new debian changelog entry:
>> xenomai-2.6.3$ DEBEMAIL=3D"your@email" DEBFULLNAME=3D"Your Name" debchan=
ge
>>-v
>> 2.6.3 Release 2.6.3
>>=20
>> In my browser looks like:
>>=20
>> Create a new debian changelog entry:
>> xenomai-2.6.3$ DEBEMAIL=3D"your@email" DEBFULLNAME=3D"Your Name" debchan=
ge -
>> v 2.6.3 Release 2.6.3
>>=20
>> So I left everything off the second line, which was actually a
>> continuation of the first line.
>
>I tried and improve the visibility of shell command lines by changing
>the style they use, the line breaks are also now explicit with a \
>
>--=20
>                                                                Gilles.

Nice work Gilles - that is much easier to read!

Thanks,

Steven


