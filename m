References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <6a4b3f9b-22e0-a916-3c53-5cfefb071937@numalliance.com>
 <9430436b-de41-43e3-02f4-a93592d57793@xenomai.org>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <b28de02f-2e65-7f2a-fc30-645b41d838f0@numalliance.com>
Date: Fri, 1 Dec 2017 16:09:50 +0100
MIME-Version: 1.0
In-Reply-To: <9430436b-de41-43e3-02f4-a93592d57793@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org



Le 25/11/2017 =C3=A0 21:32, Philippe Gerum a =C3=A9crit=C2=A0:
> On 11/24/2017 11:46 AM, St=C3=A9phane Ancelot wrote:
>> The xenomai API is not enough documented in order to permit new
>> developer's entry.
> Can you elaborate on what could be done to improve the documentation,
> according to your own experience with it?
It is difficult to understand which version / release to use ?
Difference between what is stable / unstable is not really clear.
I lost many times using some versions, then trying another one, because=20
of some bugs .....
And finally at a moment, in real life, altough you may know=C2=A0 there a=
re=20
some problems in the implementation you are using, you must stick to a=20
version, you have delivery date....


When you read the docs , you are in front of "new" terms : cobalt /=20
mercury, alchemy ... that's a bit confusing mixing everything in the=20
right order. Do I need it, or not ?
what is the right guideline ?
You have to brainstorm yourself to understand what is cobalt, how it is=20
working, the added value .
What will I use ?

next , there are many API (alchemy, cobalt, psos, vxworks ,posix ...),=20
luckily if it works, you change your code and mix api !!!
Many api imply more complexity and=C2=A0 maintenance, are all these API=20
really mandatory ?????


>> Targetting and permitting students to contribute could be a good benef=
it.
>>
> How would you do that?
>
>> Unit tests cases seem mandatory .
>>
> There are (testsuite/smokey), but clearly not enough of them though.
>


