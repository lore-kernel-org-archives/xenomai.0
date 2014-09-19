Message-ID: <541C5F77.8050909@xenomai.org>
Date: Fri, 19 Sep 2014 18:53:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CALe7ZU0q+9ymAuFSJ=dCkh_+o=pzLrRe0qj31w+WVPjKUpP5Fw@mail.gmail.com>
 <541C16C3.9070101@xenomai.org>
 <CALe7ZU36HSdTihuwJ7_CBBD+eCyecPr2DvmWyGTxeonRiajmVQ@mail.gmail.com>
 <541C1B95.5070408@xenomai.org>
 <4faca0bdd03570d3af0d0af9940fe7c7.squirrel@wandercraft.eu>
In-Reply-To: <4faca0bdd03570d3af0d0af9940fe7c7.squirrel@wandercraft.eu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] clock_gettime cause runaway thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: huy-cong.vu@wandercraft.eu, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: JAY KOTHARI <jaikothari10@gmail.com>

On 09/19/2014 06:11 PM, huy-cong.vu@wandercraft.eu wrote:
> Hello everyone,
> I'm currently working with Xenomai in my company's project using RTNet as
> realtime ethernet driver to communicate with Elmo card via EtherCAT
> protocol and SOEM as master library.
> 
> I'm using Linux 3.8.13 patched with Xenomai 2.6.3.
> 
> I'm debugging a simple test which is a cycle of send & receive data with a
> frequency of 1 kHz. The test runs fine for a quite long time (30 mins in
> average), but still throws runaway thread after a certain time.
> 
> My loop is a periodic thread:
> 
> rt_task_set_periodic(rt_task_self(), TM_NOW, 1000000);
> while(1){
> rt_task_wait_period();
> ec_send_processdata();     //SOEM function
> ec_receive_processdata();  //SOEM function
> }
> 
> With SIGDEBUG & gdb, the error seems to start from clock_gettime (when
> ec_receive_processdata is called) with CLOCK_MONOTONIC, change to
> CLOCK_REALTIME reproduces the same issue. My processor is x86_64, I heard
> that the High Resolution Timer of Linux kernel is not supported for
> processor 64 bits, this could be the reason for such behavior?
> 

I never heard about the restriction you are referring to.

> Reading this mailing conversation:
> http://www.xenomai.org/pipermail/xenomai/2013-March/028021.html, I
> understand that I have to put thread on sleep while not running, but even
> with rt_task_sleep inserted, is not better. I don't know neither if
> something could've occupied 100% CPU (while my task normally runs with
> 0.2% CPU occupied).
> 
> I'm running out of ideas for now. I'm very grateful for any suggestions.
> Thank you in advance! (and sorry for my english)
> 

What about testing the return value of rt_task_wait_period()?

-- 
Philippe.

