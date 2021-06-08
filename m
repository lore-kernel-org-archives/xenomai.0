Subject: Re: problems installing Xenomai 3.1 in Ubuntu 20.04
References: <CAB9YM8hS5tg+mK_uVs3qe8A=4NXOk-KVJq1FXrVPRG5GcFU-EQ@mail.gmail.com>
 <b212b335-7aee-acd4-c809-3dafb937eb9e@siemens.com>
 <CAB9YM8i-cVW8SycKU64L3_9_miFT595WiGhtWDPXa7L5F6wOLw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <239c15e7-dcd4-6f97-3a8c-7e4ddf374003@siemens.com>
Date: Tue, 8 Jun 2021 18:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAB9YM8i-cVW8SycKU64L3_9_miFT595WiGhtWDPXa7L5F6wOLw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Jo=c3=a3o_Costa?= <joaocostalapin@gmail.com>
Cc: xenomai@xenomai.org

On 08.06.21 17:16, João Costa wrote:
> I was able to move forward but I got stuck in this error when I tried to
> execute the latency test:
> 
>     xxx@hypertests:/usr/lib/xenomai/testsuite$ ./latency
>        0"000.000| BUG in low_init(): [main] Cobalt core not enabled in
>     kernel
> 
> 
> I used the pre-patched kernel [1] and used the "instruction sequencing
> #1" presented below.
> 
> I assumed that the cobalt kernel/support is already embedded/patched in
> this pre-patched version. However, since the wiki points to the lack of
> cobalt support [2], this assumption may not be correct and/or I may be
> missing some steps.
> 
> What does the pre-patched kernel includes?  
> 

Die Wiki is actually right: You do need to run the prepare script. If
the target kernel happens to already contain the I-pipe (or, soon,
dovetail) patch, that part of the preparation is automatically skipped.

> As a shot in the dark, I also tried to enable the cobalt core (running
> the instructions below after decompressing the ipipe-x96*) but got stuck
> when compiling and generating the debian packages (it just freezed there) 
> 
>     $ cd xenomai-3.1/scripts/
>     $ ./prepare-kernel.sh
>     --linux=/home/xxx/ipipe-x86-ipipe-core-5.4.105-x86-4--arch=x86_64
>     --outpatch=/home/xxx/cobalt-core-3.1-5.4.105.patch
>     $ cd ~/ipipe-x86-ipipe-core-5.4.105-x86-4/
>     $ patch -p1 < ../cobalt-core-3.1-5.4.105.patch
> 

You can just run "./prepare-kernel.sh --linux=... --arch=...", no need
to route out the cobalt patch first. Just like the wiki does.

If you have improvement suggestions for the wiki, please fork the
project (https://source.denx.de/Xenomai/xenomai/-/wikis/git_access) and
submit patches against.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

