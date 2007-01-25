Message-ID: <cbe23c50701250024g23a1d662ld04499a1019e12b6@domain.hid>
Date: Thu, 25 Jan 2007 09:24:10 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: Re: [Xenomai-help] isolating unwanted mode switch
In-Reply-To: <4080619.1169710201822.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701231448.35285.jweber@domain.hid>
	<200701231627.51851.jweber@domain.hid>
	<b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
	<200701241152.21747.jweber@domain.hid>
	<cbe23c50701241055l5efa3f50p768f7d37d2d7cb8@domain.hid>
	<4080619.1169710201822.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

2007/1/25, M. Koehrer <mathias_koehrer@domain.hid>:
> Hi all,
>
> one other issue that comes in my mind:
> The usage of C++ in a real time application could be fairly difficult, as
> C++ might create temporary objects (using new(), which will probably
> be realized with a malloc()). It is hard to identify what's happening with
> the memory without an excellent understanding of the compiler.

I think you may try to replace (or overload for your class) operator new/delete
http://www.cantrip.org/wave12.html in order to catch such problem.

> That's why I try to avoid C++ and real time application and use plain C...
> I do not know Jeff's application, however I think it could be worth to
> have a look on that.

But this choice is easier and I would go for it too :))

-- 
Erk

