Message-ID: <2633dfc352bae3a03b1563c30ec37b47.squirrel@sourcetrek.com>
In-Reply-To: <55B8A5A3.5040000@xenomai.org>
References: <CA+CJOCzk4p0RmpCsYoCQ71Tbckb5Ztj88ORnD2i-sU2jTg115Q@mail.gmail.com>
 <55B8A5A3.5040000@xenomai.org>
Date: Wed, 29 Jul 2015 12:18:37 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Task killed by watchdog after exception #7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


Philippe Gerum wrote:
> On 07/29/2015 10:49 AM, Nicolas SCHURANDO wrote:
>  Would I be right to assume that, when the task gets
>> switched to secondary mode, and because the other tasks are already
>> requiring a lot of cpu time, there is not enough free cpu time to run
>> the
>> newly switched task which gets then killed by the watchdog ?
>
> Unlikely, but possible, if the CDL task takes ages to run the mode
> switching code, and gets caught by the watchdog tick before it had a
> chance to eventually suspend from primary mode.
>

Another possibility is a hole in Xenomai/I-pipe fpu logic which causes the
trap to trigger again and again when trying to relax because of the
bounce.
A trace from the I-pipe tracer would help here.

-- 
                                            Gilles.
https://click-hack.org


