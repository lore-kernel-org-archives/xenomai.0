Sender: chensong_2000@189.cn
Subject: Re: y2038: Migrate from syscall() to XENOMAI_SYSCALLx()
References: <20210507140559.1099146-1-florian.bezdeka@siemens.com>
From: Song Chen <chensong_2000@189.cn>
Message-ID: <6095EC1E.7000601@189.cn>
Date: Sat, 8 May 2021 09:40:46 +0800
MIME-Version: 1.0
In-Reply-To: <20210507140559.1099146-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org

noticed, i will submit a patch to address it specifically.

Song


On 2021年05月07日 22:05, Florian Bezdeka wrote:
> Hi Song,
>                                                                           
> you may have already noticed that we had a problem running the y2038 on
> some ARM boards. The problem was detected once Jan picked the series of
> the sem_timedwait64 implementation into next and triggered a test run on
> real hardware.
>                                                                           
> As a result I had to migrate from syscall() to XENOMAI_SYSCALLx().
>                                                                           
> As the acutal change is hard to find in v4 that I recently pushed to the
> list: Here is "patch" that shows the pattern I used.
>                                                                           
> Sadly replacing the function call is not enough because glibc
> "communicates" using "errno", while the Xenomai interface does not.
>                                                                           
> How to deal with your patches? Any chance that you could "migrate"
> as well? Or should I try to find some time to do that?
>
> Best regards,
> Florian
>


