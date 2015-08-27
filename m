Message-ID: <55DEB70B.3080007@free.fr>
Date: Thu, 27 Aug 2015 09:06:51 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <55DC2940.90805@free.fr> <55DC772F.7050505@xenomai.org>
In-Reply-To: <55DC772F.7050505@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] killall can not kill xenomai programs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 25/08/2015 16:09, Philippe Gerum wrote:
> On 08/25/2015 10:37 AM, Stéphane ANCELOT wrote:
>> Hi,
>>
>> killall is not working with xenomai programs.
>> killall uses "short" process name, we can see it in /proc/<pid>/stat
>> (second item).
>> unfortunately all processes name have for short name "main", and thus it
>> does not work.
>>
>> Hope this helps to solve the problem.
>>
> This should help:
>
> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=70700428810333bf60aef7a26d8a3f7f2a9ee949
>
It did.
Thanks

