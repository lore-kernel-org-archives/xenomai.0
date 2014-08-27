MIME-Version: 1.0
In-Reply-To: <53FC98FF.4050006@xenomai.org>
References: <CAKKWdtdznD6Tgu++e99cNmYT3TA0pjyNBqoR9k2kkn_E5Lab3Q@mail.gmail.com>
 <53FC6F4B.7080107@xenomai.org>
 <1409053253.79352.YahooMailNeo@web142601.mail.bf1.yahoo.com>
 <53FC98FF.4050006@xenomai.org>
Date: Wed, 27 Aug 2014 19:17:14 +0430
Message-ID: <CAKKWdtf29M31YWGn-f5jntHi4R18sJpR3SrNXh2AmA_-BLo-Bg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] trigger!!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Sorry to ask it again but the file, /proc/ipipe/trace/trigger, can be
written only once. The documentation says:
"Write an empty string to disable the trigger, "
As far as I tested,  writing empty string to the file , trigger,
returns with error and frozen log continue to become updated
After the initial write I can not write to this file any more even if I do:
echo 0 > /proc/ipipe/trace/enable

