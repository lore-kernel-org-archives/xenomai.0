Message-ID: <5549E4F4.7030507@free.fr>
Date: Wed, 06 May 2015 11:55:00 +0200
From: =?windows-1252?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
MIME-Version: 1.0
References: <553FAC36.3050803@free.fr> <553FC281.70308@xenomai.org>
 <5541D505.2000109@free.fr> <5541E930.30000@xenomai.org>
 <5542205E.5080302@free.fr> <5548C7A4.5030309@free.fr>
 <5549D733.90702@xenomai.org>
In-Reply-To: <5549D733.90702@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai 3.0rc4 rt_heap_alloc replies with timeout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

right. This is fixed using create size >=3D 2048 bytes.


On 06/05/2015 10:56, Philippe Gerum wrote:
> On 05/05/2015 03:37 PM, St=E9phane ANCELOT wrote:
>> Hi,
>> unfortunately, There is something wrong for unknown reason using these
>> functions.
>>
>> I made a simple regression program that only create heaps and allocates
>> area.
>>
>> At line 190 of the file, depending on the size value of the heap, the
>> program works or not.
>> This looks like corrupted memory problem...
>>
> The API tells you what happens, it's just that you did not pay attention
> to return codes:
>
> 	flags =3D H_FIFO ;
> 	size =3D 36800;
> 	size =3D 824; // size =3D 824 is failing but changing size to 3200 rocks=
 ...
> 	ret =3D rt_heap_create(&heap2, "config", size, flags);
>
> This returns -EINVAL, which is documented for rt_heap_create() as:
>
>   * - -EINVAL is returned if @a mode is invalid, or @a heapsz is not in
>   * the range [2k..2Gb].
>
> Besides, your test code never deletes the heaps it creates, before
> overwriting the same heap descriptor with the next call to
> rt_heap_create(). Hopefully your application does not do that.
>
> I'm unsure to understand your reasoning about memory corruption.
>


