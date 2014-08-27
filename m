Message-ID: <53FE2A10.6090000@xenomai.org>
Date: Wed, 27 Aug 2014 20:57:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtdznD6Tgu++e99cNmYT3TA0pjyNBqoR9k2kkn_E5Lab3Q@mail.gmail.com>	<53FC6F4B.7080107@xenomai.org>	<1409053253.79352.YahooMailNeo@web142601.mail.bf1.yahoo.com>	<53FC98FF.4050006@xenomai.org>
 <CAKKWdtf29M31YWGn-f5jntHi4R18sJpR3SrNXh2AmA_-BLo-Bg@mail.gmail.com>
In-Reply-To: <CAKKWdtf29M31YWGn-f5jntHi4R18sJpR3SrNXh2AmA_-BLo-Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] trigger!!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 08/27/2014 04:47 PM, ali hagigat wrote:
> Sorry to ask it again but the file, /proc/ipipe/trace/trigger, can be
> written only once.

>From looking at the code, I do not think so. It seems to me you can
write to the file as many times as you want.

> The documentation says:
> "Write an empty string to disable the trigger, "
> As far as I tested,  writing empty string to the file , trigger,
> returns with error

The code agrees with this conclusion.

> and frozen log continue to become updated
> After the initial write I can not write to this file any more even if I do:
> echo 0 > /proc/ipipe/trace/enable
> 

Why not trying and writing the name of a function which has no chance of
being triggered, such as "start_kernel" ?

-- 
                                                                Gilles.

