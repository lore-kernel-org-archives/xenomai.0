Message-ID: <46D53C61.3060203@domain.hid>
Date: Wed, 29 Aug 2007 12:29:05 +0300
From: Ravid Baruch Naali <ravidbn@domain.hid>
MIME-Version: 1.0
References: <46D52231.9040309@domain.hid> <46D530AB.5080306@domain.hid>
In-Reply-To: <46D530AB.5080306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Newbies developer instructions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Thanks Jan,


I'm working on an academic course which I will teach next semester on
Real Time system, in which I will bring both VxWorks and Xenomai as Hard
RT systems as an example.

Therefore it will be only natural for me to work on porting some
examples to VxWorks skin at first.

My plan is to implement the same operation in few methods:

- Using VxWorks skin

- Creating a driver (RTDM)

- Using POSIX API

Then document the Functions flow from the skin/RTDM calls down to the HAL=
.


Nevertheless,

_*Paul*_,  If I can assist you with the Xenomai LiveCD please contact me
and I will be happy to help.


As for the test suite I plan to give it as a project to one of my
students (What do you think?).


As soon as I'll fill


Jan Kiszka wrote:

> Ravid Baruch Naali wrote:
>  =20
>> Hello Xenomai-core mailing list,
>>
>>
>> I'm eager to contribute to the Xenomai project, but since I could not
>> find any opened bugs or a detailed task list apart from:
>>
>> http://www.xenomai.org/index.php/TaskMarket
>>
>> I was wondering if there is way for newbies like me to get involved?
>>
>> If any of you can send me a pointer to where should i begin, I will be
>> more then greatful.
>>    =20
>
> =DCber-cool - someone looking for work! :)
>
> There are a thousand things to do. The most productive things are likel=
y
> those you stumble over when using Xenomai in your project. What is not
> working? What could be solved better or should be added? Also: What
> features should be checked against regressions while the development
> advances (more automatic test cases - very important!)?
>
> Besides this, here are some more potential points to start with:
>
>  o https://mail.gna.org/public/xenomai-core/2007-08/msg00017.html :)
>
>  o Write more examples/tutorials for your favourite skin (see examples
>    repos in SVN).
>
>  o Check the code against its (doxygen) documentation - everything stil=
l
>    up-to-date? Something yet undocumented?
>
>  o Work with Paul Corner (paul_c@domain.hid) on some regularly updated
>    Xenomai LiveCD (I guess he would be happy about help).
>
>  o Enhance the testsuite / test script to collect more data, and
>    specifically to evaluate the data more systematically (up to
>    re-creating something like http://issaris.org/rtai/summary.php). To
>    start with: I once had the idea to create some statistics collection
>    library for the testsuite so that all tests could use the same
>    infrastructure to process/visualise benchmark results.
>
>  o ... (things I forgot)
>
> Jan
>
>  =20


--=20
Ravid Baruch Naali
ravidbn@domain.hid
+972 4 6732729
+972 52 5830021


