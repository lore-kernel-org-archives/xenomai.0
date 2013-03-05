Message-ID: <5135F2F2.1020407@xenomai.org>
Date: Tue, 05 Mar 2013 14:28:18 +0100
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
In-Reply-To: <CAMJ=MEf7VMen7ikfPFpR=4J4SksHT0yiGpOOZySxNcPfezUfcQ@mail.gmail.com>
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

On 03/05/2013 01:43 PM, Ronny Meeus wrote:
>
> I'm able to reproduce the issue on a small test build:
>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/mman.h>
> #include <psos.h>
> #include <copperplate/init.h>
> #include <stdlib.h>
> #include <string.h>
>
> static void foo (u_long a0, u_long a1, u_long a2, u_long a3)
> {
>          u_long ret, ev = 0, tmid,tmid2;
>
>          ret = tm_evevery(1,1,&tmid);
>          ret = tm_evafter(30000,4,&tmid2);
>          while (1) {
>                  ret = ev_receive(0xFF,EV_ANY|EV_WAIT,0,&ev);

Can you check the return vakue here?

-- 
Philippe.

