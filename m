Message-ID: <513725F3.6000404@xenomai.org>
Date: Wed, 06 Mar 2013 12:18:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEfo5EU2mnM4=JDNU4QXX00W=0aC2+m5LucPYiN39W5wcQ@mail.gmail.com>
	<512FB9B5.9040709@xenomai.org>
	<CAAXf6LXDSxU_eASbHOgQzw_2xSpZua2BaORAiJ59KoPitFNEcg@mail.gmail.com>
	<51306545.1010200@xenomai.org> <5130663F.7070209@xenomai.org>
	<51306710.5030201@xenomai.org> <5130673D.2090700@xenomai.org>
	<513069D5.1090508@xenomai.org>
	<CAMJ=MEdAfvwWhjc4SLPk5smh+vNbPDJP=kM3bBFdw6n3bJd_mg@mail.gmail.com>
	<CAMJ=MEf7VMen7ikfPFpR=4J4SksHT0yiGpOOZySxNcPfezUfcQ@mail.gmail.com>
	<5135FC42.3010606@xenomai.org>
	<CAMJ=MEccwvx-__TQZZdAzxmb=cuzivG_kUkKxU65V=R3a5yuTw@mail.gmail.com>
	<513723EC.6070203@xenomai.org>
In-Reply-To: <513723EC.6070203@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: thread using 100% cpu load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 03/06/2013 12:09 PM, Philippe Gerum wrote:
>> do you have a reference to the issue that you are suspecting and a
>
> Nothing specific I can confirm yet.
>
>> view on which version of the glib we need to use to solve it?
>>
>>
>
> So far I have the test running fine over glibc 2.15(x86) and eglibc
> 2.13(ppc). I have an outdated glibc 2.8(arm) I'm about to test which
> might give me a different status.
>
> I don't think I'll keep running timers over SIGEV_THREAD in the upcoming
> -forge work anyway, the spec leaves too much room for interpretation
> with respect to the underlying implementation. Typically, one server
> thread per-timer would be quite of a problem with legacy systems firing
> tenths of timeout timers used as plain watchdogs.
>

No luck, 2.8 works fine too. Could you strace your small example on the 
failing system for a few seconds until the oneshot timer triggers, 
sending me the bzipped output log (privately)?

TIA,

-- 
Philippe.

