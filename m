Message-ID: <5057653E.70600@xenomai.org>
Date: Mon, 17 Sep 2012 20:00:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <f4e484caea0dc89aaa132406e82ac5ae@theropers.us>
	<70283B31-48C9-4753-A073-993507CF0A96@kabelmail.de>
	<5051E332.8090505@xenomai.org>
	<CAMpYrwA+-Rhr=MvA2sLXFgHp0o7fseukeaoFDhO6Xej-VUjF_A@mail.gmail.com>
	<5D11119A-DE48-4041-843F-DFACB8D4E233@kabelmail.de>
	<5057164B.40209@xenomai.org>
	<82C3ADE5-EE56-4579-B5C3-BB5B1D527699@kabelmail.de>
In-Reply-To: <82C3ADE5-EE56-4579-B5C3-BB5B1D527699@kabelmail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai on Beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org, adam.r.roper@gmail.com

On 09/17/2012 04:43 PM, Stephan Kappertz wrote:

>> On 09/17/2012 02:14 PM, Stephan Kappertz wrote:
>>>> Dear all,
>>>>=20
>>>>>> I am interested in getting Xenomai working on the
>>>>>> Beaglebone but I have no previous experience with Xenomai.
>>>>>> I would greatly appreciate it if you would be willing to
>>>>>> share your source code.
>>>>=20
>>>> I would be very interested in it too as I am in the exactly
>>>> same case here. I am also new to xenomai and I would want to
>>>> test it in a beaglebone.
>>>>=20
>>>>> On 13 September 2012 15:44, Gilles Chanteperdrix wrote: We
>>>>> could distribute this work with Xenomai sources,
>>>>=20
>>>> That would be awesome.
>>>>=20
>>>>> On 09/13/2012 03:31 PM, Stephan Kappertz wrote: I can provide
>>>>> a combined patchfile against the vanilla 3.2.21 kernel
>>>>=20
>>>> That would be great too.
>>>>=20
>>>>> On 09/13/2012 03:31 PM, Stephan Kappertz wrote: that
>>>>> includes both the AM335x support as provided by Koen Kois git
>>>>> On 07/12/2012 09:54 PM, Stephan Kappertz wrote: I am using
>>>>> the slightly patched kernel from linux-omap
>>>>=20
>>>> In the meanwhile, could you tell us what seems to be the best=20
>>>> kernel tree to get xenomai working in the beaglebone? I can't
>>>> find the git repo you talk about.
>>>>=20
>>>> Thanks,
>>>>=20
>>>> Gdalbeniz
>>>=20
>>> The problem with an post patch is that it needs to be updated
>>> for every updated ipipe patch=E2=80=A6
>>=20
>> The point is that most of the time, you do not need to update it.
>> If you integrate the I-pipe patch in your patch, then it is sure,
>> you need to re-release the patch after every release of the I-pipe
>> patch.
>>=20
>>>=20
>>> What I could do now is creating a post-patch to the the kernel
>>> after applying the original ipipe-core-3.2.21-arm.patch to the
>>> vanilla kernel. I did not update to ipipe-core-3.2.21-arm-1.patch
>>> though. Gilles, do you have an incremental patch available that I
>>> can apply after the original patch? Making that patch apply
>>> correctly would possibly be less effort than starting with the
>>> full patch again.
>>=20
>> I do not understand what you mean. I was talking about a pre and
>> post patch, not of a post patch only.
>>=20
>>=20
>> -- Gilles.
>>=20
>=20
> Ok. How would I create such a pre-patch? Basically I would have to
> patch the Koen Koi sources so that the ipipe patch applies
> successfully. Which means that I have to make them "look like" the
> vanilla kernel. Sounds like a huge effort given that I had to change
> the ipipe patch at around 50 places to get it apply successfully. Or
> am I missing something?


The way I do it:

keep the branch which works preciously, it should not be changed.

Checkout a temporary branch from the vendor branch (that would be what
you call the "Koen Koi sources").
Try and apply the I-pipe patch, see all files conflicting. The
pre-patch is the reverse diff between the files in the vanilla kernel,
and the files conflicting in the vendor branch.
Generate the pre-patch.
git reset --hard
git clean -df (beware this erases all files non commited in git, so do
not do that if you keep precious files not under git control)
Apply the pre-patch.
Apply the I-pipe patch.

The post-patch is the difference between the current contents of your
working directory and the contents of the precious branch that works.
You may want to add all files and commit in the temporary branch to be
able to generate the post patch with "git diff".

--=20
                                                                Gilles.


