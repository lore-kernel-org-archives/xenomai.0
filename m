Message-ID: <5137439A.8080008@xenomai.org>
Date: Wed, 06 Mar 2013 14:24:42 +0100
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
In-Reply-To: <CAMJ=MEccwvx-__TQZZdAzxmb=cuzivG_kUkKxU65V=R3a5yuTw@mail.gmail.com>
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

On 03/06/2013 11:55 AM, Ronny Meeus wrote:

>> I can't reproduce this bug using that test code, over glibc 2.15/x86. We
>> might have a problem with SIGEV_THREAD. Which glibc release are you running?
>>
>
> Philip,
> do you have a reference to the issue that you are suspecting and a
> view on which version of the glib we need to use to solve it?
>

http://sourceware.org/bugzilla/show_bug.cgi?id=7094

I would definitely drop glibc 2.9 in our case.

-- 
Philippe.

