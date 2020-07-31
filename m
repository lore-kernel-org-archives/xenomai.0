MIME-Version: 1.0
References: <CAAvDm6a1oRyfTD2gp2PoTwVYenOymG49C3SmBJAUvtTGQykKLg@mail.gmail.com>
In-Reply-To: <CAAvDm6a1oRyfTD2gp2PoTwVYenOymG49C3SmBJAUvtTGQykKLg@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Fri, 31 Jul 2020 18:27:57 +0800
Message-ID: <CAAvDm6aD=PoNG8fMeCyT4zPp9jMsYWiN7_QT2Ei5k_b1jWVCvg@mail.gmail.com>
Subject: Re: malloc and stl container
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan5697@gmx.net
Cc: Lange Norbert <norbert.lange@andritz.com>, xenomai <xenomai@xenomai.org>

Hi, Regards Jan, Norbert
>>    Hello,
>>    i am using xenomai 3.0 on a cobalt x64 smp system with the alchemy
>>    skin.
>>    As far i know dynamic memory allocation can cause a context switch,
>>    which should be preventet.
>>    If i am right,malloc should not cause a CSW anymore at this xenomai
>>    version.
>
>Don't see where you get this from. malloc might not cause a CSW every time,
>but it has the potential to do so at *any* time.

Maybe, you mean MSW, not CSW.

Best Regards
Sunshilong

